import 'package:flutter/material.dart';
import 'package:hrms_flutter_application/colors.dart';
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
    return Container(
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
                        color: _getStatusColor(claim.status).withOpacity(0.1),
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
              onPressed: () {
                // TODO: show modal bottom sheet or dialog
                showModalBottomSheet(
                  context: context,
                  builder:
                      (context) => const Center(child: Text("New Claim Form")),
                );
              },
              child: const Icon(Icons.add), // or Icons.file_upload
            ),
          ),
        ],
      ),
    );
  }
}
