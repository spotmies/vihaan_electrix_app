import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:vihaanelectrix/controllers/venroute/testride.dart';
import 'package:vihaanelectrix/providers/product_details_provider.dart';
import 'package:vihaanelectrix/providers/user_details_provider.dart';
import 'package:vihaanelectrix/views/venroute/test_ride.dart';
import 'package:provider/provider.dart';
import 'package:vihaanelectrix/widgets/app_config.dart';
import 'package:vihaanelectrix/widgets/elevated_widget.dart';

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
        appBar: AppBar(
          title: Text('Enroute'),
        ),
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
                  return Card(
                      child: Column(
                    children: [
                      Text(p[index]['basicDetails']['modelName'].toString()),
                      Row(
                        children: [
                          ElevatedButtonWidget(
                            height: height(context) * 0.05,
                            minWidth: width(context) * 0.3,
                            elevation: 5,
                            buttonName: 'Test Ride',
                            onClick: () {
                              // log(u[index]['productId']);
                              // log(
                              //   uD['_id'],
                              // );
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => TestRideBooking(
                                            productId: p[0]['_id'],
                                            userDetails: uD['_id'],
                                          )));
                            },
                          )
                        ],
                      )
                    ],
                  ));
                });
          });
        }));
  }
}
