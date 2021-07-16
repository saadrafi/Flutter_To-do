//@dart=2.9
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/Extra/Custom_button.dart';
import 'package:todo/Extra/custom_toast.dart';
import 'package:todo/Extra/input_field.dart';
import 'package:todo/View/home_page.dart';
import 'package:todo/login/login_secreen.dart';
class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key key}) : super(key: key);

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  // String email;
  // String name;
  // String password;
  TextEditingController _nametextEditingController;
  TextEditingController _emailtextEditingController;
  TextEditingController _passwordtextEditingController;
  bool obsecure=true;
  final _auth = FirebaseAuth.instance;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _passwordtextEditingController=TextEditingController();
    _nametextEditingController=TextEditingController();
    _emailtextEditingController=TextEditingController();
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
                textEditingController: _nametextEditingController,
                hintText: 'Username',
                obsecure: false,
                keyboard: TextInputType.text,
                userTyped: (){
                  // name=value;
                },
                leadIcon: Icons.person,
              ),
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
                textEditingController: _passwordtextEditingController,
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
                text: 'Sign Up',
                mainColor: Colors.deepPurple,
                borderColor: Colors.white,
                onpress: () async {
                  try{
                    final newUser=await  _auth.createUserWithEmailAndPassword(email: _emailtextEditingController.text, password: _passwordtextEditingController.text);
                  if(newUser!=null){
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomePage()), (route) => false);
                    CustomToast.toast('Registration Successful');
                  }
                  }catch(error){
                    print(error.toString());
                  }
                },
              ),
              SizedBox(height: size.height * 0.03),
              Row(
                children: [
                  Text('Already have an account'),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
                    },child: Text('Log In'),
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
