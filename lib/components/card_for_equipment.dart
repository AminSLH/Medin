import 'package:flutter/material.dart';
import 'package:medin/models/equipment.model.dart';
import 'package:flutter/painting.dart';

class EquipmentCard extends StatelessWidget {
  late String? image;
  late String? name;
  late String? description;
  late String? id;
  late String? reservations;
  late String? type;
  EquipmentCard({required EquipmentModel equipment, Key? key}) {
    this.image = equipment.image;
    this.name = equipment.name;
    this.description = equipment.description;
    this.id = equipment.id;
    this.reservations = equipment.reservations;
    this.type = equipment.type;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: (image == null)
                    ? AssetImage("assets/question_mark.png")
                    : NetworkImage(image!) as ImageProvider,
                // : AssetImage("assets/question_mark.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name ?? 'No name',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  type ?? 'No type',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 8),
                Text(
                  'ID:' + (id ?? 'No ID'),
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 8),
                Text(
                  description ?? 'No description',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
