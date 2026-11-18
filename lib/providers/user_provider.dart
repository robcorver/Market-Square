import 'package:flutter/material.dart';
import 'package:market_square/models/user_model.dart';

class UserProvider extends ChangeNotifier {
  UserModel? _user;

  // Getters for exposing private info to public screens
  UserModel? get user => _user;
  bool get isSignedIn => _user != null;

  // Methods for updating UserProvider
  void setUser(UserModel user) {
    _user = user;
    notifyListeners();
  }

  void clearUser() {
    _user = null;
    notifyListeners();
  }
}
