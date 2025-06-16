import 'package:flutter/material.dart';
import 'package:hrms_flutter_application/Vamsi_colors.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          'Employee Profile',
          style: TextStyle(color: AppColors.textColorForPurple),
        ),
        backgroundColor: AppColors.agreedPurple,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 180,
            padding: const EdgeInsets.all(20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 120,
                  height: 120,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.asset('assets/maleavatar.jpg'),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15.0, left: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Bolisetti Sree Vamsi Krishna',
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                          ),
                        ),
                        Text('Software Developer'),
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'Employee ID: ',
                                style: TextStyle(color: Colors.grey),
                              ),
                              TextSpan(
                                text: 'Second Part',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          ProfileMenuWidget(
            title: 'Personal Info',
            icon: Icons.info,
            onPress: () {},
          ),
          ProfileMenuWidget(
            title: 'Documents',
            icon: Icons.edit_document,
            onPress: () {},
          ),
          ProfileMenuWidget(
            title: 'Certifications',
            icon: Icons.document_scanner,
            onPress: () {},
          ),
          ProfileMenuWidget(
            title: 'Projects',
            icon: Icons.mobile_screen_share_rounded,
            onPress: () {},
          ),
          ProfileMenuWidget(
            title: 'Achievements',
            icon: Icons.auto_graph_outlined,
            onPress: () {},
          ),
          const Divider(thickness: 0.1),
          SizedBox(height: 10),
          ProfileMenuWidget(
            title: 'Logout',
            icon: Icons.login_outlined,
            onPress: () {},
            endIcon: false,
          ),
        ],
      ),
    );
  }
}

class ProfileMenuWidget extends StatelessWidget {
  const ProfileMenuWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.onPress,
    this.endIcon = true,
  });

  final String title;
  final IconData icon;
  final VoidCallback onPress;
  final bool endIcon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: ListTile(
        onTap: onPress,
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: AppColors.agreedPurple.withValues(alpha: 0.1),
          ),
          child: Icon(icon, color: AppColors.agreedPurple),
        ),
        title: Text(title),
        trailing:
            endIcon
                ? Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.grey.withValues(alpha: 0.1),
                  ),
                  child: const Icon(
                    Icons.keyboard_arrow_right_outlined,
                    size: 25,
                    color: Colors.grey,
                  ),
                )
                : null,
      ),
    );
  }
}
