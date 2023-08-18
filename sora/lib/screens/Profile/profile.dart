import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:sora/providers/login_model.dart';
import 'package:sora/providers/user_model.dart';
import 'package:sora/screens/Login/login.dart';
import 'package:http/http.dart' as http;
import 'package:sora/utils/urls.dart';

import 'dart:convert';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  // This widget is the profile page of the app.
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // This is the state of the profile page.
  static const storage = FlutterSecureStorage();
  int? user_email;
  String? user_gender;
  String? user_phone;
  String? user_university;
  String? user_studentId;
  String? user_department;
  String? user_description;
  bool? user_auth;

  @override
  Widget build(BuildContext context) {
    Login loginInfo = Provider.of<Login>(context);
    UserInfo userInfo = Provider.of<UserInfo>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Center(
        child: Column(
          children: [
            Text(userInfo.userEmail ?? ""),
            Text(userInfo.userId.toString()),
            Text(userInfo.userGender ?? ""),
            Text(userInfo.userPhone ?? ""),
            Text(userInfo.userUniversity ?? ""),
            Text(userInfo.userStudentId ?? ""),
            Text(userInfo.userDepartment ?? ""),
            Text(userInfo.userDescription ?? ""),
            Text(userInfo.userAuth.toString()),
            FilledButton(
              onPressed: () async {
                await storage.delete(key: "login");
                loginInfo.logout();
                if(!mounted) return;
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginPage(),
                  ), (route) => false,
                );
              },
              child: const Text('Logout'),
            )
          ]
        ),
      ),
    );
  }
}