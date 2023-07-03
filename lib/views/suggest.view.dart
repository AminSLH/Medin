import 'package:flutter/material.dart';
import 'package:medin/view_models/suggest.viewmodel.dart';
import 'package:provider/provider.dart';

class SuggestView extends StatefulWidget {
  const SuggestView({Key? key}) : super(key: key);

  @override
  _SuggestViewState createState() => _SuggestViewState();
}

class _SuggestViewState extends State<SuggestView> {
  late SuggestViewModel _suggestViewModel;

  @override
  void initState() {
    super.initState();
    _suggestViewModel = Provider.of<SuggestViewModel>(context, listen: false);
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _date ?? DateTime.now(),
      firstDate: DateTime(1999),
      lastDate: DateTime(2199),
    );
    if (picked != null) {
      setState(() {
        _date = picked;
      });
    }
  }

  final _formKey = GlobalKey<FormState>();
  DateTime? _date;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: ListView(
          children: [
            TextFormField(
              controller: _suggestViewModel.subjectController,
              decoration: const InputDecoration(
                labelText: 'Sujet',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez saisir le sujet.';
                }
                return null;
              },
            ),
            //SizedBox(height: 16),
            const Text(
              'Détails:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            //SizedBox(height: 8),
            TextFormField(
              controller: _suggestViewModel.bodyController,
              decoration: const InputDecoration(
                hintText: 'Details',
                border: OutlineInputBorder(),
              ),
              maxLines: 5,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Form is valid, submit data here
                      _suggestViewModel.submit();
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
    );
  }
}
