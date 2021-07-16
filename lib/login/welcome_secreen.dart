//@dart=2.9

import 'package:flutter/material.dart';
import 'package:todo/Extra/Custom_button.dart';
import 'package:todo/login/login_secreen.dart';
import 'package:todo/login/registration_screen.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(
                Icons.supervised_user_circle,
              ),
              SizedBox(
                height: 32,
              ),
              Text(
                'Welcome to To-Do',
                style: TextStyle(
                  fontFamily: 'Dancing',
                  fontSize: 24,
                ),
              ),
              SizedBox(
                height: 32,
              ),
              CustomButton(
                text: 'Login',
                mainColor: Colors.deepPurple,
                borderColor: Colors.white,
                onpress: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginPage()));
                },
              ),
              CustomButton(
                text: 'Sign Up',
                mainColor: Colors.lightBlue,
                borderColor: Colors.white,
                onpress: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RegistrationPage()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
