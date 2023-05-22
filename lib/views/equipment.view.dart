import 'package:flutter/material.dart';
import 'package:medin/view_models/equipment.viewmodel.dart';
import 'package:medin/views/courses.view.dart';
import 'package:provider/provider.dart';
import 'package:medin/components/card_for_equipment.dart';
import 'package:medin/models/equipment.model.dart';

class EquipmentView extends StatefulWidget {
  EquipmentView({Key? key}) : super(key: key);

  @override
  State<EquipmentView> createState() => _EquipmentViewState();
}

class _EquipmentViewState extends State<EquipmentView> {
  final _formKey = GlobalKey<FormState>();
  late EquipmentViewModel _equipmentViewModel;
  late List<EquipmentModel> equipmentList;

  @override
  void initState() {
    super.initState();
    _equipmentViewModel =
        Provider.of<EquipmentViewModel>(context, listen: false);
    equipmentList = _equipmentViewModel.equipment;
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: equipmentList.length,
        itemBuilder: (context, index) {
          return EquipmentCard(equipment: equipmentList[index]);
        },
      ),
    );
  }
}
