import 'package:flutter/material.dart';
import 'package:market_square/theme/app_theme.dart';
import 'package:market_square/routes/route.dart';

void main() {
  runApp(const MarketSquare());
}

class MarketSquare extends StatelessWidget {
  const MarketSquare({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Market Square",
      theme: AppTheme.light,
      initialRoute: AppRoutes.welcome,
      routes: AppRoutes.routes,
    );
  }
}
