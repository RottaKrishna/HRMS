import 'package:flutter/material.dart';
import 'package:hrms_flutter_application/screens/claims.dart';
import 'package:hrms_flutter_application/screens/leave_wfh_screen.dart';
import 'package:hrms_flutter_application/screens/profile.dart';
import 'package:hrms_flutter_application/screens/requests.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:hrms_flutter_application/screens/attendance_screen.dart';



class EmployeeDashboard extends StatefulWidget {
  @override
  _EmployeeDashboardState createState() => _EmployeeDashboardState();
}

class _EmployeeDashboardState extends State<EmployeeDashboard> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    EmployeeDashboardBody(),
    LeaveWFHScreen(),
    Requests(),
    AttendanceScreen1(),
    ClaimsPage(),
  ];

  void _onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => _screens[index]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: EmployeeDashboardBody(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: _onTap,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.time_to_leave), label: 'Apply Leave'),
          BottomNavigationBarItem(icon: Icon(Icons.request_page), label: 'Request'),
          BottomNavigationBarItem(icon: Icon(Icons.access_time), label: 'Attendance'),
          BottomNavigationBarItem(icon: Icon(Icons.receipt_long), label: 'Claims'),
        ],
      ),
    );
  }
}

// 👇 Separated out the dashboard content for reusability
class EmployeeDashboardBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // 🔷 AppBar
          AppBar(
            backgroundColor: Colors.blue,
            title: Row(
              children: [
                Icon(Icons.business, color: Colors.white),
                SizedBox(width: 8),
                Text("NebuLogic", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ],
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.notifications),
                onPressed: () {},
              ),
              Padding(
                padding: const EdgeInsets.only(right: 12),
                child: InkWell(
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage())),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, color: Colors.blue),
                  ),
                ),
              ),
            ],
          ),

          // 👤 Employee Info
          Card(
            margin: EdgeInsets.all(12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.blue.shade100,
                        child: Icon(Icons.person, size: 30, color: Colors.blue),
                      ),
                      SizedBox(height: 8),
                      Text("Krishna", style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("ID: 7224"),
                        Text("Designation: Software Developer"),
                        Text("Email: krishna.rotta@nebulogic.com"),
                        Text("Mobile: +91-9676104140"),
                        Text("Status: WFH"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 📊 Leave Overview
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                leaveCircle("Sick Leave", 3, 12, Colors.red),
                leaveCircle("Earned Leave", 6, 12, Colors.green),
                leaveCircle("Casual Leave", 2, 12, Colors.orange),
              ],
            ),
          ),

          // 📅 Events
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Upcoming Events", style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                eventTile(Icons.cake, "Vamsi's Birthday", "Office Cafeteria"),
                eventTile(Icons.event, "Team Meeting", "Conference Room A"),
                eventTile(Icons.celebration, "Annual Day", "Auditorium"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget leaveCircle(String label, int used, int total, Color color) {
    double percent = used / total;
    return Column(
      children: [
        CircularPercentIndicator(
          radius: 60.0,
          lineWidth: 8.0,
          percent: percent,
          center: Text("$used/$total"),
          progressColor: color,
          backgroundColor: Colors.grey.shade300,
        ),
        SizedBox(height: 6),
        Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget eventTile(IconData icon, String title, String location) {
    return Card(
      child: ListTile(
        leading: Icon(icon, color: Colors.blue),
        title: Text(title),
        subtitle: Text(location),
      ),
    );
  }
}

// 🧭 Dummy Screens for Navigation
class ApplyLeaveScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Apply Leave")),
      body: Center(child: Text("Apply Leave Screen")),
    );
  }
}

class RequestScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Request")),
      body: Center(child: Text("Request Screen")),
    );
  }
}

class AttendanceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Attendance")),
      body: Center(child: Text("Attendance Screen")),
    );
  }
}

class ClaimsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Claims")),
      body: Center(child: Text("Claims Screen")),
    );
  }
}
