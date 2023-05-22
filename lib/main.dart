import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:medin/firebase_options.dart';
import 'package:medin/view_models/login.viewmodel.dart';
import 'package:medin/view_models/signup.viewmodel.dart';
import 'package:medin/view_models/spinner.viewmodel.dart';
import 'package:medin/views/courses.view.dart';
import 'package:medin/views/login.view.dart';
import 'package:medin/views/signup.view.dart';
import 'package:medin/views/spinner.view.dart';
import 'package:provider/provider.dart';
import 'package:medin/utils/keys.dart';
import 'package:medin/view_models/equipment.viewmodel.dart';
import 'package:medin/view_models/content.viewmodel.dart';
import 'package:medin/repositories/equipment.repo.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ListenableProvider<EquipmentRepo>(
            create: (context) => EquipmentRepoImpl()),
        ListenableProvider<ContentViewModel>(
            create: (context) => ContentViewModel()),
        ListenableProvider<EquipmentViewModel>(
            create: (context) => EquipmentViewModel()),
        ListenableProvider<SignUpViewModel>(
            create: (context) => SignUpViewModel()),
        ListenableProvider<LoginViewModel>(
            create: (context) => LoginViewModel()),
      ],
      child: MaterialApp(
        scaffoldMessengerKey: scaffoldMessengerKey,
        navigatorKey: navigatorKey,
        theme: ThemeData(
          useMaterial3: true,
        ),
        title: 'MEDIN',
        home: LoginView(),
      ),
    );
  }
}
