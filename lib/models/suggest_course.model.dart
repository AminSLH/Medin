import 'package:medin/models/user_medin.model.dart';

class SuggestCourseModel {
  UserMedinModel? userMedinModel;
  String? sujet_formation;
  String? equipement_requis;
  String? type_formation;
  String? date_formation;

  SuggestCourseModel({
    this.userMedinModel,
    this.sujet_formation,
    this.equipement_requis,
    this.type_formation,
    this.date_formation,
  });
}
