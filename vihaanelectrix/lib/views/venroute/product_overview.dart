import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:vihaanelectrix/providers/product_details_provider.dart';
import 'package:vihaanelectrix/providers/user_details_provider.dart';

import 'package:vihaanelectrix/utilities/constants.dart';
import 'package:vihaanelectrix/views/home/profile_drawer.dart';
import 'package:vihaanelectrix/views/venroute/specification.dart';
import 'package:vihaanelectrix/views/venroute/test_ride.dart';
import 'package:vihaanelectrix/widgets/app_bar.dart';
import 'package:vihaanelectrix/widgets/app_config.dart';
import 'package:vihaanelectrix/widgets/elevated_widget.dart';
import 'package:vihaanelectrix/widgets/pdf_viewer.dart';

import 'package:vihaanelectrix/widgets/text_wid.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';

import 'package:flutter_vibrate/flutter_vibrate.dart';

class ProductOverview extends StatefulWidget {
  final dynamic product;
  const ProductOverview({
    Key? key,
    this.product,
  }) : super(key: key);

  @override
  _ProductOverviewState createState() => _ProductOverviewState();
}

UserDetailsProvider? profileProvider;
ProductDetailsProvider? productProvider;
// DrawerControl? drawerController;
var spec = {
  'speed': '200km/hr',
  'riding_range': '200km',
  'Battery_capacity': '200mAh',
  'charging_time_icon': '200min',
};

bool _canVibrate = true;
final pauses = [
  const Duration(microseconds: 100),
];

class _ProductOverviewState extends State<ProductOverview> {
  @override
  void initState() {
    super.initState();
    profileProvider = Provider.of<UserDetailsProvider>(context, listen: false);
    productProvider =
        Provider.of<ProductDetailsProvider>(context, listen: false);
    _init();
  }

  Future<void> _init() async {
    bool canVibrate = await Vibrate.canVibrate;
    setState(() {
      _canVibrate = canVibrate;
      _canVibrate
          ? debugPrint('This device can vibrate')
          : debugPrint('This device cannot vibrate');
    });
  }

  @override
  Widget build(BuildContext context) {
    // log(widget.product.toString());
    // log(drawerControl!.dummy.toString());
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: NavigationDrawerWidget(),
      bottomSheet: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            child: ElevatedButtonWidget(
              onClick: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TestRideBooking(
                              productId: widget.product['_id'].toString(),
                              userDetails:
                                  profileProvider?.user['_id'].toString(),
                            )));
              },
              height: height(context) * 0.08,
              minWidth: width(context),
              buttonName: 'Test Ride',
              elevation: 10,
              bgColor: Colors.grey[900],
              textSize: width(context) * 0.05,
              // leftRadius: 20.0,
              // rightRadius: 20.0,
              allRadius: false,
              textColor: Colors.white,
              borderSideColor: Colors.grey[900],
            ),
          ),
          // SizedBox(
          //   child: ElevatedButtonWidget(
          //     onClick: () {},
          //     height: height(context) * 0.08,
          //     minWidth: width(context) * 0.5,
          //     buttonName: 'Book Now',
          //     elevation: 10,
          //     rightRadius: 20.0,
          //     allRadius: false,
          //     bgColor: Colors.grey[900],
          //     textSize: width(context) * 0.05,
          //     textColor: Colors.white,
          //     borderSideColor: Colors.grey[900],
          //   ),
          // ),
        ],
      ),
      appBar: appbar(context),
      body: Consumer<UserDetailsProvider>(builder: (context, data, child) {
        // var uD = data.getUser;
        //log(widget.product.toString());
        return ListView(
          children: [
            SizedBox(
              height: height(context) * 0.02,
            ),
            Container(
              height: height(context) * 0.07,
              width: width(context) * 0.3,
              padding: EdgeInsets.all(width(context) * 0.04),
              child: Image.asset(
                'assets/pngs/corbett_icon.png',
                height: height(context) * 0.05,
                width: width(context) * 0.3,
              ),
              // child:Image.network(widget.product['basicDetails']
              //                     ['logo']
              //                 .toString()),
              //           ),
            ),
            Stack(
              children: [
                Container(
                    color: Colors.white,
                    height: height(context) * 0.7,
                    width: width(context),
                    child: Hero(
                      tag: widget.product['_id'],
                      child: CarouselSlider.builder(
                        itemCount:
                            widget.product['basicDetails']['media'].length,
                        itemBuilder: (BuildContext context, int itemIndex,
                                int pageViewIndex) =>
                            SizedBox(
                          child: FadeInImage.assetNetwork(
                              placeholder:
                                  'assets/pngs/vehicle_placeholder.png',
                              image: widget.product['basicDetails']['media']
                                      [itemIndex]['mediaUrl']
                                  //         ['media'][itemIndex]['mediaUrl'])
                                  // child: Image.network(widget.product['basicDetails']
                                  //         ['media'][itemIndex]['mediaUrl']
                                  .toString()),
                        ),
                        options: CarouselOptions(
                          height: height(context) * 0.4,
                          aspectRatio: 16 / 9,
                          viewportFraction: 0.8,
                          initialPage: 0,
                          enableInfiniteScroll: false,

                          reverse: false,
                          autoPlay: true,
                          autoPlayInterval: Duration(seconds: 3),
                          autoPlayAnimationDuration:
                              Duration(milliseconds: 800),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enlargeCenterPage: true,
                          // onPageChanged: callbackFunction,
                          scrollDirection: Axis.horizontal,
                        ),
                      ),
                    )),
                Positioned(
                    bottom: 0,
                    right: 0,
                    child: SizedBox(
                      height: height(context) * 0.2,
                      width: width(context) * 0.25,
                      // color: Colors.amber,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // InkWell(
                          //   onTap: () {
                          //     updateWishList(context, widget.product['_id']);
                          //   },
                          //   child: animatedbutton(
                          //       context,
                          //       widget.product['_id'],
                          //       Icons.favorite,
                          //       Colors.red,
                          //       'wish'),
                          // ),
                          // InkWell(
                          //   onTap: () {
                          //     updateCart(context, widget.product['_id']);
                          //   },
                          //   child: animatedbutton(
                          //       context,
                          //       widget.product['_id'],
                          //       Icons.shopping_bag,
                          //       Colors.grey,
                          //       'Cart'),
                          // ),

                          // animatedbutton(context, widget.product['_id'],
                          //     Icons.shopping_bag, Colors.grey, 'Cart'),
                          InkWell(
                            onTap: () {
                              // log(widget.product['_id']);
                              profileProvider?.addNewItemToCartorWishList(
                                  widget.product['_id'], "wishList");
                              // updateWishList(context, widget.product['_id'],
                              //     profileProvider);

                              Vibrate.vibrate();
                            },
                            child: CircleAvatar(
                              backgroundColor: Colors.grey[200],
                              radius: width(context) * 0.05,
                              child: Icon(
                                Icons.favorite,
                                color: profileProvider
                                        ?.checkProductInCartorWishList(
                                            widget.product['_id'], "wishList")
                                    ? Colors.pink
                                    : Colors.grey[500],
                                size: width(context) * 0.05,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              profileProvider?.addNewItemToCartorWishList(
                                  widget.product['_id'], "cart");
                              // updateCart(context, widget.product['_id'],
                              //     profileProvider);
                              Vibrate.vibrate();
                            },
                            child: CircleAvatar(
                              backgroundColor: Colors.grey[200],
                              radius: width(context) * 0.05,
                              child: Icon(
                                Icons.shopping_cart,
                                color: !profileProvider
                                        ?.checkProductInCartorWishList(
                                            widget.product['_id'].toString(),
                                            "cart")
                                    ? Colors.grey[500]
                                    : Colors.blue,
                                size: width(context) * 0.05,
                              ),
                            ),
                          )
                        ],
                      ),
                    ))
              ],
            ),
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.only(
                  right: width(context) * 0.08, left: width(context) * 0.08),
              height: height(context) * 0.07,
              width: width(context),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: height(context) * 0.04,
                    width: width(context) * 0.18,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      color: Colors.greenAccent[700],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextWidget(
                          text: '4.9',
                          color: Colors.white,
                          weight: FontWeight.w700,
                          size: width(context) * 0.04,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.white,
                          size: width(context) * 0.04,
                        ),
                      ],
                    ),
                  ),
                  TextWidget(
                    text: "₹ " +
                        widget.product['basicDetails']['price'].toString(),
                    color: Colors.grey[900],
                    size: width(context) * 0.07,
                    weight: FontWeight.w600,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: height(context) * 0.02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...productProvider
                    ?.getSameColorProduct(widget.product['modelId'])
                    .map((colorProduct) => InkWell(
                          onTap: () {
                            if (colorProduct['_id'] == widget.product['_id']) {
                              return;
                            }

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProductOverview(
                                        product: colorProduct)));
                          },
                          child: Container(
                            margin: EdgeInsets.all(3),
                            width: colorProduct['_id'] == widget.product['_id']
                                ? 20
                                : 15,
                            height: colorProduct['_id'] == widget.product['_id']
                                ? 20
                                : 15,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: HexColor(colorProduct['colorDetails']
                                    ['primaryColor'])),
                          ),
                        ))
              ],
            ),
            Padding(
              padding: EdgeInsets.all(width(context) * 0.03),
              child: TextWidget(
                text:
                    'The most enduring bike comes with an assert of peak specifications Boom Corbett 14 EX - An exo-skeletal double-cradle chassis made of high-tensile steel',
                color: Colors.grey[900],
                size: width(context) * 0.045,
                flow: TextOverflow.visible,
                weight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: height(context) * 0.02,
            ),
            Padding(
              padding: EdgeInsets.only(left: width(context) * 0.03),
              child: TextWidget(
                text: 'Specifications :',
                color: Colors.grey[900],
                size: width(context) * 0.06,
                weight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: height(context) * 0.02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                specItems(context, 'speed', 'Speed', spec['speed']),
                specItems(
                    context, 'riding_range', 'Range', spec['riding_range']),
                specItems(context, 'Battery_capacity', 'battery',
                    spec['Battery_capacity']),
                specItems(context, 'charging_time_icon', 'Charing Time',
                    spec['charging_time_icon']),
              ],
            ),
            SizedBox(
              height: height(context) * 0.02,
            ),
            SizedBox(
                height: height(context) * 0.8,
                width: width(context),
                child: pdfViewer()),
            SizedBox(
              height: height(context) * 0.2,
            ),
          ],
        );
      }),
    );
  }
}
