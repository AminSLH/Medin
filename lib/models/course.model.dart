class CourseModel {
  final String? title;
  final String? description;
  final String? id;
  final String? instructor;
  final String? price;
  final String? date;
  final String? time;
  final int seatsRemaining;
  final List<String>? attendees;
  final List<String>? equipmentReserved;
  final String? state;

  CourseModel(
      {required this.id,
      required this.title,
      required this.description,
      required this.instructor,
      required this.price,
      required this.date,
      required this.time,
      required this.seatsRemaining,
      required this.attendees,
      required this.state,
      required this.equipmentReserved});
}
