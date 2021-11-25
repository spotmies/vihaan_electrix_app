import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vihaanelectrix/utilities/shared_preference.dart';

import 'package:vihaanelectrix/views/login/otp_screen.dart';
import 'package:vihaanelectrix/widgets/app_config.dart';
import 'package:vihaanelectrix/widgets/elevated_widget.dart';
import 'package:vihaanelectrix/widgets/progress.dart';
import 'package:vihaanelectrix/widgets/text_wid.dart';
import 'package:country_code_picker/country_code_picker.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController controller = TextEditingController();
  var formkey = GlobalKey<FormState>();
  dynamic constants;
  bool showUi = false;
  getText(String objId) {
    log(constants.toString());
    if (constants == null) return "loading..";
    int index = constants?.indexWhere(
        (element) => element['objId'].toString() == objId.toString());
    log(index.toString());
    if (index == -1) return "null";
    return constants[index]['label'];
  }

  sekhar() async {
    dynamic allConstants = await getAppConstants();
    setState(() {
      showUi = true;
    });
    log(allConstants['login'].toString());
    constants = allConstants['login'];
    getText("login_heading");
    getText("login_heading_new");
  }

  @override
  initState() {
    // TODO: implement initState
    sekhar();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: showUi
          ? Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(children: [
                  // SizedBox(
                  //   height: height(context) * 0.3,
                  //   width: width(context) * 0.7,
                  //   child: Image.asset(
                  //     'assets/login_top.png',
                  //     height: MediaQuery.of(context).size.height * 0.35,
                  //     width: MediaQuery.of(context).size.width * 0.8,
                  //   ),
                  // ),
                  Container(
                    margin: EdgeInsets.only(top: 60),
                    child: Center(
                      child: Text(
                        getText("login_heading"),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 28),
                      ),
                    ),
                  ),
                  // Container(
                  //   margin: EdgeInsets.only(top: 40, right: 10, left: 10),
                  //   child: TextField(
                  //     decoration: InputDecoration(
                  //       hintText: 'Phone Number',
                  //       prefix: Padding(
                  //         padding: EdgeInsets.all(4),
                  //         child: Text('+1'),
                  //       ),
                  //     ),
                  //     maxLength: 10,
                  //     keyboardType: TextInputType.number,
                  //     controller: controller,
                  //   ),
                  // ),
                  Form(
                    key: formkey,
                    child: Container(
                      padding: EdgeInsets.all(4),
                      constraints: BoxConstraints(
                          minHeight: height(context) * 0.08,
                          maxHeight: height(context) * 0.10),
                      margin: EdgeInsets.only(top: 0, right: 5, left: 5),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            width: width(context) * 0.2,
                            child: CountryCodePicker(
                              // flagWidth: width(context) * 0.04,
                              dialogSize: Size.fromWidth(width(context) * 0.8),
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
                            margin: EdgeInsets.only(top: 0, right: 0, left: 0),
                            width: width(context) * 0.75,
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

                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                    borderRadius: BorderRadius.circular(15)),
                                // contentPadding: EdgeInsets.all(width(context) * 0.05),
                                contentPadding: EdgeInsets.only(
                                    left: width(context) * 0.05,
                                    right: width(context) * 0.05,
                                    top: width(context) * 0.01,
                                    bottom: width(context) * 0.01),
                                suffixIcon: Icon(
                                  Icons.phone_android,
                                  color: Colors.indigo[900],
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                    borderSide: BorderSide(
                                        width: 1, color: Colors.white)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
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
                              // buildCounter: (BuildContext context,
                              //         {int currentLength,
                              //         int maxLength,
                              //         bool isFocused}) =>
                              //     null,
                              keyboardType: TextInputType.number,
                              controller: controller,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ]),
                Container(
                  margin: EdgeInsets.all(10),
                  width: double.infinity,
                  child: ElevatedButtonWidget(
                    onClick: () {
                      if (formkey.currentState!.validate()) {
                        formkey.currentState!.save();

                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => OTPScreen(controller.text)));
                      }
                    },
                    height: height(context) * 0.057,
                    minWidth: width(context) * 0.8,
                    buttonName: 'Next',
                    bgColor: Colors.indigo[900],
                    textSize: width(context) * 0.05,
                    borderRadius: 10.0,
                    textColor: Colors.white,
                  ),
                )
              ],
            )
          : circleProgress(),
    );
  }
}
