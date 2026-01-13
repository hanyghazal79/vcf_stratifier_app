import 'package:flutter/material.dart';

class AnimatedCounter extends StatelessWidget {
  final int value;
  final String label;
  final Color color;

  const AnimatedCounter({
    super.key,
    required this.value,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<int>(
      tween: IntTween(begin: 0, end: value),
      duration: const Duration(milliseconds: 1500),
      builder: (context, value, _) {
        return Column(
          children: [
            Text(
              value.toString(),
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              label,
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
          ],
        );
      },
    );
  }
}
