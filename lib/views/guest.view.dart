import 'package:flutter/material.dart';
import 'package:medin/views/course.view.dart';

class GuestView extends StatelessWidget {
  const GuestView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formations'),
      ),
      body: CourseView(),
    );
  }
}
