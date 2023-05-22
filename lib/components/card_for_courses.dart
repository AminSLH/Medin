import 'package:flutter/material.dart';

class CourseCard extends StatefulWidget {
  final String image;
  final String title;
  final String description;
  final String id;
  final String instructor;
  final String price;
  final String date;
  const CourseCard(
      {Key? key,
      required this.image,
      required this.title,
      required this.description,
      required this.id,
      required this.instructor,
      required this.price,
      required this.date})
      : super(key: key);

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
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(widget.image),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 16),
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
                  widget.title,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  widget.description,
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
                            Icon(Icons.schedule, color: Colors.white),
                            SizedBox(width: 8),
                            Text(
                              'En attente',
                              style: TextStyle(color: Colors.white),
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
