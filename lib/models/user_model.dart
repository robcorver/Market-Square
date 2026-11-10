import 'package:market_square/models/user_role.dart';

class UserModel {
  UserModel({required this.role, required this.authId, required this.lastName, this.firstName, this.displayName});

  final UserRole role;
  final String authId;
  final String lastName;
  final String? firstName;
  final String? displayName;
}