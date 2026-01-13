import 'package:equatable/equatable.dart';

enum Priority { high, medium, low }

class Recommendation extends Equatable {
  final Priority priority;
  final String title;
  final String description;
  final String rationale;

  const Recommendation({
    required this.priority,
    required this.title,
    required this.description,
    required this.rationale,
  });

  @override
  List<Object?> get props => [priority, title, description, rationale];

  Map<String, dynamic> toJson() => {
    'priority': priority.name,
    'title': title,
    'description': description,
    'rationale': rationale,
  };
}
