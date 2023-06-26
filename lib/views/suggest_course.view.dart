import 'package:flutter/material.dart';

class SuggestCourseView extends StatefulWidget {
  const SuggestCourseView({Key? key}) : super(key: key);

  @override
  _SuggestCourseViewState createState() => _SuggestCourseViewState();
}

class _SuggestCourseViewState extends State<SuggestCourseView> {
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _date ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _date = picked;
      });
    }
  }

  final _formKey = GlobalKey<FormState>();
  final _subjectController = TextEditingController();
  final _equipmentController = TextEditingController();
  DateTime? _date;

  @override
  void dispose() {
    _subjectController.dispose();
    _equipmentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Suggérer une formation')),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                TextFormField(
                  controller: _subjectController,
                  decoration: const InputDecoration(
                    labelText: 'Sujet de la formation',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez saisir le sujet de la formation.';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _equipmentController,
                  decoration: const InputDecoration(
                    labelText: 'Équipement requis',
                  ),
                ),
                const ListTile(
                    title: Text(
                  'Date proposée:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                )),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        '${(_date ?? DateTime.now()).toLocal()}'.split(' ')[0],
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.calendar_today),
                      onPressed: () {
                        _selectDate(context);
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Text(
                  'Détails:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Détails',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 5,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 16.0, horizontal: 16.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // Form is valid, submit data here
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            vertical: 16.0, horizontal: 24.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: const Text('Soumettre'),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
