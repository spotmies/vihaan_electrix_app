import 'package:flutter/material.dart';

class UniversalProvider extends ChangeNotifier {
  int currentNavigationPage = 0; //0 - home 1- chat 2-my booking 3 - account
  bool chatBadge = false;
  List geoLocations = [];
  List searchLocations = [];
  bool locationsLoader = false;
  bool enableRoute = false;
  List productsList = [];
  List searchProducts = [];

  void setEnableRoute(bool state) {
    enableRoute = state;
    notifyListeners();
  }

  void setLocationsLoader(bool state) {
    locationsLoader = state;
    notifyListeners();
  }

  int get getCurrentPage {
    return currentNavigationPage;
  }

  void setCurrentPage(int page) {
    currentNavigationPage = page;
    if (page == 1) chatBadge = false;
    notifyListeners();
  }

  void setGeoLocations(locations) {
    geoLocations = locations;
    searchLocations = locations;
    notifyListeners();
  }

  void setSearchLocations(locations) {
    searchLocations = locations;
    notifyListeners();
  }

  void showAllLocation() {
    searchLocations = geoLocations;
    notifyListeners();
  }

  bool get getChatBadge => chatBadge;

  void setChatBadge() {
    if (currentNavigationPage != 1) chatBadge = true;
    notifyListeners();
  }

  // void setProducts(List products) {
  //   productsList = products;
  //   searchProducts = products;
  //   notifyListeners();
  // }
}
