import 'package:flutter/material.dart';

import '../../../../data/models/analysis_result.dart';
import '../../../widgets/charts/gene_bar_chart.dart';
import '../../../widgets/charts/risk_pie_chart.dart';

class ChartsTab extends StatelessWidget {
  final AnalysisResult result;

  const ChartsTab({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Text(
                    'Risk Distribution',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 300,
                    child: RiskPieChart(distribution: _getRiskDistribution()),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Text(
                    'Variants by Gene',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 300,
                    child: GeneBarChart(
                      geneData: result.statistics.geneDistribution,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Map<String, int> _getRiskDistribution() {
    return {
      'High Risk': result.statistics.highRiskCount,
      'Moderate': result.statistics.moderateRiskCount,
      'VUS': result.statistics.vusCount,
      'Low Risk': result.statistics.lowRiskCount,
    };
  }
}
