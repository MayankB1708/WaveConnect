import 'package:flutter/material.dart';
import 'package:waveconnect/models/user.dart';
import 'package:waveconnect/resources/auth_methods.dart';

//User Data State Management
class UserProvider with ChangeNotifier {
  User? _user;
  final AuthMethods _authMethods = AuthMethods();

  User get getUser => _user!;

  Future<void> refreshUser() async {
    User user = await _authMethods.getUserDetails();
    _user = user;
    notifyListeners();
  }
}
