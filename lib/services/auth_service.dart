//import 'package:flutter/supabase.dart';
import 'package:market_square/models/user_model.dart';

enum SignInOutcome {signedIn, invalidCredentials, accountSuspended, error}

class SignInResult {
  SignInResult({required this.outcome, this.user});

  final SignInOutcome outcome;
  final UserModel? user;

}

abstract class AuthService {
  Future<SignInResult> signIn(String emailAddress, String password);
}

