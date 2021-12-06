import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:vihaanelectrix/repo/api_methods.dart';
import 'package:vihaanelectrix/repo/api_urls.dart';
import 'package:vihaanelectrix/utilities/shared_preference.dart';
import 'package:vihaanelectrix/views/home/navbar.dart';
import 'package:vihaanelectrix/views/login/user_registration.dart';
import 'package:vihaanelectrix/widgets/snackbar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';


class LoginPageController extends ControllerMVC {

  TextEditingController controller = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  GlobalKey scaffoldkey = GlobalKey<ScaffoldState>();
    GlobalKey otpscaffoldkey = GlobalKey<ScaffoldState>();



   checkUser(context, {String? uId, String? phone}) async {
    snackbar(context, 'Login succussfully');
    log('Login succussfully');
    setDataToSF(id: "loginNumber", value: phone);
    dynamic deviceToken = await FirebaseMessaging.instance.getToken();
    Map<String, String> body = {
      "lastLogin": DateTime.now().millisecondsSinceEpoch.toString(),
      "deviceToken": deviceToken.toString()
    };
    dynamic resp =
        await Server().editMethod(API.userDetails + uId.toString(), body);
    if (resp.statusCode == 200) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => NavigationBar()),
          (route) => false);
    } else if (resp.statusCode == 404) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => UserRegistration(phone!)),
          (route) => false);
    } else {
      snackbar(context, "Something went wrong status code ${resp.statusCode}");
    }

    /* ------------------------ RETURN 200 IF USER EXIXST ----------------------- */
    /* --------------------- RETURN 404 FOR USER NOT EXISTS --------------------- */
    /* ------------------------- ALL OTHERS SERVER ERROR ------------------------ */
  }
}
