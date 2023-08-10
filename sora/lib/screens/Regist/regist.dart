import 'package:flutter/material.dart';

class RegistPage extends StatefulWidget {
  const RegistPage({Key? key}) : super(key: key);

  // This widget is the regist page of the app.
  @override
  State<RegistPage> createState() => _RegistPageState();
}

class _RegistPageState extends State<RegistPage> {
  // This is the state of the regist page.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Regist'),
      ),
      body: const Center(
        child: Text(
          'Regist Page',
          style: TextStyle(fontSize: 36),
        ),
      ),
    );
  }
}