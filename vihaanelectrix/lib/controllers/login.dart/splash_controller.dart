import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:vihaanelectrix/providers/common_provider.dart';
import 'package:vihaanelectrix/repo/api_calls.dart';
import 'package:provider/provider.dart';
import 'package:vihaanelectrix/utilities/shared_preference.dart';
import 'package:vihaanelectrix/widgets/snackbar.dart';

class SplashController extends ControllerMVC {
  // BuildContext? context;
  CommonProvider? co;
  GlobalKey<ScaffoldState> scaffoldkey = GlobalKey<ScaffoldState>();

  // @override
  // void initState() {
  //   log("======== splash controller init ==========");
  //   co = Provider.of<CommonProvider>(context!, listen: false);

  //   super.initState();
  // }

  @override
  void didChangeDependencies() {}
  static SplashController get con => SplashController();

  getSettings(context, {bool alwaysHit = false, dynamic co}) async {
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
}
