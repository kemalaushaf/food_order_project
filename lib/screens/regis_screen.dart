import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_order_project/reusable_widgets/reusable_widget.dart';

import '../utils/color_utils.dart';
import 'home_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({ Key? key }) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
TextEditingController _passwordTextController = TextEditingController();
TextEditingController _emailTextController = TextEditingController();
TextEditingController _userNameTextController = TextEditingController();
    
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 247, 172, 75),
        elevation: 0,
        title: const Text(
          "Registration",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
      hexStringToColor("FAFFFF"),
      hexStringToColor("FAFFFF"),
      hexStringToColor("FFBC3A")
    ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
    child: SingleChildScrollView( 
     child: Padding(
       padding: EdgeInsets.fromLTRB(
         20, MediaQuery.of(context).size.height * 0.2, 20, 0) ,
      child: Column(
        children: <Widget>[
          const SizedBox(
            height:20,
          ),
          reusableTextField("Enter Username", Icons.person_outline, false, 
          _userNameTextController
          ),
          const SizedBox(
            height:20,
          ),
          reusableTextField("Enter Email", Icons.person_outline, false, 
          _emailTextController
          ),
          const SizedBox(
            height:20,
          ),
          reusableTextField("Enter Password", Icons.lock_outline, true, 
          _passwordTextController
          ),
          const SizedBox(
            height:20,
          ),
          firebaseButton(context, "Registration", (){
            FirebaseAuth.instance
              .createUserWithEmailAndPassword(
                email: _emailTextController.text, 
                password: _passwordTextController.text)
              .then((value) {
                print("New Account Created");
                 Navigator.push(context,
             MaterialPageRoute(builder: (context) => HomeScreen()));
          }).onError((error, stackTrace) {
            print("Error ${error.toString()}");
          });
        })  
      ],
    ),
  ))),
);
  }
}