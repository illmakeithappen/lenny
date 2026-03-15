import 'package:flutter/material.dart';
import 'l10n/app_strings.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const TrainspotsApp());
}

class TrainspotsApp extends StatefulWidget {
  const TrainspotsApp({super.key});

  @override
  State<TrainspotsApp> createState() => _TrainspotsAppState();
}

class _TrainspotsAppState extends State<TrainspotsApp> {
  AppLanguage _language = AppLanguage.de;

  void _setLanguage(AppLanguage lang) {
    setState(() => _language = lang);
  }

  @override
  Widget build(BuildContext context) {
    return LanguageScope(
      language: _language,
      strings: AppStrings(_language),
      onLanguageChanged: _setLanguage,
      child: MaterialApp(
        title: 'Trainspots',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF224F86),
          ),
          useMaterial3: true,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}

/// Inherited widget to provide language / strings throughout the tree.
class LanguageScope extends InheritedWidget {
  final AppLanguage language;
  final AppStrings strings;
  final ValueChanged<AppLanguage> onLanguageChanged;

  const LanguageScope({
    super.key,
    required this.language,
    required this.strings,
    required this.onLanguageChanged,
    required super.child,
  });

  static LanguageScope of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<LanguageScope>()!;
  }

  @override
  bool updateShouldNotify(LanguageScope oldWidget) =>
      language != oldWidget.language;
}
