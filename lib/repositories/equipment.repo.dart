import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medin/models/equipment.model.dart';
import 'package:firebase_database/firebase_database.dart';

abstract class EquipmentRepo extends ChangeNotifier {
  late List<EquipmentModel> equipmentList;
  late Map<dynamic, dynamic> data;
  List<EquipmentModel> fetchData();
}

class EquipmentRepoImpl extends EquipmentRepo {
  EquipmentRepoImpl() {
    // List<EquipmentModel> equipmentList =
    //     List<EquipmentModel>.empty(growable: true);

    final fbDatabase = FirebaseDatabase.instance;
    fbDatabase.setPersistenceEnabled(true);
    final fbEquipemtnRef = fbDatabase.ref("equipment");
    fbEquipemtnRef.keepSynced(true);

    fbEquipemtnRef.onValue.listen((event) {
      // Map<dynamic, dynamic> data =
      //     event.snapshot.value as Map<dynamic, dynamic>;
      // data.forEach((key, value) {
      //   equipmentList.add(EquipmentModel(
      //       id: key,
      //       description: value['description'],
      //       image: value['image'],
      //       title: value['title'],
      //       reservations: value['reservations'],
      //       type: value['type']));
      // });

      var data = event.snapshot.value as Map<dynamic, dynamic>;
      notifyListeners();
    });
  }

  @override
  List<EquipmentModel> fetchData() {
    //Future.delayed(const Duration(milliseconds: 1000));

    return [
      EquipmentModel(
        id: '6060601',
        image: 'assets/catalogue1.jpg',
        title: 'Equipement 1',
        description: 'Description 1 lorem ipsum lorem ipsum lorem ipsum',
        type: 'test type 1',
        reservations: 'test reservations 1',
      ),
      EquipmentModel(
        id: '6060602',
        image: 'assets/afdzcatalogue1.jpg',
        title: 'Equipement 2',
        description: 'Description 2 lorem ipsum lorem ipsum lorem ipsum',
        type: 'test type 1',
        reservations: 'test reservations 1',
      ),
      EquipmentModel(
        id: '6060603',
        image: 'assets/cataefdaefalogue1.jpg',
        title: 'Equipement 3',
        description: 'Description 3 lorem ipsum lorem ipsum lorem ipsum',
        type: 'test type 1',
        reservations: 'test reservations 1',
      ),
      EquipmentModel(
        id: '6060604',
        image: 'assets/aedcatalogue1.jpg',
        title: 'Equipement 4',
        description: 'Description 4 lorem ipsum lorem ipsum lorem ipsum',
        type: 'test type 1',
        reservations: 'test reservations 1',
      ),
    ];

    // return data;
  }
}
