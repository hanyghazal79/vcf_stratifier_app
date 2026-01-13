import 'package:vcf_stratifier_app/data/models/genetic_variant.dart';

abstract class IVCFRepository {
  Future<List<GeneticVariant>> parseVCFFile(String filePath);
  Future<void> saveAnalysisResult(String patientId, dynamic result);
  Future<dynamic> loadAnalysisResult(String patientId);
}
