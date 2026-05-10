import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const RecipeBrowserApp());
}

class RecipeBrowserApp extends StatelessWidget {
  const RecipeBrowserApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipe Browser',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        useMaterial3: true, // Use this instead of useMaterialDesign
      ),
      home: const HomeScreen(),
    );
  }
}