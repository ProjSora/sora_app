import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sora/screens/Home/utils/bottom_navigate.dart';
import 'package:provider/provider.dart';
import 'package:sora/providers/login_model.dart';
import 'package:http/http.dart' as http;
import 'package:sora/screens/Regist/regist.dart';
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

  bool passwordVisible = false;

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

  _asyncMethod() async {
    userInfo = await storage.read(key:"login");
    print(userInfo);

    if (userInfo != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeNavigationBar(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Login loginInfo = Provider.of<Login>(context);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child : Scaffold(
        appBar: AppBar(
          title: const Text(''),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget> [
                Image.asset('assets/images/sora_logo.png'),
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
                  onPressed: () async {
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
                    if (result.statusCode == 200) {
                      loginInfo.setEmail(idController.text);
                      Navigator.pushReplacement(context, 
                        MaterialPageRoute(
                          builder: (context) => const HomeNavigationBar(),
                        ),
                      );
                    } else {
                      print(result.statusCode);
                      _showDialog('Failed to login');
                    }
                  },
                  child: const Text('Login'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const RegistPage(),
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
}
