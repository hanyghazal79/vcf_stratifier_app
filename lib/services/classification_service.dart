import '../data/models/genetic_variant.dart';
import '../core/constants/risk_thresholds.dart';
import '../core/constants/gene_coordinates.dart';

class ClassificationService {
  RiskLevel classifyVariant(GeneticVariant variant) {
    final clinvar = variant.clinvarSignificance?.toLowerCase() ?? '';

    if (clinvar.contains('pathogenic') && !clinvar.contains('likely')) {
      return RiskLevel.high;
    }
    if (clinvar.contains('likely pathogenic')) {
      return RiskLevel.high;
    }
    if (clinvar.contains('uncertain')) {
      return RiskLevel.vus;
    }
    if (clinvar.contains('benign')) {
      return RiskLevel.population;
    }

    final consequence = variant.consequence?.toLowerCase() ?? '';
    final weight = RiskThresholds.getConsequenceWeight(consequence);

    if (weight >= RiskThresholds.highImpactScore) {
      return GeneCoordinates.isHighRiskGene(variant.gene)
          ? RiskLevel.high
          : RiskLevel.moderate;
    }

    if (weight >= RiskThresholds.moderateImpactScore) {
      return GeneCoordinates.isHighRiskGene(variant.gene)
          ? RiskLevel.moderate
          : RiskLevel.vus;
    }

    return RiskLevel.population;
  }

  String getClinicalSignificance(RiskLevel level) {
    switch (level) {
      case RiskLevel.high:
        return 'Significantly increased breast cancer risk';
      case RiskLevel.moderate:
        return 'Moderately increased breast cancer risk';
      case RiskLevel.increased:
        return 'Slightly increased breast cancer risk';
      case RiskLevel.vus:
        return 'Clinical significance currently uncertain';
      case RiskLevel.population:
        return 'Likely benign with population-level risk';
    }
  }
}
