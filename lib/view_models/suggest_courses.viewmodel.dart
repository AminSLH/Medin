import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SuggestCoursesViewModel with ChangeNotifier {
  final fbauth = FirebaseAuth.instance;

  final subjectController = TextEditingController();
  final bodyController = TextEditingController();
}
