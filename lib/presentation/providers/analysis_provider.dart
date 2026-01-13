import 'package:flutter/foundation.dart';
import '../../data/models/analysis_result.dart';
import '../../services/analysis_service.dart';
import '../../data/datasources/vcf_parser.dart';
import '../../services/classification_service.dart';
import '../../core/errors/error_handler.dart';

class AnalysisProvider with ChangeNotifier {
  AnalysisResult? _result;
  String? _selectedFileName;
  Uint8List? _selectedFileBytes;
  bool _isAnalyzing = false;
  double _progress = 0.0;
  String? _error;

  AnalysisResult? get result => _result;
  String? get selectedFilePath => _selectedFileName;
  Uint8List? get selectedFileBytes => _selectedFileBytes;
  bool get isAnalyzing => _isAnalyzing;
  double get progress => _progress;
  String? get error => _error;

  late final AnalysisService _analysisService;

  AnalysisProvider() {
    _analysisService = AnalysisService(VCFParser(), ClassificationService());
  }

  void setSelectedFile(String name, Uint8List bytes) {
    _selectedFileName = name;
    _selectedFileBytes = bytes;
    _error = null;
    notifyListeners();
  }

  Future<void> analyzeFile(String patientId) async {
    if (_selectedFileBytes == null) {
      _error = 'No file selected';
      notifyListeners();
      return;
    }

    _isAnalyzing = true;
    _progress = 0.0;
    _error = null;
    notifyListeners();

    try {
      _progress = 0.3;
      notifyListeners();

      final result = await _analysisService.analyzeFromBytes(
        _selectedFileBytes!,
        patientId,
      );

      _progress = 0.8;
      notifyListeners();

      _result = result;
      _progress = 1.0;
    } catch (e, stackTrace) {
      _error = ErrorHandler.getUserFriendlyMessage(e);
      ErrorHandler.logError(e, stackTrace);
    } finally {
      _isAnalyzing = false;
      notifyListeners();
    }
  }

  void clearAnalysis() {
    _result = null;
    _selectedFileName = null;
    _selectedFileBytes = null;
    _error = null;
    _progress = 0.0;
    notifyListeners();
  }
}
