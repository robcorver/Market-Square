import 'package:flutter/material.dart';

class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({super.key});

  static const String version = '0.1';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Terms and Conditions')),
      body: SafeArea(
        minimum: EdgeInsets.all(8.0),
        child: ListView(
          children: [Text('Version: $version'), Text('Lorem ipsem')],
        ),
      ),
    );
  }
}
