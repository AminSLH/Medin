import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:medin/models/course.model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CourseCard extends StatefulWidget {
  late String? title;
  late String? description;
  late String? id;
  late String? instructor;
  late String? price;
  late String? date;
  late int seatsRemaining;
  late Map<dynamic, dynamic>? attendees;
  CourseCard({super.key, required CourseModel course}) {
    title = course.title;
    description = course.description;
    id = course.id;
    instructor = course.instructor;
    date = course.date;
    seatsRemaining = course.seatsRemaining;
    attendees = course.attendees;
  }

  @override
  _CourseCardState createState() => _CourseCardState();
}

class _CourseCardState extends State<CourseCard> {
  final fbCourseRef = FirebaseDatabase.instance.ref('Trainings');
  final fbAuth = FirebaseAuth.instance;
  bool isSpotReserved = false;
  bool checkSpotReserved() {
    if (widget.attendees?.containsKey(fbAuth.currentUser?.uid) ?? false) {
      isSpotReserved = true;
      return true;
    } else {
      isSpotReserved = false;
      return false;
    }
  }

  bool checkSpotAccepted() {
    if (widget.attendees?.containsKey(fbAuth.currentUser?.uid) ?? false) {
      if (widget.attendees?[fbAuth.currentUser?.uid]['accepted'] == true) {
        return true;
      }
    }
    return false;
  }

  bool isSpotAvailable(seatsRemaining) {
    return seatsRemaining > 0;
  }

  @override
  Widget build(BuildContext context) {
    checkSpotReserved();
    return checkSpotAccepted()
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
                      ElevatedButton(
                        onPressed: isSpotReserved ||
                                !isSpotAvailable(widget.seatsRemaining)
                            ? null
                            : () {
                                if (FirebaseAuth.instance.currentUser?.email !=
                                    null) {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text('Confirmation'),
                                        content: const Text(
                                          'Voulez-vous réserver une place pour cette formation ?',
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text('Annuler'),
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              setState(() {
                                                //
                                                fbCourseRef
                                                    .child(widget.id!)
                                                    .child('attendees')
                                                    .update({
                                                  (FirebaseAuth.instance
                                                          .currentUser?.uid ??
                                                      'Guest'): {
                                                    'id': (fbAuth
                                                            .currentUser?.uid ??
                                                        'Guest'),
                                                    'accepted': false,
                                                  },
                                                });
                                              });
                                              Navigator.of(context).pop();
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                    'Votre demande est en attente de confirmation.',
                                                  ),
                                                ),
                                              );
                                            },
                                            child: const Text('Confirmer'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        '❌  Vous devez être connecté pour réserver une place.',
                                      ),
                                    ),
                                  );
                                }
                                ;
                              },
                        style: isSpotReserved
                            ? ElevatedButton.styleFrom(
                                backgroundColor: Colors.yellow[700],
                              )
                            : null,
                        child: isSpotReserved
                            ? const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // Icon(Icons.schedule, color: Colors.white),
                                  Icon(Icons.schedule),
                                  SizedBox(width: 8),
                                  Text('En attente'
                                      // style: TextStyle(color: Colors.white),
                                      ),
                                ],
                              )
                            : const Text('Réserver une place'),
                      ),
                      const SizedBox(height: 5),
                    ],
                  ),
                ),
              ],
            ),
          );
  }
}
