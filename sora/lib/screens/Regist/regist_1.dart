import 'package:flutter/material.dart';
import 'package:sora/screens/Regist/regist_2.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:sora/utils/urls.dart';

class SignUpFirstPage extends StatefulWidget {
  const SignUpFirstPage({Key? key}) : super(key: key);

  @override
  State<SignUpFirstPage> createState() => _SignUpFirstPageState();
}

class _SignUpFirstPageState extends State<SignUpFirstPage> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController passwordConfirmController;
  bool passwordVisible = true;
  bool passwordConfirmVisible = true;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    passwordConfirmController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(
            onPressed: () {
              Navigator.pop(context);
            },
            color: ColorScheme.fromSwatch(primarySwatch: Colors.lightGreen)
                .secondary,
          ),
          title: const Text('회원가입'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: '이메일',
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    obscureText: passwordVisible,
                    enableSuggestions: false,
                    autocorrect: false,
                    controller: passwordController,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: '비밀번호',
                      suffixIcon: IconButton(
                        icon: Icon(
                          passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            passwordVisible = !passwordVisible;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    obscureText: passwordConfirmVisible,
                    enableSuggestions: false,
                    autocorrect: false,
                    controller: passwordConfirmController,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: '비밀번호 확인',
                      suffixIcon: IconButton(
                        icon: Icon(
                          passwordConfirmVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            passwordConfirmVisible = !passwordConfirmVisible;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  FilledButton(
                    onPressed: (passwordController.text !=
                              passwordConfirmController.text ||
                          passwordController.text.isEmpty ||
                          passwordConfirmController.text.isEmpty) ? null : () async {
                      var result = await http.post(
                        Uri.parse(emailAuthUrl.toString()),
                        headers: {
                          "Accept": "application/json",
                          "Content-Type": "application/json",
                        },
                        body: json.encode({
                          "email": emailController.text,
                        }),
                      );
                      var response = json.decode(result.body);
                      if (!mounted) return;
                      if (response["state_code"] == '200'){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignUpSecondPage(
                              emailController.text,
                              passwordController.text,
                            ),
                          ),
                        );
                      } else {
                        _showDialog('이미 존재하는 이메일입니다.');
                      }
                    },
                    child: const Text('다음'),
                  )
                ],
              ),
            ),
          )
        )
      )
    );
  }

  void _showDialog(String message) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Message'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}