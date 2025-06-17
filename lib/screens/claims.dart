import 'package:flutter/material.dart';
import 'package:hrms_flutter_application/Vamsi_colors.dart';
import 'package:intl/intl.dart';

enum ClaimType { Medical, Insurance, Transport, Food }

class Claim {
  final ClaimType type;
  final DateTime date;
  final int amount;
  final String status;

  Claim(this.type, this.date, this.amount, this.status);
}

class ClaimsPage extends StatefulWidget {
  const ClaimsPage({super.key});

  State<ClaimsPage> createState() => _ClaimsPageState();
}

class _ClaimsPageState extends State<ClaimsPage> {
  final List<Claim> claims = [
    Claim(ClaimType.Food, DateTime.now(), 450, 'Approved'),
    Claim(ClaimType.Transport, DateTime.now(), 300, 'Pending'),
    Claim(ClaimType.Medical, DateTime.now(), 1000, 'Rejected'),
  ];

  IconData _getIcon(ClaimType type) {
    switch (type) {
      case ClaimType.Food:
        return Icons.restaurant;
      case ClaimType.Transport:
        return Icons.directions_bus;
      case ClaimType.Medical:
        return Icons.local_hospital;
      default:
        return Icons.receipt;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Approved':
        return Colors.green;
      case 'Rejected':
        return Colors.red;
      case 'Pending':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  String _formatDate(DateTime date) {
    return DateFormat('dd MMM yyyy').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Claims')),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Stack(
          children: [
            ListView.builder(
              itemCount: claims.length,
              itemBuilder: (context, index) {
                final claim = claims[index];
                return ListTile(
                  leading: Icon(_getIcon(claim.type), size: 36),
                  title: Text(claim.type.name),
                  subtitle: Text(_formatDate(claim.date)),
                  trailing: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '₹${claim.amount}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 4),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: _getStatusColor(
                            claim.status,
                          ).withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          claim.status,
                          style: TextStyle(
                            color: _getStatusColor(claim.status),
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            Positioned(
              bottom: 16,
              right: 16,
              child: FloatingActionButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                onPressed: () {
                  // TODO: show modal bottom sheet or dialog
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) {
                      return Padding(
                        padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom,
                          top: 16,
                          left: 16,
                          right: 16,
                        ),
                        child: AddClaimForm(onSubmit: _addClaim),
                      );
                    },
                  );
                },
                child: const Icon(Icons.add), // or Icons.file_upload
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _addClaim(Claim newClaim) {
    setState(() {
      claims.add(newClaim);
    });
  }
}

class AddClaimForm extends StatefulWidget {
  final void Function(Claim) onSubmit;

  const AddClaimForm({super.key, required this.onSubmit});

  @override
  State<AddClaimForm> createState() => _AddClaimFormState();
}

class _AddClaimFormState extends State<AddClaimForm> {
  ClaimType selectedType = ClaimType.Medical;
  final amountController = TextEditingController();

  void _submit() {
    final amount = int.tryParse(amountController.text);
    if (amount == null) return;

    final newClaim = Claim(selectedType, DateTime.now(), amount, 'Pending');

    widget.onSubmit(newClaim);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        DropdownButton<ClaimType>(
          value: selectedType,
          onChanged: (value) {
            if (value != null) {
              setState(() => selectedType = value);
            }
          },
          items:
              ClaimType.values.map((type) {
                return DropdownMenuItem(value: type, child: Text(type.name));
              }).toList(),
        ),
        TextField(
          controller: amountController,
          decoration: const InputDecoration(labelText: 'Amount'),
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 16),
        ElevatedButton(onPressed: _submit, child: const Text('Add Claim')),
        const SizedBox(height: 16),
      ],
    );
  }
}
