import 'package:flutter/material.dart';
import 'package:medin/models/course.model.dart';
import 'package:firebase_database/firebase_database.dart';

abstract class CourseRepo extends ChangeNotifier {
  List<CourseModel> courseList = List<CourseModel>.empty(growable: true);
  late Map<dynamic, dynamic> data;
  List<CourseModel> fetchData();
}

class CourseRepoImpl extends CourseRepo {
  CourseRepoImpl() {
    courseList = List<CourseModel>.empty(growable: true);
    final fbDatabase = FirebaseDatabase.instance;
    fbDatabase.setPersistenceEnabled(true);
    final fbCourseRef = fbDatabase.ref('Trainings');
    fbCourseRef.keepSynced(true);

    fbCourseRef.onValue.listen((event) {
      courseList.clear();
      Map<dynamic, dynamic> data =
          event.snapshot.value as Map<dynamic, dynamic>;
      data.forEach((key, value) async {
        if (value['state'] == 'Approved') {
          courseList.add(CourseModel(
            id: key,
            description: value['description'],
            title: value['title'],
            instructor: value['instructor'],
            date: value['date'],
            seatsRemaining: value['spotsAvailable'],
            time: null,
            attendees: value['attendees'],
            equipmentReserved: null,
            state: value['state'],
          ));
        }
        notifyListeners();
      });
    });
  }

  @override
  List<CourseModel> fetchData() {
    return courseList;
  }
}
