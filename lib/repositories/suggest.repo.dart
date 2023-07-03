import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:medin/models/suggest.model.dart';
import 'package:intl/intl.dart' show DateFormat;

abstract class SuggestRepo extends ChangeNotifier {
  void addSuggest(SuggestModel suggestModel);
}

class SuggestRepoImpl extends SuggestRepo {
  DatabaseReference? fbSuggestRef;
  FirebaseDatabase? fbDatabase;
  SuggestRepoImpl() {
    fbDatabase = FirebaseDatabase.instance;
    fbDatabase!.setPersistenceEnabled(true);
    fbSuggestRef = fbDatabase!.ref('Feedback');
  }
  @override
  void addSuggest(SuggestModel suggestModel) {
    String datestring = DateFormat('dd/MM/yyyy').format(suggestModel.datetime);
    // fbSuggestRef!.child(path).set(suggestModel.id);
    fbSuggestRef!.child(suggestModel.id).set({
      'User': suggestModel.user_id ?? 'Guest',
      'Subject': suggestModel.subject,
      'Body': suggestModel.body,
      'Date': datestring,
      'State': 'Unread',
    });
  }
}
