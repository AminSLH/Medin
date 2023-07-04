import 'package:flutter/material.dart';

class FaqView extends StatelessWidget {
  const FaqView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FAQ'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text('Q: What is MEDIN?'),
            subtitle: Text(
                'A: MEDIN is a mobile app designed for healthcare professionals to enhance their knowledge and skills.'),
          ),
          ListTile(
            title: Text('Q: How can I download MEDIN?'),
            subtitle: Text(
                'A: MEDIN is available for download on both Android and iOS platforms. Visit the respective app stores to get the app.'),
          ),
          ListTile(
            title: Text('Q: Can I access MEDIN offline?'),
            subtitle: Text(
                'A: Unfortunately, MEDIN is not available offline. You need to have an active internet connection to use the app.'),
          ),
          ListTile(
            title: Text('Q: How can I reset my password?'),
            subtitle: Text(
                'A: To reset your password, go to the login screen and click on the "Forgot password" link. Follow the instructions to reset your password.'),
          ),
          ListTile(
            title: Text('Q: How can I provide feedback on the app?'),
            subtitle: Text(
                'A: You can provide feedback by going to the "Feedback" section in the app. Your feedback is valuable to us for further improvements.'),
          ),
          // Add more FAQ entries as needed
        ],
      ),
    );
  }
}
