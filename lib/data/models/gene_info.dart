import 'package:equatable/equatable.dart';

class GeneInfo extends Equatable {
  final String symbol;
  final String name;
  final String chromosome;
  final int start;
  final int end;
  final String riskLevel;
  final String description;
  final List<String> associatedConditions;

  const GeneInfo({
    required this.symbol,
    required this.name,
    required this.chromosome,
    required this.start,
    required this.end,
    required this.riskLevel,
    required this.description,
    required this.associatedConditions,
  });

  @override
  List<Object?> get props => [symbol, chromosome, start, end];

  static const Map<String, GeneInfo> knownGenes = {
    'BRCA1': GeneInfo(
      symbol: 'BRCA1',
      name: 'Breast Cancer 1',
      chromosome: '17',
      start: 43044295,
      end: 43125483,
      riskLevel: 'high',
      description: 'Tumor suppressor gene involved in DNA repair',
      associatedConditions: ['Breast cancer', 'Ovarian cancer'],
    ),
    'BRCA2': GeneInfo(
      symbol: 'BRCA2',
      name: 'Breast Cancer 2',
      chromosome: '13',
      start: 32889611,
      end: 32973805,
      riskLevel: 'high',
      description: 'DNA repair gene',
      associatedConditions: [
        'Breast cancer',
        'Ovarian cancer',
        'Prostate cancer',
      ],
    ),
  };
}
