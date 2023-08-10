import 'package:flutter/material.dart';

class Login with ChangeNotifier {
  String? email;

  Login({this.email});

  String getEmail() => email ?? "";

  void setEmail(String email) {
    this.email = email;
    notifyListeners();
  }
  
  void logout() {
    email = null;
    notifyListeners();
  }
}