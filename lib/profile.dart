
import 'package:flutter/material.dart';
import 'auth_service.dart';


class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "ProfilePage",
      home:Scaffold (
      body: Center(
        child: Column(
          children: const <Widget>[
            Text("Data"),
            Signoutbutton(),

          ],
        ),
      ),
      ),
    );
  }
}
class Signoutbutton extends StatelessWidget{
  const Signoutbutton({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ElevatedButton(onPressed: () {
      AuthService().signOut();
    },
      child: const Text("Logout"),

    );
  }

}
