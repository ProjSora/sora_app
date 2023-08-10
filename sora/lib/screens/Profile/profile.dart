import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sora/providers/login_model.dart';
import 'package:sora/screens/Login/login.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  // This widget is the profile page of the app.
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // This is the state of the profile page.
  static const storage = FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    Login loginInfo = Provider.of<Login>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Center(
        child: 
          FilledButton(
            onPressed: () async {
              await storage.delete(key: "login");
              loginInfo.logout();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginPage(),
                ),
              );
            },
            child: const Text('Logout'),
          ),
      ),
    );
  }
}