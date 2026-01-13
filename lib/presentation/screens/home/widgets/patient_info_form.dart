import 'package:flutter/material.dart';

class PatientInfoForm extends StatelessWidget {
  final TextEditingController controller;

  const PatientInfoForm({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.person, color: Colors.blue),
                const SizedBox(width: 12),
                Text(
                  'Patient Information',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                labelText: 'Patient ID',
                prefixIcon: Icon(Icons.badge),
                hintText: 'Enter patient identifier',
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Patient data is processed locally for privacy',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey[600],
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
