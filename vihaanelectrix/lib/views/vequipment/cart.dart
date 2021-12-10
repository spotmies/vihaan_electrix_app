import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:vihaanelectrix/providers/user_details_provider.dart';
import 'package:provider/provider.dart';
import 'package:vihaanelectrix/widgets/product_card.dart';

class CartList extends StatefulWidget {
  const CartList({Key? key}) : super(key: key);

  @override
  _CartListState createState() => _CartListState();
}

UserDetailsProvider? profileProvider;

class _CartListState extends State<CartList> {
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
        var c = u['cart'];
        log(c.toString());
        return ListView.builder(
            itemCount: c.length,
            itemBuilder: (context, index) {
              return productListCard(context, c[index]);
            });
      }),
    );
  }
}
