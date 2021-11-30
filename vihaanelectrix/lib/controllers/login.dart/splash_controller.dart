import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:vihaanelectrix/repo/api_calls.dart';

import 'package:vihaanelectrix/utilities/shared_preference.dart';

class SplashController extends ControllerMVC {
  var scaffoldkey = GlobalKey<ScaffoldState>();

  getSettings({bool alwaysHit = false}) async {
    if (await getAppConstants() != null && alwaysHit == false) {
      log("constants already in sf");
      return;
    }

    await constantsAPI();
    return;
  }
}
