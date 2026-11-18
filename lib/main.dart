import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:market_square/providers/user_provider.dart';
import 'package:market_square/routes/route.dart';
import 'package:market_square/theme/app_theme.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env.dev');
  await Supabase.initialize(url: dotenv.env['SUPABASE_URL']!, publishableKey: dotenv.env['SUPABASE_PUBLISHABLE_KEY']!);
  runApp(const MarketSquare());
}

class MarketSquare extends StatelessWidget {
  const MarketSquare({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child: MaterialApp(
        title: "Market Square",
        theme: AppTheme.light,
        initialRoute: AppRoutes.welcome,
        routes: AppRoutes.routes,
      ),
    );
  }
}
