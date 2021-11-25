
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

/* ---------------------------- GET APP CONSTANTS --------------------------- */
getAppConstants() async {
  dynamic constants = await getDataFromSF("constants");
  return constants;
}


/* ---------------------------- SET APP CONSTANTS --------------------------- */
setAppConstants(dynamic data){
  setDataToSF(id: "constants", value: data);
}


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