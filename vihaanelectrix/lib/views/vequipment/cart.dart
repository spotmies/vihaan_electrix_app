import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:vihaanelectrix/providers/product_details_provider.dart';
import 'package:vihaanelectrix/providers/user_details_provider.dart';
import 'package:provider/provider.dart';

import 'package:vihaanelectrix/widgets/app_config.dart';
import 'package:vihaanelectrix/widgets/elevated_widget.dart';
import 'package:vihaanelectrix/widgets/product_card.dart';
import 'package:vihaanelectrix/widgets/text_wid.dart';

class CartList extends StatefulWidget {
  const CartList({Key? key}) : super(key: key);

  @override
  _CartListState createState() => _CartListState();
}

UserDetailsProvider? profileProvider;
ProductDetailsProvider? productDetails;

class _CartListState extends State<CartList> {
  @override
  void initState() {
    super.initState();

    profileProvider = Provider.of<UserDetailsProvider>(context, listen: false);
    productDetails =
        Provider.of<ProductDetailsProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        backgroundColor: Colors.blue[50],
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.grey[900],
            )),
        title: TextWidget(
          text: 'My Cart',
          size: width(context) * 0.06,
          color: Colors.grey[900],
          weight: FontWeight.w600,
        ),
      ),
      bottomSheet:
          Consumer<UserDetailsProvider>(builder: (context, data, child) {
        return Container(
          height: height(context) * 0.1,
          width: width(context),
          padding: EdgeInsets.only(
              left: width(context) * 0.04, right: width(context) * 0.04),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15), topRight: Radius.circular(15))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                    text: data.getCartPrice(productDetails),
                    size: width(context) * 0.065,
                    weight: FontWeight.w600,
                    flow: TextOverflow.visible,
                  ),
                  TextWidget(
                    text: 'Total cart value',
                    size: width(context) * 0.03,
                    weight: FontWeight.w600,
                    color: Colors.grey[900],
                    flow: TextOverflow.visible,
                  ),
                ],
              ),
              ElevatedButtonWidget(
                onClick: () {},
                height: height(context) * 0.06,
                minWidth: width(context) * 0.35,
                buttonName: 'Book Now',
                elevation: 10,
                rightRadius: 20.0,
                allRadius: true,
                bgColor: Colors.grey[900],
                textSize: width(context) * 0.05,
                textColor: Colors.white,
                borderSideColor: Colors.grey[900],
              )
            ],
          ),
        );
      }),
      body: Consumer<UserDetailsProvider>(builder: (context, data, child) {
        dynamic c = data.getUser['cart'];

        return ListView.builder(
            itemCount: c.length,
            itemBuilder: (context, index) {
              return Consumer<ProductDetailsProvider>(
                  builder: (context, data, child) {
                dynamic product = data.getDetailsbyId(c[index].toString());

                if (product != null) {
                  return productListCard(context, product,
                      provider: productDetails);
                } else {
                  return Container();
                }
              });
            });
      }),
    );
  }
}
