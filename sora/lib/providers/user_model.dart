import 'package:flutter/material.dart';

class UserInfo with ChangeNotifier {
  int? userId;
  String? userEmail;
  String? userGender;
  String? userPhone;
  String? userUniversity;
  String? userStudentId;
  String? userDepartment;
  String? userDescription;
  bool? userAuth;

  void setUserInfo(int userId, String userEmail, 
  String userGender, String userPhone, String userUniversity, 
  String userStudentId, String userDepartment,
  String userDescription, bool userAuth) {
    this.userId = userId;
    this.userEmail = userEmail;
    this.userGender = userGender;
    this.userPhone = userPhone;
    this.userUniversity = userUniversity;
    this.userStudentId = userStudentId;
    this.userDepartment = userDepartment;
    this.userDescription = userDescription;
    this.userAuth = userAuth;
    notifyListeners();
  }

  void removeUserInfo() {
    userId = null;
    userEmail = null;
    userGender = null;
    userPhone = null;
    userUniversity = null;
    userStudentId = null;
    userDepartment = null;
    userDescription = null;
    userAuth = null;
    notifyListeners();
  }
}