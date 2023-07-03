import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:medin/repositories/suggest.repo.dart';
import 'package:medin/utils/keys.dart';
import 'package:provider/provider.dart';
import 'package:medin/models/suggest.model.dart';

class SuggestViewModel with ChangeNotifier {
  final fbauth = FirebaseAuth.instance;

  final subjectController = TextEditingController();
  final bodyController = TextEditingController();
  late SuggestRepo suggestRepo;

  SuggestViewModel() {
    suggestRepo =
        Provider.of<SuggestRepo>(navigatorKey.currentContext!, listen: true);
  }
  void submit() {
    suggestRepo.addSuggest(SuggestModel(
      subject: subjectController.text,
      body: bodyController.text,
      datetime: DateTime.now(),
      user_id: fbauth.currentUser?.uid,
    ));
    subjectController.clear();
    bodyController.clear();
  }
}
