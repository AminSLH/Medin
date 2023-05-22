import 'package:flutter/material.dart';

class CoursesView extends StatefulWidget {
  const CoursesView({Key? key}) : super(key: key);

  @override
  _CoursesViewState createState() => _CoursesViewState();
}

class _CoursesViewState extends State<CoursesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Text("courses"));
  }
}
