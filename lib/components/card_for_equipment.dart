import 'package:flutter/material.dart';
import 'package:medin/models/equipment.model.dart';

class EquipmentCard extends StatelessWidget {
  late String? image;
  late String? name;
  late String? description;
  late String? id;
  late List<String>? reservations;
  late String? type;
  EquipmentCard({super.key, required EquipmentModel equipment}) {
    image = equipment.image;
    name = equipment.name;
    description = equipment.description;
    id = equipment.id;
    reservations = equipment.reservations;
    type = equipment.type;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: (image == null)
                    ? const AssetImage('assets/question_mark.png')
                    : NetworkImage(image!) as ImageProvider,
                // : AssetImage("assets/question_mark.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name ?? 'No name',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  type ?? 'No type',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 8),
                Text(
                  // 'ID:' + (id ?? 'No ID'),
                  "ID: ${id ?? 'No ID'}",
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 8),
                Text(
                  description ?? 'No description',
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
