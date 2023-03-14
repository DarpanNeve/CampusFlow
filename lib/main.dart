import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:student/auth_service.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MaterialApp(
      home: AuthService().handleAuthState(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Hello",
      home: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.lightBlue.shade300, Colors.white])),
          child: ListView(
            children: <Widget>[
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(
                      height: 100,
                    ),
                    const Image(
                      width: 200,
                      image: AssetImage('assets/images/collegelogo.png'),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    const SizedBox(
                      width: 400,
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Enter the ID',
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    const SizedBox(
                      width: 400,
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Enter the Password',
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    const AnotherPage(),
                    GestureDetector(
                      onLongPress: () {
                        const MyApp();
                      },
                      child: Image.asset(
                        'assets/images/googlelogo.png',
                        fit: BoxFit.cover,
                        width: 50,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AuthService().signInWithGoogle();
      },
      child: const ElevatedButton(
        onPressed: null,
        child: Text("Login"),
      ),
    );
  }
}

class AnotherPage extends StatelessWidget {
  const AnotherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        await AuthService().signInWithGoogle();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MyApp()),
        );
      },
      child: const Text("Login"),
    );
  }
}
