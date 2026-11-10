import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:market_square/routes/route.dart';

class WelcomeScreen extends StatelessWidget{
  WelcomeScreen({super.key});

@override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar(
          title: SvgPicture.asset('assets/logo_stacked_dark.svg'),
          toolbarHeight: 200.0,
        ),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [

              // Spacer to push section I to middle
              const Spacer(flex: 2),

              // Section I: Intro Text
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children:[
                      Text("Hey Neighbor",
                      style: Theme.of(context).textTheme.displayLarge,
                      ),
                      SizedBox(width: 4),
                      Icon(
                        Icons.waving_hand,
                        size: 34,
                        color: Colors.amber,
                      ),
                    ],
                  ),
                  Text (
                    "Let's get you set up.",
                    style: Theme.of(context).textTheme.bodyLarge,
                    ),
                ],
              ),

              // Spacer to keep section I in middle
              const Spacer(flex: 1),

              // Section II: Buttons
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  FilledButton(
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.register);
                    },
                    child: Text(
                      'Create Account',
                    ),
                  ),
                  SizedBox(height: 15.0),
                  OutlinedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.signIn);
                    },
                    child: const Text(
                     'Sign In',
                    ),
                  ),
                  SizedBox(height: 15.0),
                  OutlinedButton(
                    onPressed: (){
                      Navigator.pushNamed(context, AppRoutes.colors);
                    },
                    child: const Text('Color Swatch'),
                  ),
                ],
              ),
              
              // Spacer to move buttons up
              Spacer(flex: 2),

            ],
          ),
        ),
      );
  }
}