import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:vihaanelectrix/models/login/user_registration.dart';

class UserRegistrationController extends ControllerMVC {

   TextEditingController nameTf = TextEditingController();
  TextEditingController dobTf = TextEditingController();
  TextEditingController emailTf = TextEditingController();
  TextEditingController numberTf = TextEditingController();
  TextEditingController altnumberTf = TextEditingController();
  TextEditingController peradTf = TextEditingController();
  TextEditingController tempadTf = TextEditingController();
  TextEditingController experienceTf = TextEditingController();
  TextEditingController businessNameTf = TextEditingController();
  ScrollController scrollController = ScrollController();
  int currentStep = 0;
  String? name;
  String? email;
  String? number;
  String? altnumber;
  String? tca;
  File? profilepic;
  bool accept = false;
  String imageLink = "";

  UserRegistrationController?  userRegistrationModel;

  UserRegistrationController() {
    userRegistrationModel = UserRegistrationModel() as UserRegistrationController?;
  }
}