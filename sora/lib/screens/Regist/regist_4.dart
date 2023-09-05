import 'package:flutter/material.dart';
import 'package:sora/screens/Login/login.dart';
import 'package:http/http.dart' as http;
import 'package:sora/utils/urls.dart';
import 'dart:convert';
class SignUpFourthPage extends StatefulWidget {
  final String email;
  final String password;
  final String phone;
  final String name;
  final String mbti;
  final String nickName;
  final String gender;
  final String university;
  final String department;
  final String studentId;
  const SignUpFourthPage(this.email, this.password, this.phone,
    this.name, this.nickName, this.mbti, this.gender,
    this.university, this.department, this.studentId,
    {Key? key}) : super(key: key);

  @override
  State<SignUpFourthPage> createState() => _SignUpFinishedPageState();
}

class _SignUpFinishedPageState extends State<SignUpFourthPage> {
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
          title: const Text('회원가입', style: TextStyle(fontFamily: 'bitbit', fontSize: 30)),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Center(  
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.radio_button_unchecked_outlined, size: 20),
                        SizedBox(width: 20),
                        Icon(Icons.radio_button_unchecked_outlined, size: 20),
                        SizedBox(width: 20),
                        Icon(Icons.radio_button_unchecked_outlined, size: 20),
                        SizedBox(width: 20),
                        Icon(Icons.radio_button_checked, size: 40),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text('회원가입 정보를 확인해 주세요', style: TextStyle(fontSize: 20)),
                  const SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const SizedBox(width: 20),
                          const Expanded(
                            flex: 1,
                            child: Icon(Icons.email, size: 40,),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            flex: 10,
                            child: Card(
                              child: SizedBox(
                                height: 40,
                                child: Center(
                                  child: Text(widget.email),
                                )
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const SizedBox(width: 20),
                          const Expanded(
                            flex: 1,
                            child: Icon(Icons.lock, size: 40,),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            flex: 10,
                            child: Card(
                              child: SizedBox(
                                height: 40,
                                child: Center(
                                  child: Text(widget.password),
                                )
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const SizedBox(width: 20),
                          const Expanded(
                            flex: 1,
                            child: Icon(Icons.phone, size: 40,),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            flex: 10,
                            child: Card(
                              child: SizedBox(
                                height: 40,
                                child: Center(
                                  child: Text(widget.phone),
                                )
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const SizedBox(width: 20),
                          const Expanded(
                            flex: 1,
                            child: Icon(Icons.person, size: 40,),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            flex: 10,
                            child: Card(
                              child: SizedBox(
                                height: 40,
                                child: Center(
                                  child: Text(widget.name),
                                )
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const SizedBox(width: 20),
                          const Expanded(
                            flex: 1,
                            child: Icon(Icons.badge, size: 40,),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            flex: 10,
                            child: Card(
                              child: SizedBox(
                                height: 40,
                                child: Center(
                                  child: Text(widget.nickName),
                                )
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const SizedBox(width: 20),
                          const Expanded(
                            flex: 1,
                            child: Icon(Icons.add_chart_rounded, size: 40,),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            flex: 10,
                            child: Card(
                              child: SizedBox(
                                height: 40,
                                child: Center(
                                  child: Text(widget.mbti),
                                )
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const SizedBox(width: 20),
                          const Expanded(
                            flex: 1,
                            child: Icon(Icons.school, size: 40,),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            flex: 10,
                            child: Card(
                              child: SizedBox(
                                height: 40,
                                child: Center(
                                  child: Text(widget.university),
                                )
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const SizedBox(width: 20),
                          const Expanded(
                            flex: 1,
                            child: Icon(Icons.history_edu, size: 40,),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            flex: 10,
                            child: Card(
                              child: SizedBox(
                                height: 40,
                                child: Center(
                                  child: Text(widget.department),
                                )
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const SizedBox(width: 20),
                          const Expanded(
                            flex: 1,
                            child: Icon(Icons.numbers, size: 40,),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            flex: 10,
                            child: Card(
                              child: SizedBox(
                                height: 40,
                                child: Center(
                                  child: Text(widget.studentId),
                                )
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  FilledButton(
                    onPressed: () async {
                      var result = await http.post(
                        Uri.parse(registUrl.toString()),
                        headers: {
                          "Accept": "application/json",
                          "Content-Type": "application/json"
                        },
                        body: json.encode({
                          "email": widget.email,
                          "user_pw": widget.password,
                          "phone_number": widget.phone,
                          "user_name": widget.name,
                          "gender": widget.gender,
                          "user_mbti": widget.mbti,
                          "user_nick": widget.nickName,
                          "university": widget.university,
                          "department": widget.department,
                          "student_id": widget.studentId,
                        })
                      );
                      if (!mounted) return;
                      if (result.statusCode == 200) {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => const LoginPage()
                          ),
                          (route) => false
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('회원가입에 실패했습니다.'),
                          )
                        );
                      }
                    },
                    child: const Text('회원가입 완료'),
                  )
                ],
              )
            )
          )
        )
      ),
    );
  }
}