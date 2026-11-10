import 'package:flutter/widgets.dart';
// Screen imports
import 'package:market_square/screens/welcome.dart';
import 'package:market_square/screens/sign_in.dart';
import 'package:market_square/screens/register.dart';
import 'package:market_square/screens/home.dart';
import 'package:market_square/screens/colors.dart'; //TEMPORARY

class AppRoutes {
  // Route Names
  static const String welcome = '/';
  static const String signIn = '/sign_in';
  static const String register = '/register';
  static const String home = '/home';
  static const String colors = '/colors';

  // Lookup Table
  static final Map <String, WidgetBuilder> routes = {
    welcome: (context) => WelcomeScreen(),
    signIn: (context) => SignInScreen(),
    register:(context) => RegistrationForm(),
    home:(context) => LandingPage(),
    colors:(context) => ColorPalettePreviewScreen(),
  };

}
