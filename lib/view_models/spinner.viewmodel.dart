import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:medin/views/courses.view.dart';
import 'package:medin/views/login.view.dart';
import 'package:medin/utils/keys.dart';

class SpinnerViewModel with ChangeNotifier {
  late FirebaseAuth _auth;
  late User? _user;

  void refreshUser(User? new_user) {
    _user = new_user;
    notifyListeners();
    if (new_user == null) {
      navigatorKey.currentState
          ?.push(MaterialPageRoute(builder: (_) => LoginView()));
    } else {
      navigatorKey.currentState
          ?.push(MaterialPageRoute(builder: (_) => CoursesView()));
    }
  }

  SpinnerViewModel() {
    _auth = FirebaseAuth.instance;
    _user = _auth.currentUser;
    _auth.authStateChanges().listen(refreshUser);
  }

  User? get user => _user;
}
