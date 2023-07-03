import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:medin/models/course.model.dart';
import 'package:intl/intl.dart' show DateFormat;

abstract class SuggestCoursesRepo extends ChangeNotifier {
  void addSuggestCourses(CourseModel courseModel);
}

class SuggestCoursesRepoImpl extends SuggestCoursesRepo {
  DatabaseReference? fbSuggestCoursesRef;
  FirebaseDatabase? fbDatabase;
  SuggestCoursesRepoImpl() {
    fbDatabase = FirebaseDatabase.instance;
    fbDatabase!.setPersistenceEnabled(true);
    fbSuggestCoursesRef = fbDatabase!.ref('Trainings');
  }
  @override
  void addSuggestCourses(CourseModel courseModel) {
    fbSuggestCoursesRef!.child(courseModel.id as String).set({
      'title': courseModel.title,
      'description': courseModel.description,
      'date': courseModel.date,
      'attendees': courseModel.attendees,
      'equipmentReserved': courseModel.equipmentReserved,
      'instructor': courseModel.instructor,
      'time': courseModel.time,
      'spotsAvailable': courseModel.seatsRemaining,
      'state': courseModel.state,
      'time': '09:30',
    });
  }
}
