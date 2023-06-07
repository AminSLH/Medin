import 'package:flutter/material.dart';

class Suggest extends StatefulWidget {
  const Suggest({Key? key}) : super(key: key);

  @override
  _SuggestState createState() => _SuggestState();
}

class _SuggestState extends State<Suggest> {
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
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  String? _choice;
  final _subjectController = TextEditingController();
  final _equipmentController = TextEditingController();
  DateTime? _date;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _subjectController.dispose();
    _equipmentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Nom',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez saisir votre nom.';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez saisir votre email.';
                  }
                  if (!value.contains('@')) {
                    return 'Veuillez saisir un email valide.';
                  }
                  return null;
                },
              ),
              ListTile(
                title: Text('Je suis'),
                subtitle: _choice == null
                    ? null
                    : Text(
                        _choice == 'doctor' ? 'Médecin' : 'Formateur',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                trailing: Icon(Icons.arrow_drop_down),
                onTap: () async {
                  final choice = await showDialog<String>(
                    context: context,
                    builder: (context) => SimpleDialog(
                      title: Text('Vous êtes ?'),
                      children: [
                        SimpleDialogOption(
                          onPressed: () {
                            Navigator.pop(context, 'doctor');
                          },
                          child: Text('Médecin'),
                        ),
                        SimpleDialogOption(
                          onPressed: () {
                            Navigator.pop(context, 'trainer');
                          },
                          child: Text('Formateur'),
                        ),
                      ],
                    ),
                  );
                  if (choice != null) {
                    setState(() {
                      _choice = choice;
                    });
                  }
                },
              ),
              TextFormField(
                controller: _subjectController,
                decoration: InputDecoration(
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
                decoration: InputDecoration(
                  labelText: 'Équipement requis',
                ),
              ),
              ListTile(
                  title: Text(
                'Date proposée:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              )),
              SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      '${_date?.toLocal()}'.split(' ')[0],
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.calendar_today),
                    onPressed: () {
                      _selectDate(context);
                    },
                  ),
                ],
              ),
              SizedBox(height: 16),
              Text(
                'Details courses:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Details',
                  border: OutlineInputBorder(),
                ),
                maxLines: 5,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Form is valid, submit data here
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 24.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: Text('Soumettre'),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
