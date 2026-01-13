import 'package:flutter/material.dart';
import '../../../widgets/cards/feature_card.dart';

class FeatureGrid extends StatelessWidget {
  const FeatureGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Analysis Features',
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        const Row(
          children: [
            Expanded(
              child: FeatureCard(
                icon: Icons.science,
                title: '15 Genes',
                subtitle: 'Analyzed',
                color: Colors.blue,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: FeatureCard(
                icon: Icons.analytics,
                title: 'Real-time',
                subtitle: 'Processing',
                color: Colors.green,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        const Row(
          children: [
            Expanded(
              child: FeatureCard(
                icon: Icons.security,
                title: 'Local',
                subtitle: 'Processing',
                color: Colors.orange,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: FeatureCard(
                icon: Icons.description,
                title: 'PDF',
                subtitle: 'Reports',
                color: Colors.purple,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
