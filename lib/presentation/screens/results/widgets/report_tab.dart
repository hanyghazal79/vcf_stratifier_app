import 'package:flutter/material.dart';

import '../../../../data/models/analysis_result.dart';
import '../../../../services/pdf_service.dart';

class ReportTab extends StatelessWidget {
  final AnalysisResult result;

  const ReportTab({super.key, required this.result});

  Future<void> _exportPDF(BuildContext context) async {
    try {
      final pdfService = PDFService();
      await pdfService.generateReport(result);

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('PDF exported successfully')),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Clinical Report',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 16),
                  Text('Patient: ${result.patientId}'),
                  Text('Date: ${result.analysisDate}'),
                  Text('Risk: ${result.overallRisk.displayName}'),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: () => _exportPDF(context),
                    icon: const Icon(Icons.picture_as_pdf),
                    label: const Text('Export PDF'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
