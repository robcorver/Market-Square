import 'package:flutter/material.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  static const String version = '0.1';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Privacy Policy')),
      body: SafeArea(
        minimum: EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Text('Version: $version'),
            Text(
              'This policy covers which data is collected, and for what purpose',
            ),
          ],
        ),
      ),
    );
  }
}
