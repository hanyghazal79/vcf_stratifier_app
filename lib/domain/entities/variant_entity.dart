import 'package:equatable/equatable.dart';

class VariantEntity extends Equatable {
  final String chromosome;
  final int position;
  final String ref;
  final String alt;
  final String gene;

  const VariantEntity({
    required this.chromosome,
    required this.position,
    required this.ref,
    required this.alt,
    required this.gene,
  });

  @override
  List<Object?> get props => [chromosome, position, ref, alt, gene];
}
