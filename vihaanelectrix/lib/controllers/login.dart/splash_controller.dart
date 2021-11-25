import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:vihaanelectrix/repo/api_calling.dart';
import 'package:vihaanelectrix/repo/api_urls.dart';
import 'package:vihaanelectrix/utilities/shared_preference.dart';

class SplashController extends ControllerMVC {
  var scaffoldkey = GlobalKey<ScaffoldState>();
  dynamic appConstants;
 
 

  getSettings() async {

    if(await getAppConstants() != "null"){
      log("constants already in sf");
      return;
    }
    dynamic response = await Server().getMethod(API.appSettings);
    if (response.statusCode == 200) {
      appConstants = jsonDecode(response?.body);
      log(appConstants.toString());
      setAppConstants(appConstants);

    }
    else {log("something went wrong");}

  }
}


