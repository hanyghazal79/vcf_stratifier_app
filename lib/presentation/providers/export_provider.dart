import 'package:flutter/foundation.dart';
import '../../data/models/analysis_result.dart';
import '../../services/pdf_service.dart';

class ExportProvider with ChangeNotifier {
  bool _isExporting = false;
  String? _error;

  bool get isExporting => _isExporting;
  String? get error => _error;

  Future<void> exportToPDF(AnalysisResult result) async {
    _isExporting = true;
    _error = null;
    notifyListeners();

    try {
      final pdfService = PDFService();
      await pdfService.generateReport(result);
    } catch (e) {
      _error = 'Failed to export PDF: $e';
    } finally {
      _isExporting = false;
      notifyListeners();
    }
  }
}
