import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:vihaanelectrix/providers/user_details_provider.dart';
import 'package:vihaanelectrix/repo/api_calls.dart';
import 'package:vihaanelectrix/utilities/shared_preference.dart';

class ProductDetailsProvider extends ChangeNotifier {
  UserDetailsProvider? userDetailsProvider;
  dynamic product;
  bool loader = true;
  bool uploadLocader = true;


  bool get getLoader => loader;
  void setLoader(state) {
    loader = state;
    notifyListeners();
  }

  void setProduct(products) {
    product = products;
    loader = false;
    notifyListeners();
    saveProducts(products);
  }

  Future<void> fetchProductFromDB() async {
    dynamic products = await getProductDetailsFromDB();
    if (products == null) return;
    setProduct(products);
  }

  getDetailsbyId(String id) {
    int index = product.indexWhere((single) => single['_id'].toString() == id);
    if (index < 0) {
      return null;
    }
    return product[index];
  }



  similarProductColorsByModelId(String modelId) {
    List<dynamic> similarProductColors = [];
    for (int i = 0; i < product.length; i++) {
      if (product[i]['modelId'] == modelId) {
        similarProductColors.add(product[i]['basicDetails']['media'][0]);
      }
    }
    // log(similarProductColors.toString());
    if (similarProductColors.length > 4) {
      return similarProductColors.sublist(0, 4);
    }
    return similarProductColors;
    // return "col";
  }

  getSameColorProduct(String modelId) {
    List<dynamic> similarProductColors = [];
    for (int i = 0; i < product.length; i++) {
      if (product[i]['modelId'] == modelId) {
        similarProductColors.add(product[i]);
      }
    }
    return similarProductColors;
 
  }

  dynamic get getProduct => product;
}
