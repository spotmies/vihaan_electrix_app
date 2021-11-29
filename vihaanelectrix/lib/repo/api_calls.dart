import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:vihaanelectrix/repo/api_methods.dart';
import 'package:vihaanelectrix/repo/api_urls.dart';
import 'package:firebase_auth/firebase_auth.dart';
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


 signout(BuildContext context) async {
  await FirebaseAuth.instance.signOut().then((action) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginScreen()));
  }).catchError((e) {
    log(e);
  });
}
