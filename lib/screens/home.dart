import 'package:flutter/material.dart';
import 'package:market_square/routes/route.dart';

class LandingPage extends StatelessWidget{
  LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome'),
      ),
      // TO DO: Landing Page Design
      body: Column(
        children: [
          Text('Placeholder Text'),
          OutlinedButton(
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.welcome);
            },
            child: Text('Sign Out'),
          ),
        ],
      ),
    );
  }
}