import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:vihaanelectrix/utilities/shared_preference.dart';
import 'package:geolocator/geolocator.dart';

class LocationProvider extends ChangeNotifier {
  Position? position;
  bool loader = true;

  bool get getLoader => loader;
  void setLoader(state) {
    loader = state;
    notifyListeners();
  }

  void setLocation(geoLoc) {
    position = geoLoc;
    
    loader = false;
    notifyListeners();
    saveLocation(geoLoc);
  }

  dynamic get getLocation => position;
  
}
