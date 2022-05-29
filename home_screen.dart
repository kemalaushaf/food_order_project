import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_order_project/models/menu.dart';
import 'package:food_order_project/screens/login_screen.dart';
import 'package:food_order_project/theme.dart';
import 'package:food_order_project/widgets/menu_card.dart';

class HomeScreen extends StatelessWidget {
  // const name ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference products = firestore.collection('products');
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 32,
            horizontal: 20,
          ), //EdgeInsets.symmetric
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hello, Fikar',
                  style: poppinsTextStyle.copyWith(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    color: blackColor,
                  ),
                ),
                Text(
                  'Welcome To Yummy Food',
                  style: poppinsTextStyle.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: greyColor,
                  ),
                ),
                SizedBox(
                  height: 32,
                ),
                Text('Recommended Menu',
                    style: poppinsTextStyle.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: blackColor,
                    )),
                SizedBox(
                  height: 32,
                ),
                StreamBuilder<QuerySnapshot>(
                    stream:
                        products.orderBy('id', descending: false).snapshots(),
                    builder: (_, snapshot) {
                      {
                        if (snapshot.hasData) {
                          return Column(
                            // ignore: unnecessary_cast
                            children: (snapshot.data! as QuerySnapshot)
                                .docs
                                .map(
                                  (e) => MenuCard(
                                    Menu(
                                      id: e['id'],
                                      image: e['image'],
                                      name: e['name'],
                                      price: e['price'],
                                      pricepromo: e['pricePromo'],
                                      note: e['note'],
                                      isPromo: e['isPromo'],
                                    ),
                                  ),
                                )
                                .toList(),
                          );
                        } else {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
