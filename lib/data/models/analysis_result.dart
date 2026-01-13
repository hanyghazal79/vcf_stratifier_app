import 'package:equatable/equatable.dart';
import 'genetic_variant.dart';
import 'recommendation.dart';
import 'statistics.dart';

class AnalysisResult extends Equatable {
  final String patientId;
  final DateTime analysisDate;
  final List<GeneticVariant> variants;
  final AnalysisStatistics statistics;
  final List<Recommendation> recommendations;
  final RiskLevel overallRisk;
  final String riskInterpretation;

  const AnalysisResult({
    required this.patientId,
    required this.analysisDate,
    required this.variants,
    required this.statistics,
    required this.recommendations,
    required this.overallRisk,
    required this.riskInterpretation,
  });

  @override
  List<Object?> get props => [
    patientId,
    analysisDate,
    variants,
    statistics,
    recommendations,
    overallRisk,
  ];

  Map<String, dynamic> toJson() => {
    'patient_id': patientId,
    'analysis_date': analysisDate.toIso8601String(),
    'variants': variants.map((v) => v.toJson()).toList(),
    'statistics': statistics.toJson(),
    'recommendations': recommendations.map((r) => r.toJson()).toList(),
    'overall_risk': overallRisk.displayName,
    'risk_interpretation': riskInterpretation,
  };
}
