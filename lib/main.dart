import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const LennyApp());
}

class LennyApp extends StatelessWidget {
  const LennyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lenny',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF224F86),
        ),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
