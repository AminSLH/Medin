import 'package:flutter/material.dart';
import 'package:medin/components/card_for_equipment.dart';
import 'package:medin/models/equipment.model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';

abstract class EquipmentRepo extends ChangeNotifier {
  List<EquipmentModel> equipmentList =
      List<EquipmentModel>.empty(growable: true);
  late Map<dynamic, dynamic> data;
  List<EquipmentModel> fetchData();
  late Reference fbImagesRef;
}

class EquipmentRepoImpl extends EquipmentRepo {
  EquipmentRepoImpl() {
    final fbStorage = FirebaseStorage.instance;
    fbImagesRef = fbStorage.ref("images/equipment");

    equipmentList = List<EquipmentModel>.empty(growable: true);
    final fbDatabase = FirebaseDatabase.instance;
    fbDatabase.setPersistenceEnabled(true);
    final fbEquipemtnRef = fbDatabase.ref("equipment");
    fbEquipemtnRef.keepSynced(true);

    fbEquipemtnRef.onValue.listen((event) {
      Map<dynamic, dynamic> data =
          event.snapshot.value as Map<dynamic, dynamic>;
      data.forEach((key, value) async {
        // print("%%%%key: $key, value: $value%%%%");
        var url = (value['image'] == null)
            ? null
            : (await fbImagesRef.child(value['image']).getDownloadURL());
        print(url);
        equipmentList.add(EquipmentModel(
            id: key,
            description: value['description'],
            image: url,
            name: value['name'],
            reservations: value['reservations'].toString(),
            type: value['type']));
        notifyListeners();
      });
      // print(equipmentList);
    });
  }

  @override
  List<EquipmentModel> fetchData() {
    return equipmentList;
  }
}
