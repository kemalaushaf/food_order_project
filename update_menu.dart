import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:food_order_project/reusable_widgets/reusable_widget.dart';
import '../utils/color_utils.dart';

class UpdateMenu extends StatefulWidget {
  const UpdateMenu({Key? key}) : super(key: key);

  @override
  State<UpdateMenu> createState() => _UpdateMenuState();
}

class _UpdateMenuState extends State<UpdateMenu> {
  final TextEditingController _idTextController = TextEditingController();
  final TextEditingController _imageTextController = TextEditingController();
  final TextEditingController _isPromoTextController = TextEditingController();
  final TextEditingController _nameTextController = TextEditingController();
  final TextEditingController _noteTextController = TextEditingController();
  final TextEditingController _priceTextController = TextEditingController();
  final TextEditingController _pricePromoTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final docUser = FirebaseFirestore.instance
  .collection('products'); 
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        // ignore: prefer_const_constructors
        backgroundColor: Color.fromARGB(255, 247, 172, 75),
        elevation: 0,
        title: const Text(
          "Update Menu",
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
                20, MediaQuery.of(context).size.height * 0.2, 20, 0),
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 20,
                ),
                reusableTextField(
                    "Enter ID", Icons.person_outline, false, _idTextController),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Enter Name", Icons.person_outline, false,
                    _nameTextController),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Enter Note", Icons.lock_outline, false,
                    _noteTextController),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Enter price", Icons.person_outline, false,
                    _priceTextController),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Is Promo? 'True/False' ",
                    Icons.person_outline, false, _isPromoTextController),
                const SizedBox(
                  height: 20,
                ),                
                reusableTextField("Price Promo", Icons.person_outline, false,
                    _pricePromoTextController),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Enter Image", Icons.person_outline, false,
                    _imageTextController),
                TextButton(
                  style: TextButton.styleFrom(
                    primary: Colors.blue,
                    onSurface: Colors.red,
                  ),
                  onPressed: () {
                    final docUser = FirebaseFirestore.instance
                    .collection('products')
                    .doc('MWpe4SedQJSoCEqeWzkz');
                    docUser.update({
                      'id': int.tryParse(_idTextController.text),
                      'name': _nameTextController.text,
                      'note': _noteTextController.text,
                      'price': int.tryParse(_priceTextController.text),
                      'isPromo': _isPromoTextController.text,
                      'pricePromo':
                          int.tryParse(_pricePromoTextController.text),
                      'image': _imageTextController.text,
                    });                   
                    _idTextController.text = '';
                    _nameTextController.text = '';
                    _noteTextController.text = '';
                    _priceTextController.text = '';
                    _isPromoTextController.text = '';
                    _pricePromoTextController.text = '';
                    _imageTextController.text = '';
                  },
                  // ignore: prefer_const_constructors
                  child: Text('Update menu!'),
                ),
              ],
            ),
          ))),
    );
  }
}