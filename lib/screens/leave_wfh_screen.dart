import 'package:flutter/material.dart';
import 'package:intl/intl.dart';



class LeaveWFHScreen extends StatefulWidget {
  @override
  _LeaveWFHScreenState createState() => _LeaveWFHScreenState();
}

class _LeaveWFHScreenState extends State<LeaveWFHScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<Map<String, String>> leaveHistory = [];
  List<Map<String, String>> wfhHistory = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  void _openApplicationModal(bool isLeave) {
    String? selectedLeaveType;
    DateTime? startDate;
    DateTime? endDate;
    String reason = '';

    final formatter = DateFormat('dd/MM/yyyy');

    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      isDismissible: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: StatefulBuilder(
          builder: (context, setModalState) {
            int? duration;
            if (startDate != null && endDate != null) {
              duration = endDate!.difference(startDate!).inDays + 1;
            }

            return Container(
              padding: EdgeInsets.all(16),
              height: MediaQuery.of(context).size.height * 0.85,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                        child: Text(isLeave ? 'Apply for Leave' : 'Apply for WFH',
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
                    SizedBox(height: 20),
                    if (isLeave) ...[
                      Text("Select Leave Type"),
                      DropdownButtonFormField<String>(
                        items: [
                          DropdownMenuItem(value: 'SL', child: Text('Sick Leave')),
                          DropdownMenuItem(value: 'EL', child: Text('Earned Leave')),
                          DropdownMenuItem(value: 'CL', child: Text('Casual Leave')),
                        ],
                        onChanged: (val) => setModalState(() => selectedLeaveType = val),
                        decoration: InputDecoration(border: OutlineInputBorder()),
                      ),
                      SizedBox(height: 16),
                    ],
                    Text("Start Date"),
                    InkWell(
                      onTap: () async {
                        final picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2023),
                          lastDate: DateTime(2030),
                        );
                        if (picked != null) {
                          setModalState(() => startDate = picked);
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 14, horizontal: 12),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(startDate != null ? formatter.format(startDate!) : 'Select start date'),
                            Icon(Icons.calendar_today),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Text("End Date"),
                    InkWell(
                      onTap: () async {
                        final picked = await showDatePicker(
                          context: context,
                          initialDate: startDate ?? DateTime.now(),
                          firstDate: DateTime(2023),
                          lastDate: DateTime(2030),
                        );
                        if (picked != null) {
                          setModalState(() => endDate = picked);
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 14, horizontal: 12),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(endDate != null ? formatter.format(endDate!) : 'Select end date'),
                            Icon(Icons.calendar_today),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    if (duration != null)
                      Text("Duration: $duration days", style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 16),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Reason',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 3,
                      onChanged: (val) => reason = val,
                    ),
                    SizedBox(height: 24),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          if ((isLeave && selectedLeaveType == null) || startDate == null || endDate == null) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text('Please fill all required fields')));
                            return;
                          }

                          final application = {
                            'type': isLeave ? selectedLeaveType! : 'WFH',
                            'start': formatter.format(startDate!),
                            'end': formatter.format(endDate!),
                            'duration': '$duration',
                            'status': 'Pending',
                            'reason': reason
                          };

                          setState(() {
                            if (isLeave) {
                              leaveHistory.add(application);
                            } else {
                              wfhHistory.add(application);
                            }
                          });

                          Navigator.pop(context);
                        },
                        child: Text('Submit'),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildApplicationCard(Map<String, String> app) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      child: ListTile(
        leading: Icon(Icons.calendar_today, size: 32, color: Colors.blue),
        title: Text("${app['type']} - ${app['duration']} days"),
        subtitle: Text("${app['start']} to ${app['end']}"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isLeaveSelected = _tabController.index == 0;

    return Scaffold(
      appBar: AppBar(
        title: Text("Leave/WFH Application"),
        backgroundColor: Colors.blue,
        bottom: TabBar(
          controller: _tabController,
          tabs: [Tab(text: 'Leave'), Tab(text: 'WFH')],
          onTap: (_) => setState(() {}),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          leaveHistory.isEmpty
              ? Center(child: Text("No Leave Applications"))
              : ListView(
                  children: leaveHistory.map(_buildApplicationCard).toList(),
                ),
          wfhHistory.isEmpty
              ? Center(child: Text("No WFH Applications"))
              : ListView(
                  children: wfhHistory.map(_buildApplicationCard).toList(),
                ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openApplicationModal(_tabController.index == 0),
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
