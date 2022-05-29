import 'package:flutter/material.dart';
import 'package:food_order_project/theme.dart';
import 'package:food_order_project/models/size.dart';

class SizeCard extends StatelessWidget {
  //const SizeCard({Key? key}) : super(key: key);

  final Size size;
  SizeCard(this.size);

  @override
  Widget build(BuildContext context) {
    return InkWell(      
      child: size.isActive
    ? Container (
        padding: EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 10
        ),
        decoration: BoxDecoration(
          color: whitegreyColor,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: whitegreyColor,
            width: 1.5,
          ),
        ),
      child: Text(
        size.name,
        style: poppinsTextStyle.copyWith(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: blackColor,
      ),
    ),
  )
  : Container (
      padding: EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 10
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
        color: whitegreyColor,
      width: 1.5,
          ),
        ),
      child: Text(
       size.name,
      style: poppinsTextStyle.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: blackColor,
      ),
    ),
   ),);
 }
}