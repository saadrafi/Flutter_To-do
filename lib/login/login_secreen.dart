//@dart=2.9
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/Extra/Custom_button.dart';
import 'package:todo/Extra/custom_toast.dart';
import 'package:todo/Extra/input_field.dart';
import 'package:todo/View/home_page.dart';
import 'package:todo/login/registration_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool obsecure = true;
  TextEditingController _emailtextEditingController;
  TextEditingController _passwordtextEditingController;
  // String email;
  // String password;
  final _auth =FirebaseAuth.instance;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _emailtextEditingController=TextEditingController();
    _passwordtextEditingController=TextEditingController();
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InputField(
                textEditingController: _emailtextEditingController,
                hintText: 'Enter E-mail',
                obsecure: false,
                leadIcon: Icons.email,
                keyboard: TextInputType.emailAddress,
                userTyped: () {
                  // email = value;
                },
              ),
              InputField(
                textEditingController:_passwordtextEditingController ,
                hintText: 'Enter password',
                obsecure: obsecure,
                leadIcon: Icons.lock,
                keyboard: TextInputType.visiblePassword,
                userTyped: () {
                  // password = value;
                },
                sufixIcon: obsecure == true
                    ? IconButton(
                        icon: Icon(Icons.remove_red_eye),
                        onPressed: () {
                          setState(() {
                            obsecure = false;
                          });
                        })
                    : IconButton(
                        onPressed: () {
                          setState(() {
                            obsecure = true;
                          });
                        },
                        icon: Icon(Icons.visibility_off)),
              ),
              SizedBox(height: size.height * 0.03),
              CustomButton(
                text: 'Sign In',
                mainColor: Colors.deepPurple,
                borderColor: Colors.white,
                onpress: () async {
                  try{
                    final logedUser=await _auth.signInWithEmailAndPassword(email: _emailtextEditingController.text, password: _passwordtextEditingController.text);
                    if (logedUser!=null){
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomePage()), (route) => false);
                     CustomToast.toast('Sign in Successful');
                    }
                  }catch(e){
                    print(e.toString());
                    CustomToast.toast('Not Singed In');
                  }
                },
              ),
              SizedBox(height: size.height * 0.03),
              Row(
                children: [
                  Text('Don\'t have an account'),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>RegistrationPage()));
                    },child: Text('Sign Up'),
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.03),
              Text('Made by Saad Rafi'),
            ],
          ),
        ),
      ),
    );
  }
}
