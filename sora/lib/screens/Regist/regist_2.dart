/// this page is for sign up step 2
/// this page phone number
/// and authrication phone number

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:sora/utils/urls.dart';
import 'package:sora/screens/Regist/regist_3.dart';

class SignUpSecondPage extends StatefulWidget {
  final String email;
  final String password;
  const SignUpSecondPage(this.email, this.password, {Key? key}) : super(key: key);
  
  @override
  State<SignUpSecondPage> createState() => _SignUpSecondPageState();
}

class _SignUpSecondPageState extends State<SignUpSecondPage> {
  late TextEditingController phoneController;
  late TextEditingController authController;
  String authNumber = '';
  bool authButtonEnabled = false;
  bool authSendButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    phoneController = TextEditingController();
    authController = TextEditingController();
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
            title: const Text('회원가입')),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Row(
                    children: <Widget>[
                      Icon(Icons.radio_button_unchecked_outlined, size: 40),
                      SizedBox(width: 20),
                      Icon(Icons.radio_button_unchecked_outlined, size: 20),
                      SizedBox(width: 20),
                      Icon(Icons.radio_button_unchecked_outlined, size: 20),
                      SizedBox(width: 20),
                      Icon(Icons.radio_button_unchecked_outlined, size: 20),
                    ],
                  ),
                  const Text("인증을 위한 휴대전화 번호를 입력해 주세요."),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: TextField(
                          controller: phoneController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: '휴대전화 번호',
                          ),
                          onChanged: (text) {
                            if (text.length == 11) {
                              setState(() {
                                authSendButtonEnabled = true;
                              });
                            } else {
                              setState(() {
                                authSendButtonEnabled = false;
                              });
                            }
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        flex: 2,
                        child: FilledButton(
                          onPressed: (!authSendButtonEnabled) ? null 
                          : () async {
                            var result = await http.post(
                              Uri.parse(phoneAuthUrl.toString()),
                              headers: {
                                "Accept": "application/json",
                                "Content-Type": "application/json"
                              },
                              body: jsonEncode({
                                "phone": phoneController.text
                              })
                            );
                            var response = json.decode(result.body);
                            if (!mounted) return;
                            if (response["state_code"] == '200') {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('인증번호가 전송되었습니다.'),
                                )
                              );
                              authNumber = response["auth_number"];
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('인증번호 전송에 실패했습니다.'),
                                )
                              );
                            }
                          },
                          child: const Text('인증번호 전송'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: authController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: '인증번호',
                    ),
                    onChanged: (text) {
                      if (text.length == 6) {
                        setState(() {
                          authButtonEnabled = true;
                        });
                      } else {
                        setState(() {
                          authButtonEnabled = false;
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 10),
                  FilledButton(
                    onPressed: authButtonEnabled ? () {
                      if (authNumber == authController.text) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignUpThirdPage(
                              widget.email,
                              widget.password,
                              phoneController.text,
                            ),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('인증번호가 일치하지 않습니다.'),
                          )
                        );
                      }
                    } : null,
                    child: const Text('인증'),
                  )
                ],
              )
            )
          ),
        )
      ),
    );
  }
}