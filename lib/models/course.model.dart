class CourseModel {
  final String? title;
  final String? description;
  final String? id;
  final String? instructor;
  final String? price;
  final String? date;

  CourseModel(
      {required this.id,
      required this.title,
      required this.description,
      required this.instructor,
      required this.price,
      required this.date});
}
