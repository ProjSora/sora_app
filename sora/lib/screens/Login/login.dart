import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sora/screens/Home/utils/bottom_navigate.dart';
import 'package:provider/provider.dart';
import 'package:sora/providers/login_model.dart';
import 'package:sora/providers/user_model.dart';
import 'package:http/http.dart' as http;

import 'package:sora/screens/Regist/regist_1.dart';
import 'package:sora/utils/urls.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  // This widget is the login page of the app.
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // This is the state of the login page.
  late TextEditingController idController;
  late TextEditingController passwordController;
  String? userInfo = "";

  bool passwordVisible = true;

  static const storage = FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    idController = TextEditingController();
    passwordController = TextEditingController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _asyncMethod();
    });
  }

  @override
  void dispose() {
    idController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  _asyncMethod() async {
    userInfo = await storage.read(key:"login");

    if(!mounted) return;
    if (userInfo != null) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeNavigationBar(),
        ), (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Login loginInfo = Provider.of<Login>(context);
    UserInfo userInfo = Provider.of<UserInfo>(context);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child : Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget> [
                Image.asset('images/sora_logo.png', width: 150, height: 150),
                const SizedBox(height: 10,),
                TextField(
                  controller: idController,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.person),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                    ),
                    labelText: 'id',
                  ),
                ),
                const SizedBox(height: 10,),
                TextField(
                  obscureText: passwordVisible,
                  enableSuggestions: false,
                  autocorrect: false,
                  controller: passwordController,
                  decoration: InputDecoration(
                    icon: const Icon(Icons.password),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                    ),
                    labelText: 'password',
                    suffixIcon: IconButton(
                      icon : Icon(passwordVisible ? Icons.visibility : Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          passwordVisible = !passwordVisible;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 10,),
                FilledButton(
                  onPressed: (idController.text.isNotEmpty &&
                              passwordController.text.isNotEmpty) ? 
                    () async {
                    await storage.write(
                      key: 'login',
                      value: "id${idController.text} password${passwordController.text}",
                    );
                    var result = await http.post(
                      Uri.parse(loginUrl.toString()),
                      headers: {
                        "Accept": "application/json",
                        "Content-Type": "application/json",
                      },
                      body: json.encode({
                        "email": idController.text,
                        "user_pw": passwordController.text,
                      }),
                    );
                    var response = jsonDecode(utf8.decode(result.bodyBytes));
                    if (!mounted) return;
                    if (result.statusCode == 200 && response["status"] == "success") {
                      loginInfo.setEmail(idController.text);
                      userInfo.setUserInfo(
                        response["user_id"],
                        response["email"],
                        response["user_name"],
                        response["user_nick"],
                        response["user_mbti"],
                        response["gender"],
                        response["phone_number"],
                        response["university"],
                        response["student_id"],
                        response["department"],
                        response["description"],
                        response["auth"]
                      );
                      Navigator.pushReplacement(context, 
                        MaterialPageRoute(
                          builder: (context) => const HomeNavigationBar(),
                        ),
                      );
                    } else {
                      _showDialog('Failed to login');
                    }
                  } : () => {},
                  child: const Text('Login'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const SignUpFirstPage(),
                      ),
                    );
                  },
                  child: const Text('Sign up'),
                ),
              ],
            )
          ),
        )
      ),
    );
  }
  void _showDialog(String message) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child: const Text('OK'),
          ),
        ]
      )
    );
  }

  void readUserInfo(response) {
    
    
  }
}
