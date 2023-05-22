import 'package:flutter/material.dart';
import 'package:medin/models/login.model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:medin/utils/keys.dart';
import 'package:medin/views/courses.view.dart';
import 'package:medin/views/equipment.view.dart';
import 'package:medin/views/content.view.dart';

class LoginViewModel with ChangeNotifier {
  final fbauth = FirebaseAuth.instance;
  LoginModel loginModel = LoginModel(email: 't', password: 't');

  LoginViewModel() {
    fbauth.authStateChanges().listen((User? user) {
      if (user != null) {
        navigatorKey.currentState
            ?.push(MaterialPageRoute(builder: (_) => ContentView()));
      }
    });
  }

  void updateEmail(String value) {
    loginModel = LoginModel(email: value, password: loginModel.password);
  }

  void updatePassword(String value) {
    loginModel = LoginModel(email: loginModel.email, password: value);
  }

  Future<bool> mailAuth() async {
    try {
      await fbauth.signInWithEmailAndPassword(
          email: loginModel.email, password: loginModel.password);
      debugPrint('true');
      return true;
    } on FirebaseAuthException catch (e) {
      ScaffoldMessengerState messengerState =
          scaffoldMessengerKey.currentState!;
      if (e.code == 'user-not-found') {
        messengerState.showSnackBar(
          SnackBar(
            content: Text('No user found for that email.'),
            showCloseIcon: true,
            duration: Duration(seconds: 2),
          ),
        );
      } else if (e.code == 'wrong-password') {
        messengerState.showSnackBar(
          SnackBar(
            content: Text('Wrong password.'),
            showCloseIcon: true,
            duration: Duration(seconds: 2),
          ),
        );
      } else {
        messengerState.showSnackBar(
          SnackBar(
            content: Text('Login Failed.'),
            showCloseIcon: true,
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
    debugPrint('false');
    return false;
  }
}
