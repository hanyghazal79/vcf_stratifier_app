import 'package:flutter/material.dart';
import '../../../data/models/analysis_result.dart';
import 'widgets/overview_tab.dart';
import 'widgets/variants_tab.dart';
import 'widgets/charts_tab.dart';
import 'widgets/report_tab.dart';

class ResultsScreen extends StatelessWidget {
  final AnalysisResult result;

  const ResultsScreen({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Analysis Results - ${result.patientId}'),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.dashboard), text: 'Overview'),
              Tab(icon: Icon(Icons.table_chart), text: 'Variants'),
              Tab(icon: Icon(Icons.bar_chart), text: 'Charts'),
              Tab(icon: Icon(Icons.description), text: 'Report'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            OverviewTab(result: result),
            VariantsTab(result: result),
            ChartsTab(result: result),
            ReportTab(result: result),
          ],
        ),
      ),
    );
  }
}
