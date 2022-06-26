import 'package:flutter/material.dart';
import 'package:food_order_project/screens/admin_home.dart';
import 'package:food_order_project/screens/home_screen.dart';
import 'package:food_order_project/theme.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:food_order_project/widgets/size_card.dart';
import 'package:food_order_project/models/size.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:food_order_project/api/notification_api.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:food_order_project/mobile.dart';

class DetailScreen extends StatefulWidget {
  int id;
  String image;
  String name;
  int price;
  int pricepromo;
  String note;
  bool isPromo;
  DetailScreen(this.id, this.image, this.name, this.price, this.pricepromo,
      this.note, this.isPromo,
      {Key? key})
      : super(key: key);


  @override
  State<DetailScreen> createState() =>
      // ignore: no_logic_in_create_state
      _DetailScreen(
        id,
        image,
        name,
        price,
        pricepromo,
        note,
        isPromo,
      );
}

class _DetailScreen extends State<DetailScreen> {
  int _id;
  String _image;
  String _name;
  int _price;
  int _pricePromo;
  String _note;
  bool _isPromo;

  _DetailScreen(
    this._id,
    this._image,
    this._name,
    this._price,
    this._pricePromo,
    this._note,
    this._isPromo,
  );

  

// const name({Key? key}) : super(key: key);
  late int dataPrice = _price; // data dari firebase
  late int dataPricePromo = _pricePromo; //data dari firebase

  late int price = _price;
  late int pricePromo = _pricePromo;

  int i = 1;
  bool isMini = true; //harga tetap
  bool isNormal = false; //harga +2000
  bool isBig = false; //harga +4000
  bool isSuperBig = false; //harga +6000

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  
  void initState(){
    super.initState();

    NotificationApi.init();
    listenNotifications();
  }

  void listenNotifications()=>
    NotificationApi.onNotifications.stream.listen(onClickedNotification);

  void onClickedNotification(String? payload) =>
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => Admin_home(),
      ));

  Future <void> _createPDF()async{
    PdfDocument document = PdfDocument();
    /*final page = document.pages.add();

  page.graphics.drawString('Customer Order: $_image Quantity: $i Total Fee: RM$pricePromo',
  PdfStandardFont(PdfFontFamily.helvetica, 18));*/

    PdfGrid grid = PdfGrid();
    grid.style = PdfGridStyle(
      font: PdfStandardFont(PdfFontFamily.helvetica, 30),
      cellPadding: PdfPaddings(left: 5, right: 2, top: 2, bottom: 2));
    grid.columns.add(count: 3);
    grid.headers.add(1);

    PdfGridRow header = grid.headers[0];
    header.cells[0].value = 'Order';
    header.cells[1].value = 'Quantity';
    header.cells[2].value = 'Total Fee';
    
    PdfGridRow row = grid.rows.add();
    row.cells[0].value = '$_name';
    row.cells[1].value = '$i';
    row.cells[2].value = '$pricePromo';
    
    grid.draw(
      page:document.pages.add(),
      bounds: const Rect.fromLTWH(0, 0, 0, 0));
    
    List <int> bytes = document.save();
    document.dispose();

    saveAndLaunchFile(bytes, 'Order.pdf');
  }
  

  void _minus() {
    if (i > 1) {
      setState(() {
        i--;
        if (isMini) {
          price = dataPrice * i;
          pricePromo = dataPricePromo * i;
        } else if (isNormal) {
          price = (dataPrice + 2) * i;
          pricePromo = (dataPricePromo + 2) * i;
        } else if (isBig) {
          price = (dataPrice + 4) * i;
          pricePromo = (dataPricePromo + 4) * i;
        } else if (isSuperBig) {
          price = (dataPrice + 6) * i;
          pricePromo = (dataPricePromo + 6) * i;
        }
      });
    }
  }

  void _plus() {
    setState(() {
      i++;
      if (isMini) {
        price = dataPrice * i;
        pricePromo = dataPricePromo * i;
      } else if (isNormal) {
        price = (dataPrice + 2) * i;
        pricePromo = (dataPricePromo + 2) * i;
      } else if (isBig) {
        price = (dataPrice + 4) * i;
        pricePromo = (dataPricePromo + 4) * i;
      } else if (isSuperBig) {
        price = (dataPrice + 6) * i;
        pricePromo = (dataPricePromo + 6) * i;
      }
    });
  }

  void _clickMini() {
    setState(() {
      price = dataPrice * i;
      pricePromo = dataPricePromo * i;
      isMini = true;
      isNormal = false;
      isBig = false;
      isSuperBig = false;
    });
  }

  void _clickNormal() {
    setState(() {
      price = (dataPrice + 2) * i;
      pricePromo = (dataPricePromo + 2) * i;
      isMini = false;
      isNormal = true;
      isBig = false;
      isSuperBig = false;
    });
  }

  void _clickBig() {
    setState(() {
      price = (dataPrice + 4) * i;
      pricePromo = (dataPricePromo + 4) * i;
      isMini = false;
      isNormal = false;
      isBig = true;
      isSuperBig = false;
    });
  }

  void _clickSuperBig() {
    setState(() {
      price = (dataPrice + 6) * i;
      pricePromo = (dataPricePromo + 6) * i;
      isMini = false;
      isNormal = false;
      isBig = false;
      isSuperBig = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    launchUrl(String url) async {
      launch(url);
    }

    return Scaffold(
       floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
         launchUrl(
         "https://www.facebook.com/post/create");},
        icon: const Icon(Icons.share),
        label: const Text('Share to facebook'),
        backgroundColor: Colors.orange,
      ),
       floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,


      body: SafeArea(
        child: Stack(
          children: [
            Image.network(
              _image,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 ),
            ),
            ListView(
              children: [
                SizedBox(height: 284),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                    color: Colors.white,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 1,
                          horizontal: 2,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _isPromo
                                ? Image.asset(
                                    'assets/images/promo2.png',
                                    width: 90,
                                  )
                                : Image.asset(
                                    'assets/images/bestseller.png',
                                    width: 90,
                                  ),
                            SizedBox(
                              height: 8,
                            ),
                            Row(
                              children: [
                                Text(
                                  _name,
                                  style: poppinsTextStyle.copyWith(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w500,
                                    color: blackColor,
                                  ),
                                ),
                                Spacer(),
                                InkWell(
                                  onTap: _minus,
                                  child: Image.asset(
                                    'assets/images/minus.png',
                                    width: 34,
                                  ),
                                ),
                                SizedBox(
                                  width: 16,
                                ),
                                Text(
                                  '${i}',
                                  style: poppinsTextStyle.copyWith(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w400,
                                    color: blackColor,
                                  ),
                                ),
                                InkWell(
                                  onTap: _plus,
                                  child: Image.asset(
                                    'assets/images/plus.png',
                                    width: 34,
                                  ),
                                ),
                                SizedBox(
                                  width: 16,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Row(
                              children: [
                                Text(
                                  NumberFormat.currency(
                                          locale: 'ms',
                                          symbol: 'RM',
                                          decimalDigits: 0)
                                      .format(price),
                                  style: poppinsTextStyle.copyWith(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: greyColor,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                Text(
                                  NumberFormat.currency(
                                          locale: 'ms',
                                          symbol: 'RM',
                                          decimalDigits: 0)
                                      .format(pricePromo),
                                  style: poppinsTextStyle.copyWith(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: yellowColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 18,
                            ),
                            Text(
                              'Choose Size',
                              style: poppinsTextStyle.copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: blackColor,
                              ),
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Row(
                              children: [
                                InkWell(
                                  onTap: _clickMini,
                                  child: SizeCard(
                                    Size(
                                      id: 1,
                                      name: 'Mini',
                                      isActive: isMini,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 12),
                                InkWell(
                                  onTap: _clickNormal,
                                  child: SizeCard(
                                    Size(
                                      id: 2,
                                      name: 'Normal',
                                      isActive: isNormal,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 12),
                                InkWell(
                                  onTap: _clickBig,
                                  child: SizeCard(
                                    Size(
                                      id: 3,
                                      name: 'Big',
                                      isActive: isBig,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 12),
                                InkWell(
                                  onTap: _clickSuperBig,
                                  child: SizeCard(
                                    Size(
                                      id: 4,
                                      name: 'Super Big',
                                      isActive: isSuperBig,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 18,
                            ),
                            Text(
                              'Seller Notes',
                              style: poppinsTextStyle.copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: blackColor,
                              ),
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              child: Text(
                                _note,
                                style: poppinsTextStyle.copyWith(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: greyColor,
                                ),
                                textAlign: TextAlign.justify,
                              ),
                            ),
                            SizedBox(
                              height: 18,
                            ),
                            Text(
                              'Yummy Food Location',
                              style: poppinsTextStyle.copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: blackColor,
                              ),
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            InkWell(
                              onTap: () {
                                launchUrl(
                                    "https://goo.gl/maps/EFEgvVgry9Mfb3Bv9");
                              },
                              child: Row(
                                children: [
                                  Image.asset(
                                    'assets/images/store.png',
                                    width: 50,
                                  ),
                                  SizedBox(width: 18),
                                  Text(
                                    'Taman Universiti Street Number 12\n Johor Bahru',
                                    style: poppinsTextStyle.copyWith(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: greyColor,
                                    ),
                                  ),
                                  Spacer(),
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.chevron_right,
                                      color: greyColor,
                                      size: 30,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(),
                            SizedBox(height: 18),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              child: RaisedButton(
                                padding: EdgeInsets.only(
                                  top: 12,
                                  bottom: 12,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                elevation: 0,
                                focusElevation: 0,
                                hoverElevation: 0,
                                highlightElevation: 0,
                                disabledElevation: 0,
                                onPressed:() {
                                NotificationApi.showNotification(
                                  title:'Admin',
                                  body:'NEW ORDER FROM CUSTOMER !!',
                                  payload: 'ORDER FROM CUSTOMER',
                                );
                                launchUrl(
                                      "https://wa.me/6281284904992?text=I%20want%20to%20buy%20$_name%20$i%20=%20RM%20$pricePromo"
                                );
                                _createPDF();
                                      },                              
                                color: yellowColor,
                                child: Text(
                                  'Buy',
                                  style: poppinsTextStyle.copyWith(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: whiteColor,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
