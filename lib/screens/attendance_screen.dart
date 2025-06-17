import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MaterialApp(home: AttendanceScreen1()));
}

class AttendanceScreen1 extends StatefulWidget {
  @override
  _AttendanceScreenState createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen1> {
  final List<int> years = [2022, 2023, 2024];
  final List<String> months = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
  ];

  int selectedYear = 2024;
  int selectedMonthIndex = DateTime.now().month - 1;

  List<Map<String, String>> generateDummyAttendance(BuildContext context) {
    List<Map<String, String>> list = [];
    Random random = Random();

    for (int day = 1; day <= 30; day++) {
      int checkInHour = 8 + random.nextInt(2); // 8–9 AM
      int checkInMin = random.nextInt(60);

      int checkOutHour = 17 + random.nextInt(2); // 5–6 PM
      int checkOutMin = random.nextInt(60);

      final checkIn = TimeOfDay(hour: checkInHour, minute: checkInMin);
      final checkOut = TimeOfDay(hour: checkOutHour, minute: checkOutMin);

      final checkInStr = checkIn.format(context);
      final checkOutStr = checkOut.format(context);

      final totalHours = "${checkOutHour - checkInHour} hrs "
          "${(checkOutMin - checkInMin).abs()} mins";

      list.add({
        'date': '$day',
        'checkIn': checkInStr,
        'checkOut': checkOutStr,
        'total': totalHours,
      });
    }

    return list;
  }

  @override
  Widget build(BuildContext context) {
    final dummyAttendance = generateDummyAttendance(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Attendance"),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          // Year Selector
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Text('Year: ', style: TextStyle(fontSize: 16)),
                SizedBox(width: 10),
                DropdownButton<int>(
                  value: selectedYear,
                  items: years
                      .map((y) => DropdownMenuItem(value: y, child: Text('$y')))
                      .toList(),
                  onChanged: (val) {
                    if (val != null) {
                      setState(() {
                        selectedYear = val;
                      });
                    }
                  },
                ),
              ],
            ),
          ),

          // Month Selector
          Container(
            height: 50,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: List.generate(months.length, (index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: ChoiceChip(
                      label: Text(months[index]),
                      selected: selectedMonthIndex == index,
                      onSelected: (_) {
                        setState(() {
                          selectedMonthIndex = index;
                        });
                      },
                      selectedColor: Colors.blue.shade300,
                      backgroundColor: Colors.grey.shade200,
                      labelStyle: TextStyle(
                        color: selectedMonthIndex == index ? Colors.white : Colors.black,
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),

          SizedBox(height: 10),

          // Attendance List
          Expanded(
            child: ListView.builder(
              itemCount: dummyAttendance.length,
              itemBuilder: (context, index) {
                final log = dummyAttendance[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.blue,
                      child: Text(
                        log['date']!,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    title: Text("Check-In: ${log['checkIn']}"),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Check-Out: ${log['checkOut']}"),
                        Text("Total Hours: ${log['total']}"),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
