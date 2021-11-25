import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:vihaanelectrix/repo/api_calling.dart';
import 'package:vihaanelectrix/repo/api_urls.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashController extends ControllerMVC {
  var scaffoldkey = GlobalKey<ScaffoldState>();
  dynamic settings;
 
 

  getSettings() async {
    dynamic response = await Server().getMethod(API.allSettings);
    if (response.statusCode == 200) {
      settings = jsonDecode(response.body);
      log(settings.toString());
      // localStore(settings);
      return settings;
    }
    return null;
  }
}

localStore(settings) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  prefs.setString('settings', jsonEncode(settings)).catchError((e) {
    log(e.toString());
  });
}
