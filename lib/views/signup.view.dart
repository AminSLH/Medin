import 'package:flutter/material.dart';
import 'package:medin/components/auth_textfield.dart';
import 'package:medin/view_models/signup.viewmodel.dart';
import 'package:provider/provider.dart';

///////////////////////////////////////////////////////////////////////////////
class SignUpView extends StatefulWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  late SignUpViewModel _signUpViewModel;
  // user credential fields
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmController = TextEditingController();
  // other user info fields
  final nameController = TextEditingController();
  final phoneNumberController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    this._signUpViewModel =
        Provider.of<SignUpViewModel>(context, listen: false);
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.lightBlue[100],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'MEDIN Signup',
          textAlign: TextAlign.center,
        ),
        //backgroundColor: Colors.white,
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        Image.asset(
          'assets/icons/add-user.png',
          height: 150,
          width: 150,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AuthTextField(nameController, 'Name', false),
                  AuthTextField(phoneNumberController, 'Phone number', false),
                  AuthTextField(emailController, 'Email', false),
                  AuthTextField(passwordController, 'Password', true),
                  AuthTextField(
                      passwordConfirmController, 'Confirm Password', true),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _signUpViewModel.createUser(
                        emailController.text,
                        passwordController.text,
                        passwordConfirmController.text,
                        nameController.text,
                        phoneNumberController.text,
                        context);
                    setState(() {});
                  },
                  child: const Text('Submit'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel'),
                )
              ],
            )
          ],
        ),
      ]),
    );
  }
}
