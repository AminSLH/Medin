class EquipmentModel {
  final String? id;
  final String? image;
  final String? title;
  final String? description;
  final String? type;
  final String? reservations;

  EquipmentModel(
      {required this.id,
      this.image,
      required this.title,
      required this.description,
      required this.type,
      required this.reservations});
}
