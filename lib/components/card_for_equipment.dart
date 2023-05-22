import 'package:flutter/material.dart';
import 'package:medin/models/equipment.model.dart';

class EquipmentCard extends StatelessWidget {
  late String? image;
  late String title;
  late String description;
  late String id;
  late String reservations;
  late String type;
  EquipmentCard({required EquipmentModel equipment, Key? key}) {
    this.image = equipment.image;
    this.title = equipment.title;
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
                image: AssetImage(
                    (image == null) ? "assets/question_mark.png" : image!),
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
                  title,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  description,
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 8),
                Text(
                  'ID:' + id,
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 8),
                Text(
                  description,
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
