import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vihaanelectrix/controllers/login.dart/login_control.dart';
import 'package:vihaanelectrix/providers/common_provider.dart';
import 'package:provider/provider.dart';
import 'package:vihaanelectrix/views/login/login_utils.dart';
import 'package:vihaanelectrix/views/login/otp_screen.dart';
import 'package:vihaanelectrix/widgets/app_config.dart';
import 'package:vihaanelectrix/widgets/elevated_widget.dart';

import 'package:vihaanelectrix/widgets/text_wid.dart';
import 'package:country_code_picker/country_code_picker.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginPageController loginPageController = LoginPageController();
  CommonProvider? co;

  @override
  initState() {
    co = Provider.of<CommonProvider>(context, listen: false);
    co!.setCurrentConstants("login");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: loginPageController.scaffoldkey,
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            loginHeader(context),
            Stack(
              children: [
                loginBackgroundTemp(context),
                Positioned(
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/pngs/login_image.png',
                        height: height(context) * 0.35,
                        width: width(context),
                      ),
                      SizedBox(
                        height: height(context) * 0.06,
                      ),
                      Form(
                        key: loginPageController.formkey,
                        child: Container(
                          // padding: EdgeInsets.all(4),
                          constraints: BoxConstraints(
                              minHeight: height(context) * 0.08,
                              maxHeight: height(context) * 0.10,
                              maxWidth: width(context) * 0.9,
                              minWidth: width(context) * 0.8),
                          // margin: EdgeInsets.only(top: 0, right: 5, left: 5),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey[200]!,
                                    blurRadius: 5.0,
                                    spreadRadius: 2.0)
                              ]),
                          child: Row(
                            children: [
                              SizedBox(
                                width: width(context) * 0.17,
                                child: CountryCodePicker(
                                  dialogSize:
                                      Size.fromWidth(width(context) * 0.8),
                                  showFlagDialog: true,
                                  showFlag: false,
                                  initialSelection: "IN",
                                  favorite: const ["IN"],
                                  onChanged: (item) {
                                    log(item.name.toString());
                                  },
                                ),
                              ),
                              Container(
                                width: width(context) * 0.7,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: TextFormField(
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'[0-9]')),
                                  ],
                                  // onSaved: (item) => _loginPageController.loginModel.loginnum,
                                  style: fonts(width(context) * 0.045,
                                      FontWeight.w600, Colors.grey[900]),
                                  textAlign: TextAlign.justify,
                                  decoration: InputDecoration(
                                    // contentPadding: EdgeInsets.only(top: 30.0),

                                    border: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white),
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    suffixIcon: Icon(
                                      Icons.phone_android,
                                      color: Colors.indigo[900],
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)),
                                        borderSide: BorderSide(
                                            width: 1, color: Colors.white)),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)),
                                        borderSide: BorderSide(
                                            width: 1, color: Colors.white)),
                                    hintStyle: fonts(width(context) * 0.045,
                                        FontWeight.w600, Colors.grey[400]),
                                    hintText: 'Phone number',
                                  ),
                                  validator: (value) {
                                    if (value!.length != 10) {
                                      return 'Please Enter Valid Mobile Number';
                                    }
                                    return null;
                                  },
                                  maxLength: 10,
                                  keyboardAppearance: Brightness.dark,
                                  buildCounter: (BuildContext context,
                                          {int? currentLength,
                                          int? maxLength,
                                          bool? isFocused}) =>
                                      null,
                                  keyboardType: TextInputType.number,
                                  controller: loginPageController.controller,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height(context) * 0.06,
                      ),
                      TextWidget(
                          text: 'VE CARE FOR EV',
                          size: width(context) * 0.07,
                          color: Colors.grey[900],
                          weight: FontWeight.bold),
                      SizedBox(
                        height: height(context) * 0.09,
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.only(right: width(context) * 0.05),
                        child: ElevatedButtonWidget(
                          onClick: () {
                            if (loginPageController.formkey.currentState!
                                .validate()) {
                              loginPageController.formkey.currentState!.save();
                              log(loginPageController.controller.text);
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => OTPScreen(
                                      loginPageController.controller.text)));
                            }
                          },
                          height: height(context) * 0.057,
                          minWidth: width(context) * 0.3,
                          buttonName: co?.getText("button_label"),
                          trailingIcon: Icon(
                            Icons.arrow_forward,
                            size: width(context) * 0.05,
                          ),
                          allRadius: true,
                          bgColor: Colors.indigo[900],
                          textSize: width(context) * 0.05,
                          borderRadius: 20.0,
                          textColor: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            )
          ],
        ));
  }
}
