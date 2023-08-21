import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:sora/screens/Regist/regist_4.dart';
import 'package:sora/utils/urls.dart';

class SignUpThirdPage extends StatefulWidget {
  final String email;
  final String password;
  final String phone;
  const SignUpThirdPage(this.email, this.password, this.phone, {Key? key})
      : super(key: key);

  @override
  State<SignUpThirdPage> createState() => _SignUpThirdPageState();
}

class _SignUpThirdPageState extends State<SignUpThirdPage> {
  late TextEditingController genderController;
  late TextEditingController universityController;
  late TextEditingController departmentController;
  late TextEditingController studentIdController;
  late TextEditingController descriptionController;

  @override
  void initState() {
    super.initState();
    genderController = TextEditingController();
    universityController = TextEditingController();
    departmentController = TextEditingController();
    studentIdController = TextEditingController();
    descriptionController = TextEditingController();
  }

  @override
  Widget build(BuildContext context){
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
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(widget.phone),
                  const Text("회원정보를 입력 해 주세요."),
                  const SizedBox(height: 20),
                  const Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("성별"),
                            SizedBox(height: 10),
                            GenderChoice(),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: universityController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: '대학교',
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: departmentController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: '학과',
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: studentIdController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: '학번',
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: descriptionController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: '자기소개',
                    ),
                  ),
                  const SizedBox(height: 20),
                  FilledButton(
                    onPressed: () async {
                      var result = await http.post(
                        Uri.parse(registUrl.toString()),
                        headers: {
                          "Accept": "application/json",
                          "Content-Type": "application/json",
                        },
                        body: json.encode({
                          "email" : widget.email,
                          "user_pw": widget.password,
                          "phone_number": widget.phone,
                          "university": universityController.text,
                          "department": departmentController.text,
                          "student_id": studentIdController.text,
                          "description": descriptionController.text,
                        })
                      );
                      if (!mounted) return;
                      if (result.statusCode == 200) {
                        _showDialog("회원가입이 완료되었습니다.");
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignUpFinishedPage(),
                          ),
                        );
                      } else {
                        _showDialog("회원가입에 실패하였습니다.");
                      }
                    },
                    child: const Text('완료'),
                  ),
                ],
              ),
            ),
          ),
        ),
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

enum Genders {male, female}

class GenderChoice extends StatefulWidget {
  const GenderChoice({Key? key}) : super(key: key);

  @override
  State<GenderChoice> createState() => _GenderChoiceState();
}

class _GenderChoiceState extends State<GenderChoice> {
  Genders selectedGender = Genders.male;

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<Genders>(
      segments: const <ButtonSegment<Genders>>[
        ButtonSegment<Genders>(
          value: Genders.male,
          label: Text('남자'),
          icon: Icon(Icons.man),
        ),
        ButtonSegment(
          value: Genders.female,
          label: Text("여자"),
          icon: Icon(Icons.girl)
        )
      ],
      selected: <Genders>{selectedGender},
      onSelectionChanged: (Set<Genders> newSelection) {
        setState(() {
          selectedGender = newSelection.first;
        });
      },
    );
  }
}