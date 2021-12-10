import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:vihaanelectrix/providers/user_details_provider.dart';
import 'package:provider/provider.dart';
import 'package:vihaanelectrix/widgets/product_card.dart';

class WishList extends StatefulWidget {
  const WishList({Key? key}) : super(key: key);

  @override
  _WishListState createState() => _WishListState();
}

UserDetailsProvider? profileProvider;

class _WishListState extends State<WishList> {
  @override
  void initState() {
    super.initState();

    profileProvider = Provider.of<UserDetailsProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      body: Consumer<UserDetailsProvider>(builder: (context, data, child) {
        var u = data.getUser;
        var w = u['wishList'];
        log(w.toString());
        return ListView.builder(
            itemCount: w.length,
            itemBuilder: (context, index) {
              // log(u[index]['productId'].toString());
              return productListCard(context, w[index]);
            });
      }),
    );
  }
}
