import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

//Types of documents that can be requested
enum DocType { OfferLetter, NDA, Form16, BonafideCertificate}

class DocRequest{
  final DocType type;
  final DateTime date;
  final String status;

  DocRequest(this.type, this.date, this.status);
}



class DocumentsPage extends StatefulWidget {
  const DocumentsPage({super.key});

  State<DocumentsPage> createState() => _DocumentsPageState();
}

class _DocumentsPageState extends State<DocumentsPage> {
  final List<DocRequest> _requests = [
    DocRequest(DocType.OfferLetter, DateTime.now(), 'Approved'),
    DocRequest(DocType.NDA, DateTime.now(), 'Rejected'),
    DocRequest(DocType.Form16, DateTime.now(), 'Pending'),
  ];
  
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
            itemCount: _requests.length,
            itemBuilder: (context, index) {
              final request = _requests[index];
              return ListTile(
                leading: Icon(Icons.document_scanner, size: 36),
                title: Text(request.type.name),
                subtitle: Text(_formatDate(request.date)),
                trailing: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 4),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: _getStatusColor(
                          request.status,
                        ).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        request.status,
                        style: TextStyle(
                          color: _getStatusColor(request.status),
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
                showModalBottomSheet<void>(
                  context: context,
                  isScrollControlled: true,
                  builder: (BuildContext context) {
                    return AddDocRequest(onSubmit: _addDocRequest);
                  },
                );
              },
              child: const Icon(Icons.add), // or Icons.file_upload
            ),
          ),
        ],
      ),
    );
  }

  void _addDocRequest(DocRequest newRequest) {
    setState(() {
      _requests.add(newRequest);
    });
  }
}

class AddDocRequest extends StatefulWidget {
  final void Function(DocRequest) onSubmit;

  const AddDocRequest({super.key, required this.onSubmit});

  @override
  State<AddDocRequest> createState() => _addDocRequestState();
}

class _addDocRequestState extends State<AddDocRequest> {
  DocType selectedType = DocType.OfferLetter;

  void _submit() {
    final newRequest = DocRequest(selectedType, DateTime.now(), 'Pending');
    widget.onSubmit(newRequest);
    Navigator.of(context).pop();
  }


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButton<DocType>(
              value: selectedType,
              onChanged: (value) {
                if (value != null) {
                  setState(() => selectedType = value);
                }
              },
              items: DocType.values.map((type) {
                return DropdownMenuItem(value: type, child: Text(type.name));
              }).toList(),
            ),
            SizedBox(height: 10),
            ElevatedButton(onPressed: _submit, child: const Text('Add Request'))
          ],
        ),
      ),
    );
  }
}
