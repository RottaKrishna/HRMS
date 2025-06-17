import 'package:flutter/material.dart';
import 'screens/splash_screen.dart'; // Import the splash screen

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(), // Set splash screen as the first screen
    );
  }
}
