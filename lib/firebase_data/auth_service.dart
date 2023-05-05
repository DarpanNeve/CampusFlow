import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../main.dart';
import '../profile.dart';
import 'UserModel.dart';

List<UserModel> _userDataList = [];
late String userName, userPhoto;

class AuthService {
  handleAuthState() {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
        if (snapshot.hasData) {
          User? user = snapshot.data;
          String? email = user?.email;
          print("Email: $email");
          if (email!.contains("@pccoepune.org")) {
            print("User is from pccoepune.org domain. Fetching user data...");
            return FutureBuilder<List<UserModel>>(
              future: getUserData(email),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData && snapshot.data!.length == 1) {
                    userName = snapshot.data![0].name.toString();
                    userPhoto = user!.photoURL.toString();
                    print("User Name: $userName, User Photo: $userPhoto");

                    return OptionMenuPage(
                      name: snapshot.data![0].name.toString(),
                      pRN: snapshot.data![0].prn.toString(),
                      rollNo: snapshot.data![0].rollNo.toString(),
                      division: snapshot.data![0].division.toString(),
                      branch: snapshot.data![0].branch.toString(),
                      url: user.photoURL.toString(),
                    );
                  } else {
                    signOut();
                    print(
                        "User data is empty or has more than one entry. Signing out...");
                    return const MyApp();
                  }
                } else {
                  print("Fetching user data...");
                  return const MyApp();
                }
              },
            );
          } else {
            signOut();
            deleteUser();
            print(
                "User is not from pccoepune.org domain. Signing out and deleting user...");
            return const MyApp();
          }
        } else {
          print("No user is signed in.");
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
    _userDataList = [];
    if (defaultTargetPlatform == TargetPlatform.android ||
        defaultTargetPlatform == TargetPlatform.iOS) {
      await GoogleSignIn().signOut();
    }
    await FirebaseAuth.instance.signOut();
    print("User is signed out.");
  }

  Future<List<UserModel>> getUserData(String email) async {
    print("Fetching user data for email: $email");
    final dio = Dio();
    try {
      final response = await dio.post("$url/fetch_user.php",
          data: {
            "Email": email,
          },
          options: Options(contentType: Headers.formUrlEncodedContentType));
      print("Response status code: ${response.statusCode}");
      print("Response body: ${response.data}");
      if (response.statusCode == 200) {
        _userDataList.clear();
        var data = response.data;
        //var data = response.data.toString();
        print("data is ${data.toString()}");
        for (Map i in data) {
          _userDataList.add(UserModel.fromJson(i));
        }
        print("User data: $_userDataList");
        print("Response data: $data");
        return _userDataList;
      } else {
        throw Exception("Failed to fetch user data");
      }
    } on DioError catch (e) {
      if (e.response == null) {
        // Server returned an error response
        print('Error Response:');
        print('Status: ${e.response!.statusCode}');
        print('Data: ${e.response!.data}');
        print('Headers: ${e.response!.headers}');
        throw Exception("Failed to fetch user data");
      } else {
        // No response received from server
        print('Error: No response received from server.');
        throw Exception("Failed to fetch user data");
      }
    } catch (e) {
      // Some other error occurred
      print('Error: $e');
      throw Exception("Failed to fetch user data");
    }
  }

  void deleteUser() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    await user?.delete();
  }
}
