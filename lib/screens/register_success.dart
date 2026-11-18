import 'package:flutter/material.dart';

class RegisterSuccessScreen extends StatelessWidget {
  const RegisterSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Success')),
      body: SafeArea(
        minimum: EdgeInsets.all(8.0),
        child: Column(
          spacing: 15.0,
          children: [
            Text('Success icon goes here'),
            Text(
              "Form successfully submitted, you'll receive an email once it's been reviewed",
            ),
            OutlinedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Back to Welcome Page'),
            ),
          ],
        ),
      ),
    );
  }
}
