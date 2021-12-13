import 'dart:developer';

import 'package:flutter/material.dart';
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

  void addNewItemToCartorWishList(String id, String field) {
    if (user[field].contains(id)) {
      removeItemsFromCartorWishList(id, field);
    } else {
      user[field].add(id);
      notifyListeners();
    }
  }

  void removeItemsFromCartorWishList(String id, String field) {
    user[field].remove(id);
    notifyListeners();
  }

  checkProductInCartorWishList(String id, String field) {
    return user[field].contains(id);
  }
}
