import 'dart:developer';

import 'package:flutter/material.dart';

class CommonProvider extends ChangeNotifier {
  Map<dynamic, dynamic> allConstants = {};
  String currentScreen = "home";
  dynamic currentConstants;

  int resendOtpCount = 99;


  void setAllConstants(dynamic constants) {
    log("all constantsn 11 $constants");
    allConstants = constants;
  }

  getAllConstants() {
    return allConstants;
  }

  void setCurrentConstants(String screenName) {
    currentScreen = screenName;
    log("all constants $allConstants");
    currentConstants = allConstants[currentScreen];
    log("current constatns");
    log(currentConstants.toString());
  }

  getText(String objId) {
    if (currentConstants == null) return "loading..";
    int index = currentConstants?.indexWhere(
        (element) => element['objId'].toString() == objId.toString());

    if (index == -1) return "null";
    return currentConstants[index]['label'];
  }

    updateTime() {
    if (resendOtpCount != 0) {
      resendOtpCount--;
    }
    notifyListeners();
  }

  void resetTimer() {
    resendOtpCount = 99;
    notifyListeners();
  }
}
