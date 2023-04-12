import 'package:flutter/material.dart';
import 'package:student/firebase_data/auth_service.dart';

class SideDrawer extends StatelessWidget {
  const SideDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          const UserAccountsDrawerHeader(
            accountName: Text("Hello"),
            accountEmail: null,
            currentAccountPicture:  CircleAvatar(
              backgroundImage: AssetImage(
                  'assets/images/college_logo.png'), // replace with your image URL
            ),
          ),
          ListTile(
            leading: const Icon(Icons.help),
            title: const Text('Help'),
            onTap: () {
              // code
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              // code
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Log Out'),
            onTap: () {
              AuthService().signOut();

            },
          ),
        ],
      ),
    );
  }
}
