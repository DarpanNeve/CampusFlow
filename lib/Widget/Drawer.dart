import 'package:flutter/material.dart';
import 'package:student/firebase_data/auth_service.dart';
import 'package:url_launcher/url_launcher.dart';

class SideDrawer extends StatelessWidget {
  const SideDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(userName, style: TextStyle(color: Colors.black)),
            accountEmail: null,
            currentAccountPicture: CircleAvatar(
              backgroundImage:
                  NetworkImage(userPhoto), // replace with your image URL
            ),
          ),
          // ListTile(
          //   leading: const Icon(Icons.help),
          //   title: const Text('Help'),
          //   onTap: () {
          //     // code
          //   },
          // ),
          // ListTile(
          //   leading: const Icon(Icons.settings),
          //   title: const Text('Settings'),
          //   onTap: () {
          //     // code
          //   },
          // ),
          ListTile(
            leading: const Icon(Icons.feedback),
            title: const Text('Feedback'),
            onTap: () async {
              Uri url = Uri.parse("https://forms.gle/C9ZQ8gKAKvdGDTJ5A");
              try {
                await _launchURL(url);
              } catch (e) {
                print(e);
              }
            },
            // onTap: () {
            //   launchURL("https://forms.gle/C9ZQ8gKAKvdGDTJ5A");
            //
            // },
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

launchURL(String url) async {
  url = Uri.encodeFull(url);
  if (await canLaunchUrl(url as Uri)) {
    await launchURL(url);
  } else {
    throw 'Unknown error, can\'t launch the URL.';
  }
}

Future<void> _launchURL(Uri url) async {
  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    throw 'Could not launch $url';
  }
}
