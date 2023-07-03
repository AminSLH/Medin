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
    final fbEquipemtnRef = fbDatabase.ref('Trainings');
    fbEquipemtnRef.keepSynced(true);

    fbEquipemtnRef.onValue.listen((event) {
      Map<dynamic, dynamic> data =
          event.snapshot.value as Map<dynamic, dynamic>;
      data.forEach((key, value) async {
        courseList.add(CourseModel(
          id: key,
          description: value['description'],
          title: value['title'],
          instructor: value['instructor'],
          date: value['date'],
          seatsRemaining: value['spotsAvailable'],
          time: null,
          attendees: null,
          equipmentReserved: null,
          state: null,
        ));
        notifyListeners();
      });
    });
  }

  @override
  List<CourseModel> fetchData() {
    return courseList;
  }
}
