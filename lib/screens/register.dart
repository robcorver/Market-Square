import 'package:flutter/material.dart';
import 'package:market_square/routes/route.dart';

class RegistrationForm extends StatefulWidget {
  RegistrationForm ({super.key});

  @override
  State<RegistrationForm> createState() => _RegistrationState();

}

class _RegistrationState extends State<RegistrationForm> {
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Registration Form
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Create Account',
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Registration Form
          Text(
          "You'll need approval from your property manager first - just takes a sec to fill this out.",
          ),
          TextField(
            controller: _emailController,
            autofocus: true,
            onChanged: (value) {},
          ),
          // Form Control Buttons
          Row(
            children: [
              TextButton(
                onPressed: (){
                  if(_emailController.text.isEmpty){
                    Null;
                  } else {
                    Navigator.pushNamed(context, AppRoutes.home);
                  }
                },
                child: Text('Cancel'),
                ),
              FilledButton(
                onPressed: () {},
                child: Text('Register'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}