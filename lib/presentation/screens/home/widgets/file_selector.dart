import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import '../../../providers/analysis_provider.dart';

class FileSelector extends StatelessWidget {
  final AnalysisProvider provider;

  const FileSelector({super.key, required this.provider});

  Future<void> _pickFile(BuildContext context) async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['vcf', 'gz'],
        withData: true, // IMPORTANT: Read file bytes
      );

      if (result != null && result.files.single.bytes != null) {
        provider.setSelectedFile(
          result.files.single.name,
          result.files.single.bytes!,
        );

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Selected: ${result.files.single.name}'),
              backgroundColor: Colors.green,
            ),
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: provider.isAnalyzing ? null : () => _pickFile(context),
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.upload_file, color: Colors.blue),
                  const SizedBox(width: 12),
                  Text(
                    'Select VCF File',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: Row(
                  children: [
                    Icon(
                      provider.selectedFilePath != null
                          ? Icons.check_circle
                          : Icons.insert_drive_file,
                      color: provider.selectedFilePath != null
                          ? Colors.green
                          : Colors.grey,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        provider.selectedFilePath ?? 'No file selected',
                        style: TextStyle(
                          color: provider.selectedFilePath != null
                              ? Colors.black87
                              : Colors.grey,
                        ),
                      ),
                    ),
                    if (provider.selectedFileBytes != null) ...[
                      const SizedBox(width: 8),
                      Chip(
                        label: Text(
                          _formatFileSize(provider.selectedFileBytes!.length),
                          style: const TextStyle(fontSize: 10),
                        ),
                        backgroundColor: Colors.blue.shade50,
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Supported formats: .vcf, .vcf.gz (max 50MB for web)',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.grey[600],
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatFileSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) {
      return '${(bytes / 1024).toStringAsFixed(2)} KB';
    }
    return '${(bytes / (1024 * 1024)).toStringAsFixed(2)} MB';
  }
}
