import 'package:medin/models/user_medin.model.dart';

class SuggestModel {
  UserMedinModel? userMedinModel;
  String subject;
  String? body;
  String datetime;
  SuggestionState? state;

  SuggestModel({
    this.userMedinModel,
    required this.subject,
    this.body,
    required this.datetime,
    this.state = SuggestionState.pending,
  });
}

enum SuggestionState {
  pending,
  accepted,
  refused,
}
