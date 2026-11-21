import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:market_square/models/user_model.dart';
import 'package:market_square/models/user_role.dart';
import 'package:market_square/services/auth_service.dart';

class RealAuthService implements AuthService {
  final client = Supabase.instance.client;

  @override
  Future<SignInResult> signIn(String emailAddress, String password) async {
    try {
      await client.auth.signInWithPassword(
        email: emailAddress,
        password: password,
      );
      final userId = client.auth.currentUser?.id;

      if (userId == null) {
        return SignInResult(outcome: SignInOutcome.error);
      }

      final userProfile = await client
          .from('users')
          .select()
          .eq('id', userId)
          .maybeSingle();

      // Missing Profile
      if (userProfile == null) {
        await client.auth.signOut();
        return SignInResult(outcome: SignInOutcome.error);
      }

      // User De-Activated
      if (userProfile['is_active'] != true) {
        await client.auth.signOut();
        return SignInResult(outcome: SignInOutcome.accountSuspended);
      }

      UserRole userRole;

      // Unknown Role
      try {
        userRole = UserRole.values.byName(userProfile['role'] as String);
      } catch (e) {
        debugPrint('$e');
        userRole = UserRole.tenant;
      }

      final String lastName = userProfile['last_name'] as String;
      final String? firstName = userProfile['first_name'] as String?;
      final String? displayName = userProfile['display_name'] as String?;

      return SignInResult(
        outcome: SignInOutcome.signedIn,
        user: UserModel(
          role: userRole,
          authId: userId,
          lastName: lastName,
          firstName: firstName,
          displayName: displayName,
        ),
      );
    } on AuthRetryableFetchException catch (e) {
      debugPrint('$e');
      return SignInResult(outcome: SignInOutcome.error);
    } on AuthException catch (e) {
      debugPrint('$e');
      return SignInResult(outcome: SignInOutcome.invalidCredentials);
    } catch (e) {
      debugPrint('$e');
      return SignInResult(outcome: SignInOutcome.error);
    }
  }

  @override
  Future<void> signOut() async {
    await client.auth.signOut();
  }
}
