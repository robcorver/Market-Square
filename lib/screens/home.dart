import 'package:flutter/material.dart';
import 'package:market_square/routes/route.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:market_square/providers/user_provider.dart';
import 'package:market_square/models/user_model.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  String greeting(UserModel? user) {
    return user?.displayName ?? user?.firstName ?? 'Neighbor';
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();
    final UserModel? signedInUser = userProvider.user;

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 50,
              child: SvgPicture.asset(
                'assets/logo_horizontal_dark.svg',
                fit: BoxFit.contain,
              ),
            ),
            Text('Hey ${greeting(signedInUser)}'),
            Text(
              "Here's what's happening at Market Street",
              style: Theme.of(context).textTheme.bodySmall
                  ?.copyWith(color: Colors.white),
            ),
          ],
        ),
        toolbarHeight: 150.0,
      ),

      body: SafeArea(
        minimum: EdgeInsets.all(8.0),
        child: Column(
          spacing: 10.0,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Spacer(flex: 1),

            Text(
              'Hello ${greeting(signedInUser)}',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.displayLarge,
            ),

            OutlinedButton(
              onPressed: () {
                context.read<UserProvider>().clearUser();
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  AppRoutes.welcome,
                  (route) => false,
                );
              },
              child: Text('Sign Out'),
            ),

            Spacer(flex: 2),
          ],
        ),
      ),
    );
  }
}
