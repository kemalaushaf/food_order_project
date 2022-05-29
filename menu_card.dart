import 'package:flutter/material.dart';
import 'package:food_order_project/screens/detail_screen.dart';
import 'package:food_order_project/theme.dart';
import 'package:food_order_project/models/menu.dart';
import 'package:food_order_project/screens/detail_screen.dart';
import 'package:intl/intl.dart';

class MenuCard extends StatelessWidget {
  final Menu menu;
  MenuCard(this.menu);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailScreen(
                      menu.id,
                      menu.image,
                      menu.name,
                      menu.price,
                      menu.pricepromo,
                      menu.note,
                      menu.isPromo,
                    )));
      },
      child: Column(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                // ignore: sized_box_for_whitespace
                child: Container(
                  width: 130,
                  height: 110,
                  child: Image.network(
                    menu.image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                menu.isPromo
                    ? Image.asset(
                        'assets/images/promo.png',
                        width: 47,
                        height: 16,
                      )
                    : Image.asset(
                        'assets/images/bestseller.png',
                        width: 47,
                        height: 16,
                      ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  '${menu.name}',
                  style: poppinsTextStyle.copyWith(
                    fontSize: 19,
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
                      NumberFormat.currency(
                              locale: 'ms', symbol: 'RM', decimalDigits: 0)
                          .format(menu.price),
                      style: poppinsTextStyle.copyWith(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: greyColor,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      NumberFormat.currency(
                              locale: 'ms', symbol: 'RM', decimalDigits: 0)
                          .format(menu.pricepromo),
                      style: poppinsTextStyle.copyWith(
                        fontSize: 20,
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
                    fontSize: 20,
                    fontWeight: FontWeight.w300,
                    color: greyColor,
                  ),
                ),
              ]),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
