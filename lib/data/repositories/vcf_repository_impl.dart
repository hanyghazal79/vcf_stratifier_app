import 'package:vcf_stratifier_app/data/models/genetic_variant.dart';

import '../../domain/repositories/i_vcf_repository.dart';
import '../datasources/vcf_parser.dart';

class VCFRepositoryImpl implements IVCFRepository {
  final VCFParser _parser;

  VCFRepositoryImpl(this._parser);

  @override
  Future<List<GeneticVariant>> parseVCFFile(String filePath) async {
    final variants = await _parser.parseVCF(filePath);
    return variants;
    // return variants
    //     .map(
    //       (v) => VariantEntity(
    //         chromosome: v.chromosome,
    //         position: v.position,
    //         ref: v.ref,
    //         alt: v.alt,
    //         gene: v.gene,
    //       ),
    //     )
    //     .toList();
  }

  @override
  Future<void> saveAnalysisResult(String patientId, result) async {
    // Implementation for saving results
  }

  @override
  Future<dynamic> loadAnalysisResult(String patientId) async {
    // Implementation for loading results
    return null;
  }
}
