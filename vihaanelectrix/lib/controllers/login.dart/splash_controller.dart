import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:vihaanelectrix/providers/common_provider.dart';
import 'package:vihaanelectrix/repo/api_calls.dart';
import 'package:vihaanelectrix/repo/api_methods.dart';
import 'package:vihaanelectrix/repo/api_urls.dart';
import 'package:vihaanelectrix/utilities/shared_preference.dart';
import 'package:vihaanelectrix/views/home/navbar.dart';
import 'package:vihaanelectrix/views/login/onboarding_screen.dart';
import 'package:vihaanelectrix/widgets/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class SplashController extends ControllerMVC {
  CommonProvider? co;
  GlobalKey<ScaffoldState> scaffoldkey = GlobalKey<ScaffoldState>();

  static SplashController get con => SplashController();

  getSettings(context, {bool alwaysHit = false}) async {
    if (alwaysHit == false) {
      dynamic constantsFromSf = await getAppConstants();
      if (constantsFromSf != null) {
        co?.setAllConstants(constantsFromSf);

        log("constants already in sf 27 ");
        return;
      }
    }

    dynamic appConstants = await constantsAPI();
    if (appConstants != null) {
      co?.setAllConstants(appConstants);
      snackbar(context, "New setting imported");
    }
    return;
  }

  checkUser(BuildContext context) async {
    if (FirebaseAuth.instance.currentUser != null) {
      log("user exist>>>>>>>>>");
      String resp =
          await checkUserRegistered(FirebaseAuth.instance.currentUser!.uid);

      if (resp == "true") {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => NavigationBar()),
            (route) => false);
      } else if (resp == "false") {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => OnBoardingScreen()),
            (route) => false);
      } else {
        snackbar(context, "Something went wrong");
      }
    } else {
      log("user not exixst>>>>>>>");
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => OnBoardingScreen()),
          (route) => false);
    }
  }

  checkUserRegistered(uid) async {
    dynamic deviceToken = await FirebaseMessaging.instance.getToken();
    Map<String, String> obj = {
      "lastLogin": DateTime.now().millisecondsSinceEpoch.toString(),
      "userDeviceToken": deviceToken?.toString() ?? "",
    };

    dynamic response = await Server().editMethod(API.updateUser + uid, obj);
    log("36 ${response.statusCode}");
    if (response.statusCode == 200 || response.statusCode == 204) {
      return "true";
    } else if (response.statusCode == 404) {
      return "false";
    }
    return "server_error";
  }
}
