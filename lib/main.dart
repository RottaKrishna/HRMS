import 'package:flutter/material.dart';
import 'package:hrms_flutter_application/claims.dart';
import 'package:hrms_flutter_application/profile.dart';
import 'package:hrms_flutter_application/requests.dart';

//Merge from branch to master by Vamsi.
//Very Minor changes to main file. Should override the original main file
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
    return const MaterialApp(home: Scaffold(body: Requests()));
  }
}
