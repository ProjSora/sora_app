/*
  Main entry point for the app.
*/
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sora/providers/login_model.dart';
import 'package:sora/providers/user_model.dart';
import 'package:sora/screens/Login/login.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Login()),
        ChangeNotifierProvider(create: (_) => UserInfo()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyApp();
}

class _MyApp extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sora App',
      theme: ThemeData(
        fontFamily: 'Hakgyo',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightGreen),
        useMaterial3: true,
      ),
      home: const LoginPage(),
    );
  }
}