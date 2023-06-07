import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:medin/utils/keys.dart';
import 'package:medin/views/login.view.dart';
import 'package:medin/models/user_medin.model.dart';

class ContentViewModel with ChangeNotifier {
  final fbauth = FirebaseAuth.instance;
  var currentUser = FirebaseAuth.instance.currentUser;

  ContentViewModel() {
    fbauth.authStateChanges().listen((User? user) {
      if (user == null) {
        navigatorKey.currentState
            ?.pushReplacement(MaterialPageRoute(builder: (_) => LoginView()));
      }
    });
  }

  void logout() async {
    await fbauth.signOut();
  }
}
