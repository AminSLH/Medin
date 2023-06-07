class UserMedinModel {
  final String? id;
  final String? email;
  final String? name;
  final String? phoneNumber;
  final String? role;
  final String? affiliation;
  final String? grade;
  final String? service;

  UserMedinModel(
      {required this.id,
      required this.email,
      required this.name,
      required this.role,
      this.phoneNumber,
      this.affiliation,
      this.grade,
      this.service});
}
