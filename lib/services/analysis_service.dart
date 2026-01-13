import 'dart:typed_data';
import '../data/models/genetic_variant.dart';
import '../data/models/analysis_result.dart';
import '../data/models/statistics.dart';
import '../data/models/recommendation.dart';
import '../data/datasources/vcf_parser.dart';
import 'classification_service.dart';

class AnalysisService {
  final VCFParser _parser;
  final ClassificationService _classifier;

  AnalysisService(this._parser, this._classifier);

  // Web-compatible method using bytes
  Future<AnalysisResult> analyzeFromBytes(
    Uint8List bytes,
    String patientId,
  ) async {
    final rawVariants = await _parser.parseFromBytes(bytes);
    return _processVariants(rawVariants, patientId);
  }

  // String-based method
  Future<AnalysisResult> analyzeFromString(
    String content,
    String patientId,
  ) async {
    final rawVariants = await _parser.parseFromString(content);
    return _processVariants(rawVariants, patientId);
  }

  // Legacy method (not web-compatible)
  Future<AnalysisResult> analyzeVCF(String filePath, String patientId) async {
    throw UnimplementedError('File path not supported on web');
  }

  Future<AnalysisResult> _processVariants(
    List<GeneticVariant> rawVariants,
    String patientId,
  ) async {
    // Classify variants
    final classifiedVariants = <GeneticVariant>[];
    for (final variant in rawVariants) {
      final riskLevel = _classifier.classifyVariant(variant);
      final classified = GeneticVariant(
        chromosome: variant.chromosome,
        position: variant.position,
        ref: variant.ref,
        alt: variant.alt,
        gene: variant.gene,
        rsid: variant.rsid,
        consequence: variant.consequence,
        clinvarSignificance: variant.clinvarSignificance,
        gnomadAf: variant.gnomadAf,
        riskLevel: riskLevel,
      );
      classifiedVariants.add(classified);
    }

    final stats = _calculateStatistics(classifiedVariants);
    final recommendations = _generateRecommendations(stats);
    final overallRisk = _calculateOverallRisk(stats);
    final interpretation = _generateInterpretation(stats, overallRisk);

    return AnalysisResult(
      patientId: patientId,
      analysisDate: DateTime.now(),
      variants: classifiedVariants,
      statistics: stats,
      recommendations: recommendations,
      overallRisk: overallRisk,
      riskInterpretation: interpretation,
    );
  }

  AnalysisStatistics _calculateStatistics(List<GeneticVariant> variants) {
    final highRisk = variants
        .where((v) => v.riskLevel == RiskLevel.high)
        .toList();
    final moderate = variants
        .where((v) => v.riskLevel == RiskLevel.moderate)
        .toList();
    final vus = variants.where((v) => v.riskLevel == RiskLevel.vus).toList();
    final low = variants
        .where((v) => v.riskLevel == RiskLevel.population)
        .toList();

    final geneDistribution = <String, int>{};
    for (final variant in variants) {
      geneDistribution[variant.gene] =
          (geneDistribution[variant.gene] ?? 0) + 1;
    }

    final consequenceDistribution = <String, int>{};
    for (final variant in variants) {
      final consequence = variant.consequence ?? 'unknown';
      consequenceDistribution[consequence] =
          (consequenceDistribution[consequence] ?? 0) + 1;
    }

    return AnalysisStatistics(
      totalVariants: variants.length,
      highRiskCount: highRisk.length,
      moderateRiskCount: moderate.length,
      vusCount: vus.length,
      lowRiskCount: low.length,
      geneDistribution: geneDistribution,
      consequenceDistribution: consequenceDistribution,
      highRiskGenes: highRisk.map((v) => v.gene).toSet().toList(),
      affectedGenes: geneDistribution.keys.toList(),
    );
  }

  List<Recommendation> _generateRecommendations(AnalysisStatistics stats) {
    final recommendations = <Recommendation>[];

    if (stats.highRiskCount > 0) {
      recommendations.add(
        const Recommendation(
          priority: Priority.high,
          title: 'Genetic Counseling Required',
          description:
              'Immediate referral to genetic counseling is strongly recommended',
          rationale: 'Pathogenic variants detected in high-risk genes',
        ),
      );

      recommendations.add(
        const Recommendation(
          priority: Priority.high,
          title: 'Enhanced Screening Protocol',
          description: 'Consider annual MRI in addition to mammography',
          rationale: 'Significantly increased breast cancer risk',
        ),
      );
    }

    if (stats.vusCount > 0) {
      recommendations.add(
        Recommendation(
          priority: Priority.medium,
          title: 'VUS Interpretation',
          description:
              'Expert interpretation of uncertain variants recommended',
          rationale: '${stats.vusCount} VUS variants require clarification',
        ),
      );
    }

    if (stats.highRiskCount == 0 && stats.vusCount == 0) {
      recommendations.add(
        const Recommendation(
          priority: Priority.low,
          title: 'Standard Screening',
          description: 'Continue with age-appropriate screening guidelines',
          rationale: 'No pathogenic variants detected',
        ),
      );
    }

    return recommendations;
  }

  RiskLevel _calculateOverallRisk(AnalysisStatistics stats) {
    if (stats.highRiskCount > 0) {
      return RiskLevel.high;
    } else if (stats.moderateRiskCount > 0) {
      return RiskLevel.moderate;
    } else if (stats.vusCount > 0) {
      return RiskLevel.vus;
    }
    return RiskLevel.population;
  }

  String _generateInterpretation(
    AnalysisStatistics stats,
    RiskLevel overallRisk,
  ) {
    if (stats.highRiskCount > 0) {
      return 'Analysis detected ${stats.highRiskCount} pathogenic variant(s) in genes: ${stats.highRiskGenes.join(", ")}. This indicates significantly increased hereditary breast cancer risk.';
    } else if (stats.vusCount > 0) {
      return 'Analysis detected ${stats.vusCount} variant(s) of uncertain significance. Further evaluation and genetic counseling recommended.';
    } else {
      return 'No pathogenic variants detected in analyzed breast cancer risk genes. Risk remains at population level.';
    }
  }
}
