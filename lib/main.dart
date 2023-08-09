import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:student/firebase_data/auth_service.dart';

import 'firebase_options.dart';

String url = "http://117.198.136.16";

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
  if (defaultTargetPlatform == TargetPlatform.android ||
      defaultTargetPlatform == TargetPlatform.iOS) {
    await Permission.storage.request();
  }
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
      theme: Theme.of(context).copyWith(
        colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: const Color(0xFF8ED7FA),
            ),
      ),
      title: "Hello",
      home: Scaffold(
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
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
                      image: AssetImage('assets/images/college_logo.png'),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    const SizedBox(
                      width: 300,
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
                      width: 300,
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
                      onTap: () {
                        AuthService().signInWithGoogle();
                      },
                      child: Image.asset(
                        'assets/images/google_logo.png',
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

class AnotherPage extends StatelessWidget {
  const AnotherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        AuthService().signInWithGoogle();
      },
      child: const Text(
        "Login",
        style: TextStyle(color: Colors.black),
      ),
    );
  }
}
