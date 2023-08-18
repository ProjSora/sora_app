import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sora/utils/urls.dart';

class RegistPage extends StatefulWidget {
  const RegistPage({Key? key}) : super(key: key);

  // This widget is the regist page of the app.
  @override
  State<RegistPage> createState() => _RegistPageState();
}

class _RegistPageState extends State<RegistPage> {
  // This is the state of the regist page.
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController passwordConfirmController;
  late TextEditingController genderController;
  late TextEditingController phoneController;
  late TextEditingController universityController;
  late TextEditingController departmentController;
  late TextEditingController studentIdController;
  late TextEditingController descriptionController;

  bool passwordVisible = false;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    passwordConfirmController = TextEditingController();
    genderController = TextEditingController();
    phoneController = TextEditingController();
    universityController = TextEditingController();
    departmentController = TextEditingController();
    studentIdController = TextEditingController();
    descriptionController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child : Scaffold(
        appBar: AppBar(
          leading: BackButton(
            onPressed: () {
              Navigator.pop(context);
            },
            color: ColorScheme.fromSwatch(primarySwatch: Colors.lightGreen)
                .secondary,
          ),
          title: const Text('Regist'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget> [
                  TextField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'email',
                      labelText:'id',
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
                      labelText:'password',
                      suffixIcon: IconButton(
                        icon : Icon(passwordVisible ? Icons.visibility : Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            passwordVisible = !passwordVisible;
                          });
                        },
                      )
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    obscureText: passwordVisible,
                    enableSuggestions: false,
                    autocorrect: false,
                    controller: passwordConfirmController,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText:'password confirm',
                      suffixIcon: IconButton(
                        icon : Icon(passwordVisible ? Icons.visibility : Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            passwordVisible = !passwordVisible;
                          });
                        },
                      )
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: genderController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'gender',
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: phoneController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText:'phone',
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: universityController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText:'university',
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: departmentController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText:'department',
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: studentIdController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText:'student id',
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: descriptionController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText:'description',
                    ),
                  ),
                  const SizedBox(height: 10),
                  FilledButton(
                    onPressed: () async {
                      var result = await http.post(
                        Uri.parse(registUrl.toString()),
                        headers: {
                          "Accept": "application/json",
                          "Content-Type": "application/json",
                        },
                        body: json.encode({
                          "email": emailController.text,
                          "user_pw": passwordController.text,
                          "phone": phoneController.text,
                          "university": universityController.text,
                          "department": departmentController.text,
                          "student_id": studentIdController.text,
                          "description": descriptionController.text,
                        })
                      );
                      if (!mounted) return;
                      if (result.statusCode == 200) {
                        _showDialog('Regist success');
                        Navigator.pop(context);
                      } else {
                        _showDialog('Regist failed');
                      }
                    },
                    child: const Text('Regist'),
                  ),
                ],
              )
            ),
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