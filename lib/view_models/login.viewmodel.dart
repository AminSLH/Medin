import 'package:flutter/material.dart';
import 'package:medin/models/login.model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:medin/utils/keys.dart';
import 'package:medin/views/content.view.dart';

class LoginViewModel with ChangeNotifier {
  final fbauth = FirebaseAuth.instance;
  LoginModel loginModel = LoginModel(email: 't', password: 't');
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  LoginViewModel() {
    fbauth.authStateChanges().listen((User? user) {
      if (user != null) {
        navigatorKey.currentState?.pushReplacement(
            MaterialPageRoute(builder: (_) => const ContentView()));
      }
    });
  }

  Future<void> mailAuth() async {
    try {
      loginModel = LoginModel(
          email: emailController.text, password: passwordController.text);
      await fbauth.signInWithEmailAndPassword(
          email: loginModel.email, password: loginModel.password);
      debugPrint('true');
    } on FirebaseAuthException catch (e) {
      ScaffoldMessengerState messengerState =
          scaffoldMessengerKey.currentState!;
      if (e.code == 'user-not-found') {
        messengerState.showSnackBar(
          const SnackBar(
            content: Text('No user found for that email.'),
            showCloseIcon: true,
            duration: Duration(seconds: 2),
          ),
        );
      } else if (e.code == 'wrong-password') {
        messengerState.showSnackBar(
          const SnackBar(
            content: Text('Wrong password.'),
            showCloseIcon: true,
            duration: Duration(seconds: 2),
          ),
        );
      } else {
        messengerState.showSnackBar(
          const SnackBar(
            content: Text('Login Failed.'),
            showCloseIcon: true,
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
    debugPrint('false');
  }

  Future<void> guestAuth() async {
    try {
      await fbauth.signInAnonymously();
    } on FirebaseAuthException {
      ScaffoldMessengerState messengerState =
          scaffoldMessengerKey.currentState!;
      messengerState.showSnackBar(
        const SnackBar(
          content: Text('Failed to login as guest.'),
          showCloseIcon: true,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}
