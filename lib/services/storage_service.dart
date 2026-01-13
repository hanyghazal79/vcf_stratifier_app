// storage_service.dart - UPDATED
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/models/analysis_result.dart';

class StorageService {
  Future<void> saveAnalysisResult(AnalysisResult result) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'analysis_${result.patientId}';
    final jsonString = const JsonEncoder.withIndent(
      '  ',
    ).convert(result.toJson());
    await prefs.setString(key, jsonString);
  }

  Future<List<Map<String, dynamic>>> getSavedAnalyses() async {
    final prefs = await SharedPreferences.getInstance();
    final keys = prefs
        .getKeys()
        .where((key) => key.startsWith('analysis_'))
        .toList();

    final analyses = <Map<String, dynamic>>[];
    for (final key in keys) {
      final jsonString = prefs.getString(key);
      if (jsonString != null) {
        try {
          final data = jsonDecode(jsonString) as Map<String, dynamic>;
          analyses.add({
            'key': key,
            'data': data,
            'patientId': data['patientId'] ?? 'Unknown',
            'date': data['analysisDate'] ?? '',
          });
        } catch (e) {
          if (kDebugMode) {
            print('Error parsing $key: $e');
          }
        }
      }
    }

    return analyses;
  }

  Future<void> deleteAnalysis(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }
}
