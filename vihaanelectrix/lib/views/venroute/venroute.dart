import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vihaanelectrix/providers/product_details_provider.dart';
import 'package:vihaanelectrix/providers/user_details_provider.dart';
import 'package:provider/provider.dart';
import 'package:vihaanelectrix/views/home/profile_drawer.dart';
import 'package:vihaanelectrix/widgets/app_bar.dart';
import 'package:vihaanelectrix/widgets/product_card.dart';

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
        appBar: appbar(context),
        drawer: NavigationDrawerWidget(),
        backgroundColor: Colors.blue[50],
        body: Consumer<UserDetailsProvider>(builder: (context, data, child) {
          dynamic uD = data.getUser;
          log(uD.toString());
          return Consumer<ProductDetailsProvider>(
              builder: (context, data, child) {
            dynamic p = data.getProduct;
            // log(p[0].toString());
            if (p == null) {
              return Container();
            }

            // return Text(u[0]['basicDetails'].toString());
            return RefreshIndicator(
              onRefresh: data.fetchProductFromDB,
              child: ListView.builder(
                  itemCount: p.length,
                  itemBuilder: (context, index) {
                    log(p[index]['basicDetails'].toString());
                    return productListCard(context, p[index],
                        provider: productDetailsProvider);
                  }),
            );
          });
        }));
  }
}
