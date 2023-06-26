import 'package:flutter/material.dart';
import 'package:medin/models/course.model.dart';
import 'package:medin/utils/keys.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:medin/repositories/course.repo.dart';

class CourseViewModel with ChangeNotifier {
  late CourseRepo courseRepo;
  late List<CourseModel> _course;
  List<CourseModel> get course => _course;

  CourseViewModel() {
    CourseRepo courseRepo =
        Provider.of<CourseRepo>(navigatorKey.currentContext!, listen: true);
    _course = courseRepo.fetchData();
    notifyListeners();
    courseRepo.addListener(() {
      _course = courseRepo.fetchData();
      notifyListeners();
    });
  }
}
