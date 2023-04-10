import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../UserModel.dart';
import '../main.dart';
import '../profile.dart';
import 'package:http/http.dart' as http;

List<UserModel> _userDataList = [];

class AuthService {
  handleAuthState() {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
        if (snapshot.hasData) {
          User? user = snapshot.data;
          String? email = user?.email;
          print(email);

          if (email!.contains("@pccoepune.org")) {
            getUserData(email);
            if (_userDataList.length==1) {
              print("verification initiated");

              return OptionMenuPage(name: _userDataList[0].name.toString(), pRN: _userDataList[0].prn.toString(), rollNo: _userDataList[0].rollNo.toString(), division: _userDataList[0].division.toString(), branch: _userDataList[0].branch.toString(), url: user!.photoURL.toString());
            } else {
              print("verification not initiated");

              signOut();
              return const MyApp();
            }
          } else {
            print("email do not contain Pccoe domain");
            signOut();
            return const MyApp();
          }
        } else {
          print("snapshot doesn't have Pccoe data");

          return const MyApp();
        }
      },
    );
  }

  signInWithGoogle() async {
    if (defaultTargetPlatform == TargetPlatform.android ||
        defaultTargetPlatform == TargetPlatform.iOS) {
      // Trigger the authentication flow

      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
      await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } else {
      GoogleAuthProvider googleProvider = GoogleAuthProvider();

      googleProvider
          .addScope('https://www.googleapis.com/auth/contacts.readonly');
      googleProvider.setCustomParameters({'login_hint': 'user@example.com'});
      return await FirebaseAuth.instance.signInWithPopup(googleProvider);
    }
  }

  signOut() async {
    _userDataList=[];
    await GoogleSignIn().signOut();
    await FirebaseAuth.instance.signOut();
  }

  Future<List<UserModel>> getUserData(String email) async {
    final response = await http.post(Uri.parse("$url/fetch_user.php"), body: {
      "Email": email,
    });
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map i in data) {
        _userDataList.add(UserModel.fromJson(i));
      }
      print(response.toString());
      print("length after request");
      print(_userDataList.length);
      return _userDataList;
    } else {
      return [];
    }
  }
}