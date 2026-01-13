import 'package:flutter/material.dart';

import '../../../../data/models/analysis_result.dart';
import '../../../../data/models/genetic_variant.dart';

class VariantsTab extends StatelessWidget {
  final AnalysisResult result;

  const VariantsTab({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: const [
            DataColumn(label: Text('Gene')),
            DataColumn(label: Text('Position')),
            DataColumn(label: Text('Change')),
            DataColumn(label: Text('Type')),
            DataColumn(label: Text('Risk')),
          ],
          rows: result.variants.map((variant) {
            return DataRow(
              cells: [
                DataCell(Text(variant.gene)),
                DataCell(Text('${variant.chromosome}:${variant.position}')),
                DataCell(Text(variant.changeNotation)),
                DataCell(Text(variant.consequence ?? 'Unknown')),
                DataCell(
                  Chip(
                    label: Text(variant.riskLevel.displayName),
                    backgroundColor: _getRiskColor(variant.riskLevel),
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }

  Color _getRiskColor(RiskLevel level) {
    switch (level) {
      case RiskLevel.high:
        return Colors.red.shade100;
      case RiskLevel.moderate:
        return Colors.orange.shade100;
      case RiskLevel.vus:
        return Colors.purple.shade100;
      default:
        return Colors.green.shade100;
    }
  }
}
