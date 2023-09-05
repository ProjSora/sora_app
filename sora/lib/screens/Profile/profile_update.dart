import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sora/providers/user_model.dart';
import 'package:sora/screens/home/utils/bottom_navigate.dart';
import 'package:http/http.dart' as http;
import 'package:sora/utils/urls.dart';
import 'dart:convert';
import 'package:sora/screens/Profile/profile.dart';
import 'package:sora/utils/university.dart';

class ConfirmUpdateProfile extends StatefulWidget {
  const ConfirmUpdateProfile({Key? key}) : super(key: key);

  // This widget is the profile page of the app.
  @override
  State<ConfirmUpdateProfile> createState() => _ConfirmUpdateProfileState();
}

class _ConfirmUpdateProfileState extends State<ConfirmUpdateProfile> {
  late TextEditingController passwordController;

  bool confirmPasswordVisible = true;
  bool confirmPasswordEnbale = false;

  @override
  void initState() {
    super.initState();
    passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    UserInfo userInfo = Provider.of<UserInfo>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('회원정보 수정', style: TextStyle(fontFamily: 'bitbit', fontSize: 30)),
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              const Text("회원정보 수정을 위해 비밀번호를 입력해주세요.", style: TextStyle(fontSize: 20)),
              const SizedBox(height: 20),
              TextField(
                obscureText: confirmPasswordVisible,
                enableSuggestions: false,
                autocorrect: false,
                decoration: InputDecoration(
                  icon: const Icon(Icons.password),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(100))
                  ),
                  labelText: '비밀번호',
                  suffixIcon: IconButton(
                    icon: Icon(confirmPasswordVisible ? Icons.visibility : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        confirmPasswordVisible = !confirmPasswordVisible;
                      });
                    },
                  )
                ),
                controller: passwordController,
                onChanged: (text) => {
                  if (text.isNotEmpty) {
                    setState(() {
                      confirmPasswordEnbale = true;
                    })
                  } else {
                    setState(() {
                      confirmPasswordEnbale = false;
                    })
                  } 
                },
              ),
              const SizedBox(height: 20),
              FilledButton(
                onPressed: (confirmPasswordEnbale) ? () async {
                  var result = await http.post(
                    Uri.parse(loginUrl.toString()),
                    headers: {
                      "Accept": "application/json",
                      "Content-Type": "application/json",
                    },
                    body: json.encode({
                      "user_id": userInfo.userId,
                      "user_pw": passwordController.text,
                    }),
                  );
                  var response = jsonDecode(utf8.decode(result.bodyBytes));
                  if (!mounted) return;
                  if (result.statusCode == 200 && response['status'] == "success") {
                    Navigator.pushReplacement(context,
                      MaterialPageRoute(
                        builder: (context) => const UpdateProfile(),
                      )
                    );
                  } else {
                    _showDialog("비밀번호가 일치하지 않습니다.");
                  }
                } : null,
                child: const Text("확인"),
              )
            ],
          ),
        ),
      )
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
          )
        ]
      )
    );
  }
}

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({Key? key}) : super(key: key);

  // This widget is the profile page of the app.
  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  late TextEditingController nickNameController;
  late TextEditingController mbtiController;
  late TextEditingController universityController;
  late TextEditingController departmentController;

  final List<String> mbtiList = [
    'ISTJ', 'ISFJ', 'INFJ', 'INTJ',
    'ISTP', 'ISFP', 'INFP', 'INTP',
    'ESTP', 'ESFP', 'ENFP', 'ENTP',
    'ESTJ', 'ESFJ', 'ENFJ', 'ENTJ'
  ];

  late List<String> university = universityList;

  String? selectedMbti;
  String? selectedUniversity;

  @override
  void initState() {
    super.initState();
    nickNameController = TextEditingController();
    mbtiController = TextEditingController();
    universityController = TextEditingController();
    departmentController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('회원정보 수정', style: TextStyle(fontFamily: 'bitbit', fontSize: 30)),
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            TextField(
              controller: nickNameController,
              decoration: const InputDecoration(
                icon: Icon(Icons.badge),
                border: OutlineInputBorder(),
                labelText: '닉네임',
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: mbtiController,
              decoration: const InputDecoration(
                icon: Icon(Icons.person),
                border: OutlineInputBorder(),
                labelText: 'MBTI',
              ),
            )
          ]
        )
      ),
    );
  }
}