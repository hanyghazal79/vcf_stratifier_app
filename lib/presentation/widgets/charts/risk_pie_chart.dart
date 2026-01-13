import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class RiskPieChart extends StatelessWidget {
  final Map<String, int> distribution;

  const RiskPieChart({super.key, required this.distribution});

  @override
  Widget build(BuildContext context) {
    return PieChart(
      PieChartData(
        sections: _buildSections(),
        sectionsSpace: 2,
        centerSpaceRadius: 40,
      ),
    );
  }

  List<PieChartSectionData> _buildSections() {
    final colors = {
      'High Risk': Colors.red,
      'Moderate': Colors.orange,
      'VUS': Colors.purple,
      'Low Risk': Colors.green,
    };

    return distribution.entries.where((e) => e.value > 0).map((entry) {
      return PieChartSectionData(
        value: entry.value.toDouble(),
        title: '${entry.key}\n${entry.value}',
        color: colors[entry.key] ?? Colors.grey,
        radius: 100,
        titleStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      );
    }).toList();
  }
}
