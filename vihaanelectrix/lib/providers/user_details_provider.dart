
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

}
