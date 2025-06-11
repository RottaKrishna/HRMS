import 'package:flutter/material.dart';
import 'package:hrms_flutter_application/profile.dart';

//Line added by Vamsi
//New Branch generated
//Tasks:
//1. Profile page
//2. Documents + Payslips page
//3. Claims page

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: Scaffold(body: ProfilePage()));
  }
}
