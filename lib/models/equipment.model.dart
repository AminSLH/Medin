class EquipmentModel {
  final String? id;
  final String? image;
  final String? name;
  final String? description;
  final String? type;
  final List<String>? reservations;

  EquipmentModel(
      {required this.id,
      this.image,
      required this.name,
      required this.description,
      required this.type,
      required this.reservations});
}
