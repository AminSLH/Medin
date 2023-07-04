import 'dart:math';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:medin/components/equipment_selector.dart';
import 'package:medin/models/course.model.dart';
import 'package:medin/models/equipment.model.dart';
import 'package:medin/repositories/equipment.repo.dart';
import 'package:medin/repositories/suggest_courses.repo.dart';
import 'package:medin/utils/keys.dart';
import 'package:provider/provider.dart';
import 'package:random_string/random_string.dart';
import 'package:intl/intl.dart' show DateFormat;

class SuggestCoursesViewModel with ChangeNotifier {
  final fbauth = FirebaseAuth.instance;

  final subjectController = TextEditingController();
  final equipmentController = TextEditingController();
  late DateTime date;
  final bodyController = TextEditingController();
  final numberOfSeatsController = TextEditingController();
  late SuggestCoursesRepo suggestCoursesRepo;
  List<String> selectedEquipment = [];
  late EquipmentRepo _equipmentRepo;
  late List<EquipmentModel> equipmentList;

  SuggestCoursesViewModel() {
    date = DateTime.now();
    suggestCoursesRepo = Provider.of<SuggestCoursesRepo>(
        navigatorKey.currentContext!,
        listen: true);
  }
  void submit() {
    suggestCoursesRepo.addSuggestCourses(CourseModel(
      id: randomAlphaNumeric(10).toUpperCase(),
      title: subjectController.text,
      description: bodyController.text,
      date: DateFormat('dd/MM/yyyy').format(date),
      attendees: Map<dynamic, dynamic>(),
      equipmentReserved: selectedEquipment,
      instructor: 'Amine',
      time: '09:15',
      seatsRemaining: int.parse(numberOfSeatsController.text),
      state: 'Requested',
    ));
    subjectController.clear();
    numberOfSeatsController.clear();
    equipmentController.clear();
    bodyController.clear();

    ScaffoldMessengerState messengerState = scaffoldMessengerKey.currentState!;
    messengerState.showSnackBar(
      const SnackBar(
        content: Text('Succès!'),
        showCloseIcon: true,
        duration: Duration(seconds: 5),
      ),
    );
    navigatorKey.currentState!.pop();
  }

  void selectEquipment() {
    _equipmentRepo =
        Provider.of<EquipmentRepo>(navigatorKey.currentContext!, listen: false);
    equipmentList = _equipmentRepo.fetchData();
    showDialog(
      context: navigatorKey.currentContext!,
      builder: (BuildContext context) {
        return EquipmentSelector(equipmentList: equipmentList);
      },
    );
  }
}
