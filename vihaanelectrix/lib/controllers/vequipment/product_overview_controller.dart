import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:vihaanelectrix/providers/user_details_provider.dart';
import 'package:vihaanelectrix/repo/api_methods.dart';
import 'package:vihaanelectrix/repo/api_urls.dart';
import 'package:vihaanelectrix/widgets/snackbar.dart';

class ProductOverviewController extends ControllerMVC {

  var spec = {
    'speed': '200km/hr',
    'riding_range': '200km',
    'Battery_capacity': '200mAh',
    'charging_time_icon': '200min',
  };

  updateWishList(
    BuildContext context,
    id,
    UserDetailsProvider? profileProvider,
  ) async {
    profileProvider?.addNewItemToCartorWishList(id.toString(), "wishList");
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
    if (resp.statusCode == 200 || resp.statusCode == 204) {
      log('200');
    } else {
      profileProvider?.removeItemsFromCartorWishList(id.toString(), "wishList");
      snackbar(context, "Something went wrong status code ${resp.statusCode}");
    }
  }

  updateCart(
    BuildContext context,
    id,
    UserDetailsProvider? profileProvider,
  ) async {
    profileProvider?.addNewItemToCartorWishList(id.toString(), "cart");
    Map<String, String> body = {
      "objectId": id.toString(),
    };
    log(body.toString());
    dynamic resp =
        await Server().editMethod(API.cart + API.uid.toString(), body);
    log(resp.body.toString());
    if (resp.statusCode == 200 || resp.statusCode == 204) {
      log('200');
    } else {
      profileProvider?.removeItemsFromCartorWishList(id.toString(), "cart");
      snackbar(context, "Something went wrong status code ${resp.statusCode}");
    }
  }

// removeCart(
//   BuildContext context,
//   id,
//   UserDetailsProvider? profileProvider,
// ) async {
//   profileProvider?.removeItemsFromCartorWishList(id.toString(), "cart");
//   Map<String, String> body = {
//     "objectId": id.toString(),
//   };
//   log(body.toString());
//   var query = {"remove": 'true'};
//   dynamic resp = await Server()
//       .putMethodParems(API.cartRemove + API.uid.toString(), query, body);
//   log(resp.body.toString());
//   if (resp.statusCode == 200 || resp.statusCode == 204) {
//     log('Removed from cart');
//   } else {
//     profileProvider?.addNewItemToCartorWishList(id.toString(), "cart");
//     snackbar(context, "Something went wrong status code ${resp.statusCode}");
//   }
// }

// removeWishList(
//   BuildContext context,
//   id,
//   UserDetailsProvider? profileProvider,
// ) async {
//   profileProvider?.removeItemsFromCartorWishList(id.toString(), "wishList");
//   Map<String, String> body = {
//     "objectId": id.toString(),
//   };
//   log(body.toString());
//   var query = {"remove": 'true'};
//   dynamic resp = await Server()
//       .putMethodParems(API.wishListRemove + API.uid.toString(), query, body);
//   log(resp.body.toString());
//   if (resp.statusCode == 200 || resp.statusCode == 204) {
//     log('Removed from wishList');
//   } else {
//     profileProvider?.addNewItemToCartorWishList(id.toString(), "wishList");
//     snackbar(context, "Something went wrong status code ${resp.statusCode}");
//   }
// }


}