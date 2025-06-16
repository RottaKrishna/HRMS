import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hrms_flutter_application/Vamsi_colors.dart';

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
              pressedColor: AppColors.agreedPurple,
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

// ========================
// Documents Page Widget
// ========================
class DocumentsPage extends StatelessWidget {
  const DocumentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Documents Page',
      style: Theme.of(context).textTheme.headlineSmall,
    );
  }
}

// ========================
// Payslips Page Widget
// ========================
class PayslipsPage extends StatelessWidget {
  const PayslipsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Payslips Page',
      style: Theme.of(context).textTheme.headlineSmall,
    );
  }
}
