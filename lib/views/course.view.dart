import 'package:flutter/material.dart';
import 'package:medin/view_models/course.viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:medin/components/card_for_courses.dart';
import 'package:medin/models/course.model.dart';

class CourseView extends StatefulWidget {
  const CourseView({Key? key}) : super(key: key);

  @override
  State<CourseView> createState() => _CourseViewState();
}

class _CourseViewState extends State<CourseView> {
  late CourseViewModel _courseViewModel;
  late List<CourseModel> courseList;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CourseViewModel>(
        builder: (context, courseViewModel, child) => ListView.builder(
              itemCount: courseViewModel.course.length,
              itemBuilder: (context, index) {
                return CourseCard(
                    course: courseViewModel.course[index], key: UniqueKey());
              },
            ));
  }
}
