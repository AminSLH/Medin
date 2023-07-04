import 'package:flutter/material.dart';
import 'package:medin/models/equipment.model.dart';
import 'package:medin/view_models/suggest_courses.viewmodel.dart';
import 'package:medin/utils/keys.dart';
import 'package:provider/provider.dart';

class EquipmentSelector extends StatefulWidget {
  final List<EquipmentModel> equipmentList;

  EquipmentSelector({Key? key, required this.equipmentList}) : super(key: key);

  @override
  _EquipmentSelectorState createState() => _EquipmentSelectorState();
}

class _EquipmentSelectorState extends State<EquipmentSelector> {
  List<bool> checkboxValues = [];
  final _suggestCoursesViewModel = Provider.of<SuggestCoursesViewModel>(
      navigatorKey.currentContext!,
      listen: false);
  @override
  void initState() {
    super.initState();
    // Initialize checkboxValues list with false for each item
    checkboxValues = List<bool>.filled(widget.equipmentList.length, false);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Checklist'),
      content: Column(
        children: widget.equipmentList.asMap().entries.map((entry) {
          final index = entry.key;
          final item = entry.value;
          return CheckboxListTile(
            title: Text(item.name!),
            value: checkboxValues[index],
            onChanged: (bool? value) {
              setState(() {
                checkboxValues[index] = value ?? false;
              });
            },
          );
        }).toList(),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('OK'),
          onPressed: () {
            List<String> checkedItems = [];
            for (int i = 0; i < checkboxValues.length; i++) {
              if (checkboxValues[i]) {
                checkedItems.add(widget.equipmentList[i].id!);
              }
            }
            _suggestCoursesViewModel.selectedEquipment =
                checkedItems; // Output the checked items
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text('Close'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
