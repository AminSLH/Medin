import 'package:flutter/material.dart';
import 'package:medin/view_models/equipment.viewmodel.dart';
import 'package:medin/views/course.view.dart';
import 'package:provider/provider.dart';
import 'package:medin/components/card_for_equipment.dart';
import 'package:medin/models/equipment.model.dart';

class EquipmentView extends StatefulWidget {
  EquipmentView({Key? key}) : super(key: key);

  @override
  State<EquipmentView> createState() => _EquipmentViewState();
}

class _EquipmentViewState extends State<EquipmentView> {
  late EquipmentViewModel _equipmentViewModel;
  late List<EquipmentModel> equipmentList;

  @override
  void initState() {
    super.initState();

    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
  }

  @override
  Widget build(BuildContext context) {
    // _equipmentViewModel =
    //     Provider.of<EquipmentViewModel>(context, listen: true);
    // equipmentList = _equipmentViewModel.equipment;
    // print(equipmentList);
    return Consumer<EquipmentViewModel>(
        builder: (context, equipmentViewModel, child) => ListView.builder(
              itemCount: equipmentViewModel.equipment.length,
              itemBuilder: (context, index) {
                return EquipmentCard(
                    equipment: equipmentViewModel.equipment[index],
                    key: UniqueKey());
              },
            ));
  }
}
