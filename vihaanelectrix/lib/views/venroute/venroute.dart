import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:vihaanelectrix/controllers/venroute/testride.dart';
import 'package:vihaanelectrix/providers/product_details_provider.dart';
import 'package:vihaanelectrix/providers/user_details_provider.dart';
import 'package:vihaanelectrix/views/venroute/product_overview.dart';
import 'package:provider/provider.dart';
import 'package:vihaanelectrix/widgets/app_config.dart';
import 'package:vihaanelectrix/widgets/text_wid.dart';

class VEnroute extends StatefulWidget {
  const VEnroute({Key? key}) : super(key: key);

  @override
  _VEnrouteState createState() => _VEnrouteState();
}

TestRideController testRideController = TestRideController();
ProductDetailsProvider? productDetailsProvider;
UserDetailsProvider? profileProvider;

class _VEnrouteState extends State<VEnroute> {
  @override
  void initState() {
    super.initState();
    productDetailsProvider =
        Provider.of<ProductDetailsProvider>(context, listen: false);
    profileProvider = Provider.of<UserDetailsProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: Text('Enroute'),
        // ),
        backgroundColor: Colors.blue[50],
        body: Consumer<UserDetailsProvider>(builder: (context, data, child) {
          var uD = data.getUser;
          log(uD.toString());
          return Consumer<ProductDetailsProvider>(
              builder: (context, data, child) {
            var p = data.getProduct;
            log(p[0]['_id'].toString());

            // return Text(u[0]['basicDetails'].toString());
            return ListView.builder(
                itemCount: p.length,
                itemBuilder: (context, index) {
                  // log(u[index]['productId'].toString());
                  return productListCard(context, p[index]);
                 
                });
          });
        }));
  }
}

productListCard(BuildContext context, product) {
  return InkWell(
    onTap: () {
      // log(product.toString());
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ProductOverview(
                    product: product,
                  )));
    },
    child: Stack(
      children: [
        Container(
            height: height(context) * 0.35,
            width: width(context) * 1,
            color: Colors.blue[50],
            alignment: Alignment.center,
            child: Container(
                height: height(context) * 0.25,
                width: width(context) * 0.85,
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey[50]!,
                          blurRadius: 1.0,
                          spreadRadius: 1.0)
                    ],
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                child: Row(
                  children: [
                    SizedBox(
                      width: width(context) * 0.25,
                      // color: Colors.pink[50],
                    ),
                    SizedBox(
                        width: width(context) * 0.60,
                        height: height(context) * 0.35,
                        // color: Colors.white,
                        // alignment: Alignment.center,
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              // color: Colors.red,
                              width: width(context) * 0.60,
                              height: height(context) * 0.15,
                            ),
                            Container(
                              // color: Colors.pink,
                              width: width(context) * 0.60,
                              height: height(context) * 0.1,
                              padding: EdgeInsets.only(
                                left: width(context) * 0.05,
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  TextWidget(
                                    text: 'Top Speed - 120km/h',
                                    weight: FontWeight.w600,
                                  ),
                                  TextWidget(
                                    text: 'Loading Capacity - 200kg',
                                    weight: FontWeight.w600,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )),
                  ],
                ))),
        Positioned(
            right: 1,
            child: Image.asset(
              'assets/pngs/bike.png',
              height: height(context) * 0.26,
              width: width(context) * 0.5,
            )
            // child: Image.network(
            //   product['basicDetails']['media'][0]['mediaUrl'],
            //   height: height(context) * 0.26,
            //   width: width(context) * 0.5,
            // )
            ),
      ],
    ),
  );
}
