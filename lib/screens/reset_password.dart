import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_order_project/reusable_widgets/reusable_widget.dart';

import '../utils/color_utils.dart';
import 'home_screen.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({ Key? key }) : super(key: key);

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
TextEditingController _emailTextController = TextEditingController();

    
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 247, 172, 75),
        elevation: 0,
        title: const Text(
          "Reset Password",
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
         
          const SizedBox(
            height:20,
          ),
          reusableTextField("Enter Email", Icons.person_outline, false, 
          _emailTextController
          ),
          const SizedBox(
            height:20,
          ),
         firebaseButton(context, "Reset Password", (){
            FirebaseAuth.instance
            .sendPasswordResetEmail(email: _emailTextController.text)
            .then((value) => Navigator.of(context).pop());
         })
      ],
    ),
  ))),
);
  }
}