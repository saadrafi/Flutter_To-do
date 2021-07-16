//@dart=2.9

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo/Extra/Custom_button.dart';
import 'package:todo/login/login_secreen.dart';
import 'package:todo/login/registration_screen.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key key}) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Firebase.initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Icon(
                  Icons.supervised_user_circle,
                  size: 200,
                ),
                SizedBox(
                  height: 32,
                ),
                Center(
                  child: Text(
                    'Welcome to To-Do',
                    style: TextStyle(
                      fontFamily: 'Dancing',
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 48,
                ),
                CustomButton(
                  text: 'Login',
                  mainColor: Colors.deepPurple,
                  borderColor: Colors.white,
                  onpress: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return LoginPage();
                    }));
                  },
                ),
                SizedBox(height: size.height * 0.03),
                CustomButton(
                  text: 'Sign Up',
                  mainColor: Colors.lightBlue,
                  borderColor: Colors.white,
                  onpress: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return RegistrationPage();
                    }));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
