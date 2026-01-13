import 'package:flutter/material.dart';

import '../../../../data/models/analysis_result.dart';
import '../../../../data/models/genetic_variant.dart';
import '../../../../data/models/recommendation.dart';
import '../../../widgets/common/animated_counter.dart';

class OverviewTab extends StatelessWidget {
  final AnalysisResult result;

  const OverviewTab({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildSummaryCard(context),
          const SizedBox(height: 16),
          _buildStatsGrid(context),
          const SizedBox(height: 16),
          _buildInterpretationCard(context),
          const SizedBox(height: 16),
          _buildRecommendationsCard(context),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Icon(_getRiskIcon(), size: 64, color: _getRiskColor()),
            const SizedBox(height: 16),
            Text(
              result.overallRisk.displayName,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: _getRiskColor(),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Patient: ${result.patientId}',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsGrid(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: AnimatedCounter(
            value: result.statistics.totalVariants,
            label: 'Total Variants',
            color: Colors.blue,
          ),
        ),
        Expanded(
          child: AnimatedCounter(
            value: result.statistics.highRiskCount,
            label: 'High Risk',
            color: Colors.red,
          ),
        ),
        Expanded(
          child: AnimatedCounter(
            value: result.statistics.vusCount,
            label: 'VUS',
            color: Colors.orange,
          ),
        ),
      ],
    );
  }

  Widget _buildInterpretationCard(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Interpretation',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text(
              result.riskInterpretation,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecommendationsCard(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Recommendations',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ...result.recommendations.map(
              (rec) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: ListTile(
                  leading: Icon(_getPriorityIcon(rec.priority)),
                  title: Text(rec.title),
                  subtitle: Text(rec.description),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getRiskIcon() {
    switch (result.overallRisk) {
      case RiskLevel.high:
        return Icons.warning;
      case RiskLevel.moderate:
        return Icons.info;
      case RiskLevel.vus:
        return Icons.help;
      default:
        return Icons.check_circle;
    }
  }

  Color _getRiskColor() {
    switch (result.overallRisk) {
      case RiskLevel.high:
        return Colors.red;
      case RiskLevel.moderate:
        return Colors.orange;
      case RiskLevel.vus:
        return Colors.purple;
      default:
        return Colors.green;
    }
  }

  IconData _getPriorityIcon(Priority priority) {
    switch (priority.name) {
      case 'high':
        return Icons.priority_high;
      case 'medium':
        return Icons.circle;
      default:
        return Icons.circle_outlined;
    }
  }
}
