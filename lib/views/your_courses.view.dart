import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:medin/view_models/course.viewmodel.dart';
import 'package:medin/components/card_for_your_courses.dart';

class YourCoursesView extends StatelessWidget {
  const YourCoursesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Vos formations'),
        ),
        body: Consumer<CourseViewModel>(
            builder: (context, courseViewModel, child) => ListView.builder(
                  itemCount: courseViewModel.course.length,
                  itemBuilder: (context, index) {
                    return YourCoursesCard(
                        course: courseViewModel.course[index],
                        key: UniqueKey());
                  },
                )));
  }
}
