import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_order_project/screens/login_screen.dart';
import '../theme.dart';

class HomeScreen extends StatelessWidget {
  // const name ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 32,
            horizontal: 20,
          ), //EdgeInsets.symmetric
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
              Row(
                children: [
                  Image.asset(
                    'assets/images/pic1.png',
                    width: 130,
                    height: 110,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          'assets/images/promo.png',
                          width: 47,
                          height: 16,
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          'Zamburger',
                          style: poppinsTextStyle.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: blackColor,
                          ),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Row(
                          children: [
                            Text(
                              'RM 15',
                              style: poppinsTextStyle.copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: greyColor,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              'RM 8',
                              style: poppinsTextStyle.copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: yellowColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          'Free Delivery',
                          style: poppinsTextStyle.copyWith(
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                            color: greyColor,
                          ),
                        ),
                      ]),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
