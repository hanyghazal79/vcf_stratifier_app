import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'presentation/providers/analysis_provider.dart';
import 'presentation/providers/theme_provider.dart';
import 'presentation/providers/export_provider.dart';
import 'presentation/screens/home/home_screen.dart';
import 'core/theme/app_theme.dart';

class VCFStratifierApp extends StatelessWidget {
  const VCFStratifierApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => AnalysisProvider()),
        ChangeNotifierProvider(create: (_) => ExportProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) {
          return MaterialApp(
            title: 'VCF Stratifier',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeProvider.themeMode,
            home: const HomeScreen(),
          );
        },
      ),
    );
  }
}
