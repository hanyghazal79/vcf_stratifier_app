class RiskThresholds {
  static const double rareVariantAF = 0.01;
  static const double commonVariantAF = 0.05;

  static const double highImpactScore = 0.8;
  static const double moderateImpactScore = 0.5;
  static const double lowImpactScore = 0.2;

  static const String highRiskColor = '#E53935';
  static const String moderateRiskColor = '#FF9800';
  static const String vusColor = '#9C27B0';
  static const String lowRiskColor = '#4CAF50';

  static const Map<String, double> consequenceWeights = {
    'frameshift': 1.0,
    'stop_gained': 1.0,
    'stop_lost': 0.9,
    'start_lost': 0.9,
    'splice_acceptor': 0.95,
    'splice_donor': 0.95,
    'missense': 0.5,
    'inframe_deletion': 0.6,
    'inframe_insertion': 0.6,
    'synonymous': 0.1,
  };

  static double getConsequenceWeight(String consequence) {
    for (final entry in consequenceWeights.entries) {
      if (consequence.toLowerCase().contains(entry.key)) {
        return entry.value;
      }
    }
    return 0.3;
  }
}
