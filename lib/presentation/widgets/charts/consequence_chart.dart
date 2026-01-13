import 'package:flutter/material.dart';

class ConsequenceChart extends StatelessWidget {
  final Map<String, int> consequenceData;

  const ConsequenceChart({super.key, required this.consequenceData});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: consequenceData.length,
      itemBuilder: (context, index) {
        final entry = consequenceData.entries.elementAt(index);
        return ListTile(
          title: Text(entry.key),
          trailing: Chip(label: Text(entry.value.toString())),
        );
      },
    );
  }
}
