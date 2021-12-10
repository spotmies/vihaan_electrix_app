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
import 'package:vihaanelectrix/widgets/product_card.dart';
import 'package:vihaanelectrix/widgets/text_wid.dart';

class VEnroute extends StatefulWidget {
  const VEnroute({Key? key}) : super(key: key);

  @override
  _VEnrouteState createState() => _VEnrouteState();
}

// TestRideController testRideController = TestRideController();
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

