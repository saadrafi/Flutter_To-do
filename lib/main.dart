import 'package:flutter/material.dart';
import 'package:todo/View/Login/splash.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:todo/View/home_page.dart';
import 'package:todo/login/welcome_secreen.dart';

import 'View/Login/login_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(),
      debugShowCheckedModeBanner: false,
      home: WelcomePage(),
    );
  }
}
