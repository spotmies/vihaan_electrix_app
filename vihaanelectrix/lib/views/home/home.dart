import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:vihaanelectrix/providers/product_details_provider.dart';
import 'package:vihaanelectrix/providers/user_details_provider.dart';
import 'package:vihaanelectrix/views/home/profile_drawer.dart';
import 'package:vihaanelectrix/widgets/app_bar.dart';
import 'package:provider/provider.dart';
import 'package:vihaanelectrix/widgets/product_card.dart';
import 'package:vihaanelectrix/widgets/progress.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

ProductDetailsProvider? productDetailsProvider;
UserDetailsProvider? profileProvider;

class _HomeState extends State<Home> {
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
        // backgroundColor: Colors.grey[50],
        drawer: NavigationDrawerWidget(),
        appBar: appbar(context),
        backgroundColor: Colors.blue[50],
        body: Consumer<UserDetailsProvider>(builder: (context, data, child) {
          var uD = data.getUser;
          if (uD == null) {
            return circleProgress(context);
          }
          log(uD.toString());
          return Consumer<ProductDetailsProvider>(
              builder: (context, data, child) {
            var p = data.getProduct?.reversed?.toList();
            if (p == null) {
              // return circleProgress(context);
              return Container();
            }
            // log(p[0]['_id'].toString());

            // return Text(u[0]['basicDetails'].toString());
            return RefreshIndicator(
              onRefresh: data.fetchProductFromDB,
              child: ListView.builder(

                  // reverse: true,
                  itemCount: p.length,
                  itemBuilder: (context, index) {
                    // log(u[index]['productId'].toString());
                    return productListCard(context, p[index],
                        provider: productDetailsProvider);
                  }),
            );
          });
        }));
  }
}
