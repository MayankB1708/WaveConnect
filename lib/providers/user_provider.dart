import 'package:flutter/material.dart';
import 'package:waveconnect/models/user.dart';

class UserProvider with ChangeNotifier {
  User? _user;

  User get getUser => _user!;

  Future<void> refreshUser() async{
    
  }
}
