import 'package:flutter/material.dart';
import 'package:medin/models/equipment.model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:medin/utils/keys.dart';
import 'package:medin/views/course.view.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:medin/repositories/equipment.repo.dart';

class EquipmentViewModel with ChangeNotifier {
  late EquipmentRepo equipmentRepo;
  late List<EquipmentModel> _equipment;
  List<EquipmentModel> get equipment => _equipment;

  EquipmentViewModel() {
    EquipmentRepo equipmentRepo =
        Provider.of<EquipmentRepo>(navigatorKey.currentContext!, listen: true);
    _equipment = equipmentRepo.fetchData();
    notifyListeners();
    equipmentRepo.addListener(() {
      _equipment = equipmentRepo.fetchData();
      notifyListeners();
    });
  }
}
