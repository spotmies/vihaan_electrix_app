import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

/* ---------------------------- GET APP CONSTANTS --------------------------- */
getAppConstants() async {
  dynamic constants = await getDataFromSF("constants");
  return constants;
}
getMyuserDetails() async {
  dynamic userDetails = await getDataFromSF("userDetails");
  return userDetails;
}

getProducts() async {
  dynamic products = await getDataFromSF("products");
  return products;
}

getChargingStation() async {
  dynamic chargingStation = await getDataFromSF("chargingStation");
  return chargingStation;
}

getServiceStation() async {
  dynamic serviceStation = await getDataFromSF("serviceStation");
  return serviceStation;
}

/* ---------------------------- SET APP CONSTANTS --------------------------- */
setAppConstants(dynamic data) {
  setDataToSF(id: "constants", value: data);
}

saveUserDetails(dynamic data) {
  setDataToSF(id: "userDetails", value: data);
}

saveProducts(dynamic data) {
  setDataToSF(id: "products", value: data);
}

saveChargingStation(dynamic data) {
  setDataToSF(id: "chargingStation", value: data);
}

saveServiceStation(dynamic data) {
  setDataToSF(id: "serviceStation", value: data);
}

/* --------------------------------- GET DATA FROM SF --------------------------------- */
setDataToSF({required String id, required dynamic value}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(id, jsonEncode(value));
}

getDataFromSF(String id) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //Return String
  if (!prefs.containsKey(id)) return "null";
  String stringValue = prefs.getString(id).toString();
  dynamic returnedValue = jsonDecode(stringValue);
  return returnedValue;
}


