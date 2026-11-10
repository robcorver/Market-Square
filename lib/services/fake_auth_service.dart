import 'package:market_square/models/user_model.dart';
import 'package:market_square/models/user_role.dart';
import 'package:market_square/services/auth_service.dart';

class FakeAuthService implements AuthService {
  @override
  Future<SignInResult> signIn(String emailAddress, String password) async {
    await Future.delayed(const Duration(seconds: 2));

    const knownEmails = ['valid@email.com', 'suspended@email.com'];

    if (emailAddress == 'error@email.com') {
      return SignInResult(outcome: SignInOutcome.error);
    } else if (!knownEmails.contains(emailAddress) || password != 'password') {
      return SignInResult(outcome: SignInOutcome.invalidCredentials);
    } else if (emailAddress == 'suspended@email.com') {
      return SignInResult(outcome: SignInOutcome.accountSuspended);
    } else {
      return SignInResult(
        outcome: SignInOutcome.signedIn,
        user: UserModel(
          role: UserRole.tenant,
          authId: 'fake-auth-id',
          lastName: 'Doe',
          firstName: 'Jane',
          displayName: 'JD',
        ),
      );
    }
  }
}