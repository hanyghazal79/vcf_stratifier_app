import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class GeneBarChart extends StatelessWidget {
  final Map<String, int> geneData;

  const GeneBarChart({super.key, required this.geneData});

  @override
  Widget build(BuildContext context) {
    final sortedGenes = geneData.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return BarChart(
      BarChartData(
        maxY: sortedGenes.isNotEmpty
            ? sortedGenes.first.value.toDouble() * 1.2
            : 10,
        barGroups: _buildBarGroups(sortedGenes),
        titlesData: FlTitlesData(
          leftTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: true),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                if (value.toInt() < sortedGenes.length) {
                  return Text(
                    sortedGenes[value.toInt()].key,
                    style: const TextStyle(fontSize: 10),
                  );
                }
                return const Text('');
              },
            ),
          ),
        ),
      ),
    );
  }

  List<BarChartGroupData> _buildBarGroups(List<MapEntry<String, int>> data) {
    return List.generate(data.length, (index) {
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: data[index].value.toDouble(),
            color: Colors.blue,
            width: 20,
          ),
        ],
      );
    });
  }
}
