import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hrms_flutter_application/Vamsi_colors.dart';
import 'package:hrms_flutter_application/screens/documents_page.dart';
import 'package:hrms_flutter_application/screens/payslips_page.dart';

class Requests extends StatefulWidget {
  const Requests({super.key});

  @override
  State<Requests> createState() => _RequestState();
}

class _RequestState extends State<Requests> {
  String selectedTab = 'Documents';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Requests')),
      body: Column(
        children: [
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: CupertinoSegmentedControl<String>(
              padding: const EdgeInsets.all(4),
              groupValue: selectedTab,
              selectedColor: AppColors.agreedPurple,
              borderColor: Colors.grey.shade400,
              pressedColor: AppColors.agreedPurple.withValues(alpha: 0.5),
              children: const {
                'Documents': Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: Text('Documents'),
                ),
                'Payslips': Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: Text('Payslips'),
                ),
              },
              onValueChanged: (value) {
                setState(() {
                  selectedTab = value;
                });
              },
            ),
          ),
          const SizedBox(height: 24),
          Expanded(
            child: Center(
              child: selectedTab == 'Documents'
                  ? const DocumentsPage()
                  : const PayslipsPage(),
            ),
          ),
        ],
      ),
    );
  }
}
