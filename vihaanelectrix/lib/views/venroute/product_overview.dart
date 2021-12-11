import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:vihaanelectrix/controllers/login.dart/drawer_control.dart';
import 'package:vihaanelectrix/providers/user_details_provider.dart';
import 'package:vihaanelectrix/repo/api_methods.dart';
import 'package:vihaanelectrix/repo/api_urls.dart';
import 'package:vihaanelectrix/views/home/profile_drawer.dart';
import 'package:vihaanelectrix/widgets/app_config.dart';
import 'package:vihaanelectrix/widgets/elevated_widget.dart';
import 'package:vihaanelectrix/widgets/pdf_viewer.dart';
import 'package:vihaanelectrix/widgets/snackbar.dart';
import 'package:vihaanelectrix/widgets/text_wid.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import 'package:like_button/like_button.dart';

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
// DrawerControl? drawerController;
var spec = {
  'speed': '200km/hr',
  'riding_range': '200km',
  'Battery_capacity': '200mAh',
  'charging_time_icon': '200min',
};

class _ProductOverviewState extends State<ProductOverview> {
  @override
  void initState() {
    super.initState();
    profileProvider = Provider.of<UserDetailsProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    log(widget.product.toString());
    // log(drawerControl!.dummy.toString());
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: NavigationDrawerWidget(),
      bottomSheet: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            child: ElevatedButtonWidget(
              onClick: () {},
              height: height(context) * 0.08,
              minWidth: width(context) * 0.5,
              buttonName: 'Test Ride',
              elevation: 10,
              bgColor: Colors.white,
              textSize: width(context) * 0.05,
              leftRadius: 20.0,
              allRadius: false,
              textColor: Colors.grey[900],
              borderSideColor: Colors.white,
            ),
          ),
          SizedBox(
            child: ElevatedButtonWidget(
              onClick: () {},
              height: height(context) * 0.08,
              minWidth: width(context) * 0.5,
              buttonName: 'Book Now',
              elevation: 10,
              rightRadius: 20.0,
              allRadius: false,
              bgColor: Colors.grey[900],
              textSize: width(context) * 0.05,
              textColor: Colors.white,
              borderSideColor: Colors.grey[900],
            ),
          ),
        ],
      ),
      appBar: appbar(context),
      body: Consumer<UserDetailsProvider>(builder: (context, data, child) {
        var uD = data.getUser;
        // log(uD['wishList'].length.toString());
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
                              updateWishList(
                                context,
                                widget.product['_id'],
                              );
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
                                context,
                                widget.product['_id'],
                              );
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
              alignment: Alignment.centerRight,
              padding: EdgeInsets.only(right: width(context) * 0.08),
              height: height(context) * 0.07,
              width: width(context),
              child: TextWidget(
                text: "₹ " + widget.product['basicDetails']['price'].toString(),
                color: Colors.grey[900],
                size: width(context) * 0.07,
                weight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: height(context) * 0.02,
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
                height: height(context) * 1.5,
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

animatedbutton(
    BuildContext context, id, IconData icon, MaterialColor color, String type) {
  return CircleAvatar(
    backgroundColor: Colors.grey[200],
    radius: width(context) * 0.05,
    child: LikeButton(
      // onTap: onLikeButtonTapped,
      // // onTap: type == 'wish'
      // //     ? updateWishList(context, id)
      // //     : updateCart(context, id),
      likeCountPadding: EdgeInsets.all(width(context) * 0.00),
      size: width(context) * 0.05,
      circleColor: CircleColor(start: Colors.red, end: Colors.red),
      bubblesColor: BubblesColor(
        dotPrimaryColor: Colors.green,
        dotSecondaryColor: Colors.red,
      ),
      likeBuilder: (bool isLiked) {
        return Icon(
          isLiked ? Icons.done : icon,
          color: isLiked ? Colors.green : color,
          size: width(context) * 0.05,
        );
      },
    ),
  );
}

Future<bool> onLikeButtonTapped(
  bool isLiked,
) async {
  // type == 'wish' ? updateWishList(context, id) : updateCart(context, id);

  return !isLiked;
}

specItems(BuildContext context, String image, String text, String? spec) {
  return Container(
    height: height(context) * 0.11,
    width: width(context) * 0.22,
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey[200]!,
            blurRadius: 1.0,
            spreadRadius: 1.0,
            offset: Offset(
              0.0,
              -2.0,
            ),
          ),
          BoxShadow(
            color: Colors.grey[100]!,
            blurRadius: 10.0,
            spreadRadius: 3.0,
            offset: Offset(
              3.0,
              3.0,
            ),
          )
        ]),
    child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      SizedBox(
          height: height(context) * 0.03,
          width: width(context) * 0.15,
          child: Image.asset('assets/pngs/$image.png')),
      Column(
        children: [
          TextWidget(
            text: text,
            color: Colors.grey[900],
            size: width(context) * 0.035,
            weight: FontWeight.w600,
          ),
          TextWidget(
            text: spec,
            color: Colors.grey[900],
            size: width(context) * 0.04,
            weight: FontWeight.w500,
          )
        ],
      )
    ]),
  );
}

appbar(
  BuildContext context,
) {
  return AppBar(
    backgroundColor: Colors.white,
    elevation: 0,
    centerTitle: true,
    automaticallyImplyLeading: false,
    leading: IconButton(
      padding: EdgeInsets.all(width(context) * 0.045),
      icon: Image.asset(
        'assets/pngs/drawer_icon.png',
      ),
      onPressed: () {
        // log(drawerController!.dummy.toString());
        // drawerControl?.scaffoldkey?.currentState?.openDrawer();
      },
    ),
    title: Image.asset(
      'assets/pngs/vihaan_app_logo.png',
      height: height(context) * 0.1,
      width: width(context) * 0.4,
    ),
  );
}

updateWishList(
  BuildContext context,
  id,
) async {
  // var length = uD.length + 1;
  Map<String, String> body = {
    "objectId": id.toString(),
  };
  log(body.toString());
  dynamic resp =
      await Server().editMethod(API.wishListAdd + API.uid.toString(), body);
  // var query = {"remove": 'true'};
  // dynamic resp = await Server()
  //     .putMethodParems(API.wishListRemove + API.uid.toString(), query, body);
  log(resp.body.toString());
  if (resp.statusCode == 200) {
    log('200');
  } else if (resp.statusCode == 204) {
    log('204');
  } else if (resp.statusCode == 404) {
    log('404');
  } else {
    snackbar(context, "Something went wrong status code ${resp.statusCode}");
  }
}

updateCart(
  BuildContext context,
  id,
) async {
  Map<String, String> body = {
    "objectId": id.toString(),
  };
  log(body.toString());
  dynamic resp = await Server().editMethod(API.cart + API.uid.toString(), body);
  log(resp.body.toString());
  if (resp.statusCode == 200) {
    log('200');
  } else if (resp.statusCode == 404) {
    log('404');
  } else {
    snackbar(context, "Something went wrong status code ${resp.statusCode}");
  }
}
