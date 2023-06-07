import 'package:flutter/material.dart';
import 'package:medin/models/course.model.dart';

class CourseCard extends StatefulWidget {
  late String? title;
  late String? description;
  late String? id;
  late String? instructor;
  late String? price;
  late String? date;
  CourseCard({required CourseModel course, Key? key}) {
    this.title = course.title;
    this.description = course.description;
    this.id = course.id;
    this.instructor = course.instructor;
    this.price = course.price;
    this.date = course.date;
  }

  @override
  _CourseCardState createState() => _CourseCardState();
}

class _CourseCardState extends State<CourseCard> {
  int seats = 24;
  bool isSpotReserved = false;
  bool isSpotAvailable(seats) {
    return seats > 0;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 8),
                Text(
                  '$widget.date',
                  style: TextStyle(fontSize: 8),
                ),
                Text(
                  widget.title ?? 'No title',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  widget.description ?? 'No description',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 8),
                Text(
                  'Places restantes: $seats',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: isSpotReserved || !isSpotAvailable(seats)
                      ? null
                      : () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text('Confirmation'),
                                content: Text(
                                  'Voulez-vous réserver une place pour cette formation ?',
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Annuler'),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        isSpotReserved = true;
                                      });
                                      Navigator.of(context).pop();
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'Votre demande est en attente de confirmation.',
                                          ),
                                        ),
                                      );
                                    },
                                    child: Text('Confirmer'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                  child: isSpotReserved
                      ? Row(
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
                      : Text('Réserver une place'),
                  style: isSpotReserved
                      ? ElevatedButton.styleFrom(
                          primary: Colors.yellow[700],
                        )
                      : null,
                ),
                SizedBox(height: 5),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
