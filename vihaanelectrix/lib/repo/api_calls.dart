import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:vihaanelectrix/repo/api_methods.dart';
import 'package:vihaanelectrix/repo/api_urls.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vihaanelectrix/utilities/shared_preference.dart';
import 'package:vihaanelectrix/views/login/login_screen.dart';

getUserDetailsFromDB() async {
  String uId = FirebaseAuth.instance.currentUser!.uid;
  dynamic response = await Server().getMethod(API.userDetails + uId);
  if (response.statusCode == 200) {
    dynamic user = jsonDecode(response.body);
    return user;
  }
  return null;
}

constantsAPI() async {
  dynamic response = await Server().getMethod(API.appSettings);
  if (response.statusCode == 200) {
    dynamic appConstants = jsonDecode(response?.body);
    log(appConstants.toString());
    setAppConstants(appConstants);
    var currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      log("confirming all costanst downloaded");
      /* -------------- CONFIRM ALL CONSTANTS AND SETTINGS DOWNLOADED ------------- */
      Map<String, String> body = {"appConfig": "false"};
      Server().editMethod(API.userDetails + currentUser.uid.toString(), body);
    }
    return appConstants;
  } else {
    log("something went wrong");
    return null;
  }
}

signout(BuildContext context) async {
  await FirebaseAuth.instance.signOut().then((action) {
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (_) => LoginScreen()), (route) => false);
  }).catchError((e) {
    log(e);
  });
}
