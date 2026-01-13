class AppConstants {
  static const String appName = 'VCF Stratifier';
  static const String appVersion = '1.0.0';
  static const String appDescription =
      'Advanced VCF stratification and genetic risk assessment';

  static const int maxFileSizeMB = 100;
  static const List<String> supportedExtensions = ['vcf', 'vcf.gz'];

  static const int maxVariantsToDisplay = 1000;
  static const int maxVariantsInReport = 50;
  static const double minAlleleFrequency = 0.0001;

  static const double cardElevation = 2.0;
  static const double cardBorderRadius = 16.0;
  static const double buttonBorderRadius = 12.0;
  static const double defaultPadding = 16.0;

  static const Duration shortAnimation = Duration(milliseconds: 300);
  static const Duration mediumAnimation = Duration(milliseconds: 600);
  static const Duration longAnimation = Duration(milliseconds: 1500);

  static const int maxChartDataPoints = 20;
  static const double chartHeight = 300.0;

  static const String pdfReportPrefix = 'VCF_Stratification_Report';
  static const String jsonExportPrefix = 'VCF_Analysis_Data';
}
