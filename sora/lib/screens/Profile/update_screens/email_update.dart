import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sora/providers/user_model.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sora/providers/login_model.dart';
import 'package:http/http.dart' as http;
import 'package:sora/utils/urls.dart';
import 'dart:convert';

class EmailUpdate extends StatefulWidget {
  const EmailUpdate({Key? key}) : super(key: key);

  // This widget is the profile page of the app.
  @override
  State<EmailUpdate> createState() => _EmailUpdateState();
}

class _EmailUpdateState extends State<EmailUpdate> {
  late TextEditingController newEmailController;

  static const storage = FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    newEmailController = TextEditingController();
  }
  @override
  Widget build(BuildContext context) {
    UserInfo userInfo = Provider.of<UserInfo>(context);
    Login loginInfo = Provider.of<Login>(context);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
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
                Text("현재 이메일은 : ${userInfo.userEmail}입니다."),
                const SizedBox(height: 20),
                TextField(
                  controller: newEmailController,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.email),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(100))
                    ),
                    labelText: "새로운 이메일",
                  ),
                ),
                FilledButton(
                  onPressed: (newEmailController.text.isNotEmpty) ? 
                  () async {
                    await storage.delete(key: "id");
                    await storage.write(
                      key: "id",
                      value: newEmailController.text
                    );
                    var result = await http.post(
                      Uri.parse(updateUserUrl.toString()),
                      headers: {
                        "Accept": "application/json",
                        "Content-Type": "application/json"
                      },
                      body: json.encode({
                        "user_id": userInfo.userId,
                        "email": newEmailController.text
                      })
                    );
                    var response = jsonDecode(utf8.decode(result.bodyBytes));
                    if (!mounted) return;
                    if (result.statusCode == 200 && response["status"] == "success") {
                      loginInfo.setEmail(newEmailController.text);
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
                        response["auth"],
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("이메일이 변경되었습니다."),
                        )
                      );
                      Navigator.pop(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(response["msg"]),
                        )
                      );
                    }
                  } : null,
                  child: const Text("이메일 변경"),
                )
              ],
            ),
          ),
        )
      )
    );
  }
}