import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:vihaanelectrix/providers/product_details_provider.dart';
import 'package:vihaanelectrix/repo/api_methods.dart';
import 'package:vihaanelectrix/repo/api_urls.dart';
import 'package:vihaanelectrix/utilities/shared_preference.dart';

class UserDetailsProvider extends ChangeNotifier {
  dynamic user;
  bool loader = true;
  bool uploadLocader = true;

  bool get getLoader => loader;
  void setLoader(state) {
    loader = state;
    notifyListeners();
  }

  void setUser(uDetails) {
    user = uDetails;
    loader = false;
    notifyListeners();
    saveUserDetails(uDetails);
  }

  dynamic get getUser => user;

  Future<void> addNewItemToCartorWishList(String id, String field) async {
    if (user[field].contains(id)) {
      removeItemsFromCartorWishList(id, field);
    } else {
      user[field].add(id);
      notifyListeners();
      Map<String, String> body = {
        "objectId": id.toString(),
      };
      final String api = field == "wishList" ? API.wishListAdd : API.cart;
      dynamic resp = await Server().editMethod(api + API.uid.toString(), body);

      if (resp.statusCode != 200 && resp.statusCode != 204) {
        log("40 something went woring status ${resp.statusCode}");
        removeItemsFromCartorWishList(id, field);
      }
    }
  }

  Future<void> removeItemsFromCartorWishList(String id, String field) async {
    user[field].remove(id);
    notifyListeners();
    Map<String, String> query = {"remove": 'true'};
    Map<String, String> body = {
      "objectId": id.toString(),
    };
    final String api = field == "wishList" ? API.wishListAdd : API.cart;
    dynamic resp =
        await Server().putMethodParems(api + API.uid.toString(), query, body);
    if (resp.statusCode != 200 && resp.statusCode != 204) {
      log("56 something went woring status ${resp.statusCode}");
    }
  }

  checkProductInCartorWishList(String id, String field) {
    return user[field].contains(id);
  }

  String getCartPrice(ProductDetailsProvider? productDetails) {
    int cartPrice = 0;
    for (int i = 0; i < user['cart'].length; i++) {
      dynamic product = productDetails?.getDetailsbyId(user['cart'][i]);

      int productMoney = product['basicDetails']['price'];
      cartPrice = cartPrice + productMoney;
    }
    return cartPrice.toString();
  }
}
