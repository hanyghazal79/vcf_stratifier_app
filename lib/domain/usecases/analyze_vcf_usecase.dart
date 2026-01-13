import 'package:vcf_stratifier_app/data/models/genetic_variant.dart';

import '../repositories/i_vcf_repository.dart';

class AnalyzeVCFUseCase {
  final IVCFRepository repository;

  AnalyzeVCFUseCase(this.repository);

  Future<List<GeneticVariant>> execute(
    String filePath,
    String patientId,
  ) async {
    final variants = await repository.parseVCFFile(filePath);
    return variants;
  }
}
