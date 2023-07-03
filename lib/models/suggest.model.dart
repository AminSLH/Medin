import 'package:medin/models/user_medin.model.dart';
import 'package:random_string/random_string.dart';

class SuggestModel {
  late String id;
  String? user_id;
  String subject;
  String? body;
  DateTime datetime;
  SuggestionState? state;

  SuggestModel({
    this.user_id,
    required this.subject,
    this.body,
    required this.datetime,
    this.state = SuggestionState.unread,
  }) {
    this.id = randomAlphaNumeric(10).toUpperCase();
  }
}

enum SuggestionState {
  read,
  unread,
}
