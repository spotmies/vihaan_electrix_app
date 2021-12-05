import 'package:flutter/material.dart';
import 'package:vihaanelectrix/utilities/shared_preference.dart';

class ProductDetailsProvider extends ChangeNotifier {
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

  dynamic get getProduct => product;
}
