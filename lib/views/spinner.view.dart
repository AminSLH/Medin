import 'package:flutter/material.dart';
import 'package:medin/view_models/spinner.viewmodel.dart';
import 'package:medin/views/courses.view.dart';
import 'package:medin/views/login.view.dart';
import 'package:provider/provider.dart';

class SpinnerView extends StatefulWidget {
  const SpinnerView({Key? key}) : super(key: key);

  @override
  _SpinnerViewState createState() => _SpinnerViewState();
}

class _SpinnerViewState extends State<SpinnerView> {
  @override
  Widget build(BuildContext context) {
    final spinnerViewModelProvider = Provider.of<SpinnerViewModel>(context);
    final userFromProvider = spinnerViewModelProvider.user;

    return Scaffold(
        appBar: AppBar(
          title: Text('medin'),
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ));
  }
}
