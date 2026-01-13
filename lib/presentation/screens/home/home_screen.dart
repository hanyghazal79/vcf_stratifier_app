import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/analysis_provider.dart';
import '../../widgets/common/gradient_background.dart';
import '../results/results_screen.dart';
import 'widgets/feature_grid.dart';
import 'widgets/file_selector.dart';
import 'widgets/patient_info_form.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final _patientIdController = TextEditingController(text: 'P001');
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _patientIdController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _startAnalysis() async {
    final provider = context.read<AnalysisProvider>();

    if (provider.selectedFilePath == null) {
      _showSnackBar('Please select a VCF file first');
      return;
    }

    await provider.analyzeFile(_patientIdController.text);

    if (provider.error != null && mounted) {
      _showSnackBar(provider.error!);
    } else if (provider.result != null && mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ResultsScreen(result: provider.result!),
        ),
      );
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: Consumer<AnalysisProvider>(
            builder: (context, provider, _) {
              return FadeTransition(
                opacity: _fadeAnimation,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildHeader(),
                      const SizedBox(height: 32),
                      FileSelector(provider: provider),
                      const SizedBox(height: 24),
                      PatientInfoForm(controller: _patientIdController),
                      const SizedBox(height: 24),
                      const FeatureGrid(),
                      const SizedBox(height: 32),
                      _buildActionButton(provider),
                      if (provider.isAnalyzing) ...[
                        const SizedBox(height: 24),
                        _buildProgressIndicator(provider),
                      ],
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const Icon(Icons.biotech, size: 64, color: Colors.blue),
            const SizedBox(height: 16),
            Text(
              'VCF Stratifier',
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Advanced genetic variant stratification and risk assessment',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(AnalysisProvider provider) {
    return ElevatedButton(
      onPressed: provider.isAnalyzing ? null : _startAnalysis,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (provider.isAnalyzing)
            const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            )
          else
            const Icon(Icons.analytics),
          const SizedBox(width: 12),
          Text(
            provider.isAnalyzing ? 'Analyzing...' : 'Start Analysis',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressIndicator(AnalysisProvider provider) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            LinearProgressIndicator(
              value: provider.progress,
              minHeight: 8,
              borderRadius: BorderRadius.circular(4),
            ),
            const SizedBox(height: 12),
            Text(
              'Analyzing variants in breast cancer genes...',
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
