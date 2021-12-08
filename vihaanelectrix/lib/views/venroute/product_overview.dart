import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:vihaanelectrix/providers/user_details_provider.dart';
import 'package:vihaanelectrix/repo/api_methods.dart';
import 'package:vihaanelectrix/repo/api_urls.dart';
import 'package:vihaanelectrix/widgets/app_config.dart';
import 'package:vihaanelectrix/widgets/elevated_widget.dart';
import 'package:vihaanelectrix/widgets/snackbar.dart';
import 'package:vihaanelectrix/widgets/text_wid.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:provider/provider.dart';

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

class _ProductOverviewState extends State<ProductOverview> {
  @override
  void initState() {
    super.initState();
    profileProvider = Provider.of<UserDetailsProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    // log(widget.product.toString());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: TextWidget(
          text: widget.product['basicDetails']['modelName'].toString(),
          color: Colors.white,
          size: width(context) * 0.06,
          weight: FontWeight.w600,
        ),
      ),
      body: Consumer<UserDetailsProvider>(builder: (context, data, child) {
        var uD = data.getUser;
        // log(uD['wishList'].length.toString());
        return ListView(
          children: [
            Stack(
              children: [
                Container(
                    color: Colors.white,
                    height: height(context) * 0.8,
                    width: width(context),
                    // child: Text(widget.product.toString()),
                    child: CarouselSlider.builder(
                      itemCount: widget.product['basicDetails']['media'].length,
                      itemBuilder: (BuildContext context, int itemIndex,
                              int pageViewIndex) =>
                          SizedBox(
                        child: Image.network(widget.product['basicDetails']
                                ['media'][itemIndex]['mediaUrl']
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
                        autoPlayAnimationDuration: Duration(milliseconds: 800),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enlargeCenterPage: true,
                        // onPageChanged: callbackFunction,
                        scrollDirection: Axis.horizontal,
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
                          InkWell(
                            onTap: () {
                              // log(widget.product['_id']);
                              updateWishList(context, widget.product['_id'],
                                  uD['wishList'].length + 1);
                            },
                            child: CircleAvatar(
                              backgroundColor: Colors.grey[200],
                              radius: width(context) * 0.05,
                              child: Icon(
                                Icons.favorite,
                                color: Colors.pink,
                                size: width(context) * 0.05,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              updateCart(
                                  context, widget.product['_id'], uD['cart']);
                            },
                            child: CircleAvatar(
                              backgroundColor: Colors.grey[200],
                              radius: width(context) * 0.05,
                              child: Icon(
                                Icons.shopping_cart,
                                color: Colors.grey[500],
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
              alignment: Alignment.center,
              width: width(context),
              // padding: EdgeInsets.only(right: width(context) * 0.05),
              child: ElevatedButtonWidget(
                onClick: () {},
                height: height(context) * 0.057,
                minWidth: width(context) * 0.8,
                buttonName: 'Test Ride',
                trailingIcon: Icon(
                  Icons.arrow_forward,
                  size: width(context) * 0.05,
                ),
                bgColor: Colors.indigo[900],
                textSize: width(context) * 0.05,
                borderRadius: 10.0,
                textColor: Colors.white,
              ),
            ),
            SizedBox(
              height: height(context) * 0.02,
            ),
            Container(
              alignment: Alignment.center,
              width: width(context),
              // padding: EdgeInsets.only(right: width(context) * 0.05),
              child: ElevatedButtonWidget(
                onClick: () {},
                height: height(context) * 0.057,
                minWidth: width(context) * 0.8,
                buttonName: 'Buy Now',
                trailingIcon: Icon(
                  Icons.arrow_forward,
                  size: width(context) * 0.05,
                ),
                bgColor: Colors.indigo[900],
                textSize: width(context) * 0.05,
                borderRadius: 10.0,
                textColor: Colors.white,
              ),
            )
          ],
        );
      }),
    );
  }
}

updateWishList(
  BuildContext context,
  id,
  uD,
) async {
  // var length = uD.length + 1;
  Map<String, String> body = {
    "wishList.$uD": id.toString(),
  };
  log(body.toString());
  dynamic resp =
      await Server().editMethod(API.userDetails + API.uid.toString(), body);
  log(resp.body.toString());
  if (resp.statusCode == 200) {
    log('200');
  } else if (resp.statusCode == 404) {
    log('404');
  } else {
    snackbar(context, "Something went wrong status code ${resp.statusCode}");
  }
}

updateCart(
  BuildContext context,
  id,
  uD,
) async {
  var length = uD.length + 1;
  log('$length');
  Map<String, String> body = {
    "cart.$length": id.toString(),
  };
  log(body.toString());
  dynamic resp =
      await Server().editMethod(API.userDetails + API.uid.toString(), body);
  log(resp.body.toString());
  if (resp.statusCode == 200) {
    log('200');
  } else if (resp.statusCode == 404) {
    log('404');
  } else {
    snackbar(context, "Something went wrong status code ${resp.statusCode}");
  }
}
