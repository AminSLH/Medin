import 'package:flutter/material.dart';
import 'package:medin/models/login.model.dart';
import 'package:medin/utils/keys.dart';
import 'package:medin/views/course.view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class SignUpViewModel with ChangeNotifier {
  final fbauth = FirebaseAuth.instance;
  FirebaseDatabase database = FirebaseDatabase.instanceFor(
      app: Firebase.app(),
      databaseURL:
          'https://medin-c092a-default-rtdb.europe-west1.firebasedatabase.app/');

  SignUpViewModel() {
    fbauth.authStateChanges().listen((User? user) {
      if (user != null) {
        navigatorKey.currentState
            ?.push(MaterialPageRoute(builder: (_) => CourseView()));
      }
    });
  }

  Future<void> createUser(
      String emailAddress,
      String password,
      String confirmPassword,
      String name,
      String phoneNumber,
      BuildContext context) async {
    DatabaseReference databaseRef = database.ref("users/");
    if (name.length < 3 || !RegExp(r'^[a-zA-Z ]+$').hasMatch(name)) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Please enter a valid name.'),
        duration: Duration(seconds: 2),
      ));
      return;
    }

    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(emailAddress)) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Please enter a valid email address.'),
        duration: Duration(seconds: 2),
      ));
      return;
    }

    if (password.length < 6 || password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content:
            Text('Passwords must match and contain at least 6 characters.'),
        duration: Duration(seconds: 2),
      ));
      return;
    }

    if (!RegExp(r'^\d{8}$').hasMatch(phoneNumber)) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Please enter a valid phone number.'),
        duration: Duration(seconds: 2),
      ));
      return;
    }

    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );

      FirebaseAuth.instance.userChanges().listen((User? user) async {
        if (user != null) {
          await databaseRef.child(user.uid).set({
            "email": emailAddress,
            "name": name,
            "number": phoneNumber,
            "role": "EndUser"
          });

          print('User is signed in!');
        }
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('The password provided is too weak.'),
          duration: Duration(seconds: 2),
        ));
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('An account already exists for that email.'),
          duration: Duration(seconds: 2),
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('There was an error creating your account.'),
          duration: Duration(seconds: 2),
        ));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('There was an error creating your account.'),
        duration: Duration(seconds: 2),
      ));
      print(e);
    }
  }
}
