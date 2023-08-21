import 'package:flutter/material.dart';
import 'package:sora/screens/Login/login.dart';

class SignUpFinishedPage extends StatefulWidget {
  const SignUpFinishedPage({Key? key}) : super(key: key);

  @override
  State<SignUpFinishedPage> createState() => _SignUpFinishedPageState();
}

class _SignUpFinishedPageState extends State<SignUpFinishedPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('회원가입 완료'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text("회원가입이 완료되었습니다."),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(context,
                      MaterialPageRoute(builder: (context) => const LoginPage()), (route) => false);
                  },
                  child: const Text('로그인'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}