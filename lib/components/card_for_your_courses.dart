import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:medin/models/course.model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class YourCoursesCard extends StatefulWidget {
  late String? title;
  late String? description;
  late String? id;
  late String? instructor;
  late String? price;
  late String? date;
  late int seatsRemaining;
  YourCoursesCard({super.key, required CourseModel course}) {
    title = course.title;
    description = course.description;
    id = course.id;
    instructor = course.instructor;
    date = course.date;
    seatsRemaining = course.seatsRemaining;
  }

  @override
  _YourCoursesCardState createState() => _YourCoursesCardState();
}

class _YourCoursesCardState extends State<YourCoursesCard> {
  final fbCourseRef = FirebaseDatabase.instance.ref('Trainings');
  final fbAuth = FirebaseAuth.instance;
  bool isSpotReserved = true;

  @override
  void initState() async {
    await checkSpotReserved();
    super.initState();
  }

  Future<bool> checkSpotReserved() async {
    var snapshot = await fbCourseRef.child(widget.id!).child('attendees').get();
    var attendees = snapshot.value as Map<dynamic, dynamic>;
    debugPrint(attendees.toString());
    if (attendees.containsKey(fbAuth.currentUser?.uid)) {
      if (attendees[fbAuth.currentUser?.uid]['accepted'] == true) {
        isSpotReserved = false;
        return false;
      } else {
        isSpotReserved = true;
        return true;
      }
    } else {
      isSpotReserved = true;
      return true;
    }
  }

  bool isSpotAvailable(seatsRemaining) {
    return seatsRemaining > 0;
  }

  @override
  Widget build(BuildContext context) {
    checkSpotReserved();
    return isSpotReserved
        ? Container()
        : Card(
            margin: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),
                      Text(
                        widget.date ?? 'No date',
                        style: const TextStyle(fontSize: 8),
                      ),
                      Text(
                        widget.title ?? 'No title',
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        widget.description ?? 'No description',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Places restantes: ${widget.seatsRemaining ?? 'Inconnu'}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ],
            ),
          );
  }
}
