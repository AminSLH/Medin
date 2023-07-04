import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:medin/utils/keys.dart';
import 'package:medin/views/login.view.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';

class ContentViewModel with ChangeNotifier {
  var database = FirebaseDatabase.instanceFor(
          app: Firebase.app(),
          databaseURL:
              'https://medin-c092a-default-rtdb.europe-west1.firebasedatabase.app/')
      .ref('users/${FirebaseAuth.instance.currentUser?.uid}')
      .child('name');
  final fbauth = FirebaseAuth.instance;
  var currentUser = FirebaseAuth.instance.currentUser;

  ContentViewModel() {
    fbauth.authStateChanges().listen((User? user) {
      if (user == null) {
        navigatorKey.currentState?.pushReplacement(
            MaterialPageRoute(builder: (_) => const LoginView()));
      }
    });
  }

  void logout() async {
    await fbauth.signOut();
  }
}
