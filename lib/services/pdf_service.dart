// ignore_for_file: depend_on_referenced_packages

import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import '../data/models/analysis_result.dart';
import 'package:pdf/pdf.dart';

class PDFService {
  Future<void> generateReport(AnalysisResult result) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (context) => [
          _buildHeader(result),
          pw.SizedBox(height: 20),
          _buildSummary(result),
          pw.SizedBox(height: 20),
          _buildStatistics(result),
          pw.SizedBox(height: 20),
          _buildRecommendations(result),
        ],
      ),
    );

    await Printing.layoutPdf(onLayout: (format) async => pdf.save());
  }

  pw.Widget _buildHeader(AnalysisResult result) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'VCF Stratification Report',
          style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold),
        ),
        pw.SizedBox(height: 10),
        pw.Text('Patient ID: ${result.patientId}'),
        pw.Text('Analysis Date: ${result.analysisDate}'),
      ],
    );
  }

  pw.Widget _buildSummary(AnalysisResult result) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(16),
      decoration: pw.BoxDecoration(
        border: pw.Border.all(),
        borderRadius: const pw.BorderRadius.all(pw.Radius.circular(8)),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            'Overall Risk: ${result.overallRisk.displayName}',
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
          ),
          pw.SizedBox(height: 8),
          pw.Text(result.riskInterpretation),
        ],
      ),
    );
  }

  pw.Widget _buildStatistics(AnalysisResult result) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'Statistics',
          style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
        ),
        pw.SizedBox(height: 10),
        pw.Text('Total Variants: ${result.statistics.totalVariants}'),
        pw.Text('High Risk: ${result.statistics.highRiskCount}'),
        pw.Text('VUS: ${result.statistics.vusCount}'),
      ],
    );
  }

  pw.Widget _buildRecommendations(AnalysisResult result) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'Recommendations',
          style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
        ),
        pw.SizedBox(height: 10),
        ...result.recommendations.map(
          (rec) => pw.Padding(
            padding: const pw.EdgeInsets.only(bottom: 8),
            child: pw.Bullet(text: '${rec.title}: ${rec.description}'),
          ),
        ),
      ],
    );
  }
}
