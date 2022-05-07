import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_order_project/screens/home_screen.dart';
import 'package:food_order_project/screens/regis_screen.dart';
import 'package:food_order_project/screens/reset_password.dart';
import 'package:food_order_project/utils/color_utils.dart';
import 'package:food_order_project/reusable_widgets/reusable_widget.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({ Key? key }) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {

    TextEditingController _passwordTextController = TextEditingController();
    TextEditingController _emailTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        20,MediaQuery.of(context).size.height * 0.2,20,0),
        child: Column(
          children:<Widget>[
            logoWidget("assets/images/food_logo.png"),
            SizedBox(
              height: 30,
            ),
            reusableTextField("Enter Email Address", Icons.person_outline, false, 
            _emailTextController),
             SizedBox(
              height: 20,
            ),
             reusableTextField("Enter Password", Icons.lock_outline, true, 
             _passwordTextController),
            SizedBox(
              height: 5,
            ),
            forgetPassword(context),
             firebaseButton(context, "Log In", (){
               FirebaseAuth.instance
              .signInWithEmailAndPassword(
                email: _emailTextController.text,
                password: _passwordTextController.text)
              .then((value){
                    Navigator.push(context, 
               MaterialPageRoute(builder: (context)=>HomeScreen()));
                }).onError((error, stackTrace) {
                  print("Error ${error.toString()}");
                });

               
             }),
             signUpOption()
          ],
         ),
        ),
       ),
      ),
     );
  }

  Row signUpOption(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have an account?",
        style: TextStyle(color: Colors.black)),
        GestureDetector(
          onTap: (){
            Navigator.push(context, 
            MaterialPageRoute(builder: (context) => SignUpScreen()));
          },
          child: const Text(
            "Registration",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }

  Widget forgetPassword (BuildContext context){
    return Container(width: MediaQuery.of(context).size.width,
    height: 35,
    alignment: Alignment.bottomRight,
    child: TextButton(
      child: Text(
        "Forgot Password?", 
         style: TextStyle(color: Colors.black),
          textAlign: TextAlign.right,
          ),
           onPressed: ()=> Navigator.push(
             context, MaterialPageRoute(builder: (context) => ResetPassword())),
       ),
    );
  }
}
