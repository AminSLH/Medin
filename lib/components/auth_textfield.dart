import 'package:flutter/material.dart';

class AuthTextField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final bool obscureText;

  const AuthTextField(this.controller, this.labelText, this.obscureText, {super.key});

  @override
  _AuthTextFieldState createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  String? _errorMessage;

  void _validateInput(String input) {
    if (input.isEmpty) {
      setState(() {
        _errorMessage = 'This field is required';
      });
    } else {
      setState(() {
        _errorMessage = null;
      });
    }

    switch (widget.labelText) {
      case 'Name':
        if (input.length < 3 || !RegExp(r'^[a-zA-Z ]+$').hasMatch(input)) {
          setState(() {
            _errorMessage = 'Please enter a valid name';
          });
        }
        break;
      case 'Email':
        if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(input)) {
          setState(() {
            _errorMessage = 'Please enter a valid email address';
          });
        }
        break;
      case 'Phone number':
        if (!RegExp(r'^\d{8}$').hasMatch(input)) {
          setState(() {
            _errorMessage = 'Please enter a valid phone number';
          });
        }
        break;
      case 'Password':
        if (input.length < 6) {
          setState(() {
            _errorMessage = 'Password must be at least 6 characters long';
          });
        }
        break;
      case 'Confirm Password':
        if (input != widget.controller.text) {
          setState(() {
            _errorMessage = 'Passwords do not match';
          });
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: widget.obscureText,
      decoration: InputDecoration(
        labelText: widget.labelText,
        errorText: _errorMessage,
        border: const OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.7),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: 2,
          ),
        ),
        labelStyle: TextStyle(
          color: Theme.of(context).colorScheme.onBackground.withOpacity(0.5),
        ),
      ),
      onChanged: _validateInput,
    );
  }
}
