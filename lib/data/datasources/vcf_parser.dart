import 'dart:convert';
import 'dart:typed_data';
import '../models/genetic_variant.dart';
import '../../core/constants/gene_coordinates.dart';
import '../../core/errors/app_exceptions.dart';

class VCFParser {
  // Parse from file bytes (web-compatible)
  Future<List<GeneticVariant>> parseFromBytes(Uint8List bytes) async {
    try {
      final content = utf8.decode(bytes);
      return _parseContent(content);
    } catch (e) {
      throw ParseException('Failed to parse VCF from bytes: $e');
    }
  }

  // Parse from string content
  Future<List<GeneticVariant>> parseFromString(String content) async {
    try {
      return _parseContent(content);
    } catch (e) {
      throw ParseException('Failed to parse VCF content: $e');
    }
  }

  // Legacy method for backward compatibility (throws on web)
  Future<List<GeneticVariant>> parseVCF(String filePath) async {
    throw ParseException(
      'File path parsing not supported on web. Use parseFromBytes() instead.',
    );
  }

  List<GeneticVariant> _parseContent(String content) {
    final lines = content.split('\n');
    final variants = <GeneticVariant>[];
    bool headerPassed = false;

    for (var line in lines) {
      if (line.isEmpty || line.startsWith('##')) continue;

      if (line.startsWith('#CHROM')) {
        headerPassed = true;
        continue;
      }

      if (!headerPassed) continue;

      final variant = _parseLine(line);
      if (variant != null) {
        variants.add(variant);
      }
    }

    return variants;
  }

  GeneticVariant? _parseLine(String line) {
    final parts = line.split('\t');
    if (parts.length < 5) return null;

    final chrom = _normalizeChromosome(parts[0]);
    final pos = int.tryParse(parts[1]) ?? 0;
    if (pos == 0) return null;

    final gene = _findGene(chrom, pos);
    if (gene == null) return null;

    final ref = parts[3];
    final alts = parts[4].split(',');
    final info = parts.length > 7 ? _parseInfo(parts[7]) : <String, String>{};

    if (alts.isEmpty || alts[0] == '.') return null;

    return GeneticVariant(
      chromosome: chrom,
      position: pos,
      ref: ref,
      alt: alts[0],
      gene: gene,
      rsid: parts[2].startsWith('rs') ? parts[2] : null,
      consequence:
          info['CSQ'] ??
          info['Consequence'] ??
          _predictConsequence(ref, alts[0]),
      gnomadAf: _parseAF(info['AF']),
      clinvarSignificance: info['CLNSIG'],
    );
  }

  String _normalizeChromosome(String chrom) {
    return chrom.replaceAll(RegExp(r'chr|Chr|CHR'), '').split(':')[0];
  }

  String? _findGene(String chrom, int pos) {
    for (final entry in GeneCoordinates.breastCancerGenes.entries) {
      final coords = entry.value;
      if (coords['chr'] == chrom &&
          pos >= coords['start'] &&
          pos <= coords['end']) {
        return entry.key;
      }
    }
    return null;
  }

  Map<String, String> _parseInfo(String info) {
    final result = <String, String>{};
    for (final field in info.split(';')) {
      if (field.contains('=')) {
        final parts = field.split('=');
        result[parts[0]] = parts[1];
      }
    }
    return result;
  }

  double? _parseAF(String? afStr) {
    return afStr != null ? double.tryParse(afStr) : null;
  }

  String _predictConsequence(String ref, String alt) {
    if (ref.length != alt.length) {
      return ref.length > alt.length ? 'deletion' : 'insertion';
    }
    return ref.length == 1 ? 'missense_variant' : 'unknown';
  }
}
