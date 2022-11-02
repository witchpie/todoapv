import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:schedumol_app/screens/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());   //앱 시작해줘
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));

    return MaterialApp(
      debugShowCheckedModeBanner:false,
      title: 'todo app',
      home: Home(),
    );
  }
}
