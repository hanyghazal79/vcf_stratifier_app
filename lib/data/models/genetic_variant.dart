import 'package:equatable/equatable.dart';

enum RiskLevel {
  high('High Risk'),
  moderate('Moderate Risk'),
  increased('Increased Risk'),
  vus('Variant of Uncertain Significance'),
  population('Population Risk');

  final String displayName;
  const RiskLevel(this.displayName);
}

class GeneticVariant extends Equatable {
  final String chromosome;
  final int position;
  final String ref;
  final String alt;
  final String gene;
  final String? rsid;
  final String? consequence;
  final double? gnomadAf;
  final String? clinvarSignificance;
  final RiskLevel riskLevel;

  const GeneticVariant({
    required this.chromosome,
    required this.position,
    required this.ref,
    required this.alt,
    required this.gene,
    this.rsid,
    this.consequence,
    this.gnomadAf,
    this.clinvarSignificance,
    this.riskLevel = RiskLevel.population,
  });

  String get changeNotation => '$ref>$alt';

  @override
  List<Object?> get props => [
    chromosome,
    position,
    ref,
    alt,
    gene,
    rsid,
    consequence,
    gnomadAf,
    clinvarSignificance,
    riskLevel,
  ];

  Map<String, dynamic> toJson() => {
    'chromosome': chromosome,
    'position': position,
    'ref': ref,
    'alt': alt,
    'gene': gene,
    'rsid': rsid,
    'consequence': consequence,
    'gnomad_af': gnomadAf,
    'clinvar_significance': clinvarSignificance,
    'risk_level': riskLevel.displayName,
  };
}
