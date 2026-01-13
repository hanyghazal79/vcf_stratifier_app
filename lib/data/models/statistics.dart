import 'package:equatable/equatable.dart';

class AnalysisStatistics extends Equatable {
  final int totalVariants;
  final int highRiskCount;
  final int moderateRiskCount;
  final int vusCount;
  final int lowRiskCount;
  final Map<String, int> geneDistribution;
  final Map<String, int> consequenceDistribution;
  final List<String> highRiskGenes;
  final List<String> affectedGenes;

  const AnalysisStatistics({
    required this.totalVariants,
    required this.highRiskCount,
    required this.moderateRiskCount,
    required this.vusCount,
    required this.lowRiskCount,
    required this.geneDistribution,
    required this.consequenceDistribution,
    required this.highRiskGenes,
    required this.affectedGenes,
  });

  @override
  List<Object?> get props => [
    totalVariants,
    highRiskCount,
    moderateRiskCount,
    vusCount,
    lowRiskCount,
  ];

  Map<String, dynamic> toJson() => {
    'total_variants': totalVariants,
    'high_risk_count': highRiskCount,
    'moderate_risk_count': moderateRiskCount,
    'vus_count': vusCount,
    'low_risk_count': lowRiskCount,
    'gene_distribution': geneDistribution,
    'consequence_distribution': consequenceDistribution,
    'high_risk_genes': highRiskGenes,
    'affected_genes': affectedGenes,
  };
}
