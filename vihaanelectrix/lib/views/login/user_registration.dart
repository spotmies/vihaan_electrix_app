import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:vihaanelectrix/controllers/login.dart/user_registration_controller.dart';
import 'package:vihaanelectrix/providers/common_provider.dart';
import 'package:provider/provider.dart';
import 'package:vihaanelectrix/views/home/navbar.dart';
import 'package:vihaanelectrix/views/login/login_utils.dart';
import 'package:vihaanelectrix/widgets/app_config.dart';
import 'package:vihaanelectrix/widgets/elevated_widget.dart';
import 'package:vihaanelectrix/widgets/geo_position.dart';

class UserRegistration extends StatefulWidget {
  final String phone;
  const UserRegistration(this.phone, {Key? key}) : super(key: key);

  @override
  _UserRegistrationState createState() => _UserRegistrationState();
}

class _UserRegistrationState extends State<UserRegistration> {
  UserRegistrationController userRegistrationController =
      UserRegistrationController();
  CommonProvider? co;

  @override
  void initState() {
    userRegistrationController.phone = widget.phone;
    co = Provider.of<CommonProvider>(context, listen: false);
    co?.setCurrentConstants("signup");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getGeoLocationPosition();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Column(
        children: [
          loginHeader(context),
          Stack(
            children: [
              loginBackgroundTemp(context),
              Positioned(
                  child: Column(children: [
                Image.asset(
                  'assets/pngs/reg_image.png',
                  height: height(context) * 0.3,
                  width: width(context),
                ),
                SizedBox(
                  height: height(context) * 0.05,
                ),
                InkWell(
                  onTap: () async {
                    if (userRegistrationController.profilepic == null) {
                      await userRegistrationController.profilePic();
                      userRegistrationController.refresh();

                      log(userRegistrationController.profilepic.toString());
                    }
                  },
                  child: Stack(
                    children: [
                      CircleAvatar(
                        child: Center(
                          child: userRegistrationController.profilepic == null
                              ? Icon(
                                  Icons.person,
                                  color: Colors.blueGrey,
                                  size: width(context) * 0.15,
                                )
                              : Container(
                                  height: height(context) * 0.27,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: CircleAvatar(
                                    backgroundImage: FileImage(
                                        userRegistrationController.profilepic!),
                                    radius: 100,
                                  ),
                                ),
                        ),
                        radius: width(context) * 0.12,
                        backgroundColor: Colors.white,
                      ),
                      if (userRegistrationController.profilepic != null)
                        Positioned(
                            right: 1,
                            top: 1,
                            child: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: width(context) * 0.03,
                                child: IconButton(
                                    padding: EdgeInsets.all(0),
                                    onPressed: () async {
                                      await userRegistrationController
                                          .profilePic();
                                      userRegistrationController.refresh();

                                      log(userRegistrationController.profilepic
                                          .toString());
                                    },
                                    icon: Icon(Icons.camera_alt,
                                        size: width(context) * 0.04,
                                        color: Colors.grey[900]))))
                    ],
                  ),
                ),
                SizedBox(
                  height: height(context) * 0.05,
                ),
                Container(
                  height: height(context) * 0.08,
                  width: width(context) * 0.9,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30)),
                  child: TextFormField(
                    onSaved: (item) => userRegistrationController.name,
                    keyboardType: TextInputType.name,
                    controller: userRegistrationController.nameTf,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          borderSide:
                              BorderSide(width: 1, color: Colors.white)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          borderSide:
                              BorderSide(width: 1, color: Colors.white)),
                      hintStyle: TextStyle(fontSize: 17, color: Colors.grey),
                      // hintText: co?.getText("name_hint"),
                      hintText: 'Enter your name',
                      suffixIcon: Icon(Icons.person),
                      //border: InputBorder.none,
                      contentPadding: EdgeInsets.all(20),
                    ),
                    // autofocus: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return co?.getText("empty_name_error");
                      }
                      if (value.length < 5) {
                        return co?.getText("name_length_error");
                      }
                      return null;
                    },
                    onChanged: (value) {
                      userRegistrationController.name = value;
                    },
                  ),
                ),
                SizedBox(
                  height: height(context) * 0.07,
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  alignment: Alignment.centerRight,
                  child: ElevatedButtonWidget(
                    onClick: () async {
                      userRegistrationController.position =
                          await getGeoLocationPosition();
                      userRegistrationController.refresh();
                      await userRegistrationController.createUser(context);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return NavigationBar();
                      }));
                    },
                    height: height(context) * 0.06,
                    minWidth: width(context) * 0.33,
                    // buttonName: co?.getText("button_label"),
                    buttonName: 'Finish',
                    bgColor: Colors.indigo[900],
                    textSize: width(context) * 0.05,
                    borderRadius: 30.0,
                    // trailingIcon: Icon(
                    //   Icons.arrow_forward,
                    //   size: width(context) * 0.05,
                    // ),
                    textColor: Colors.white,
                  ),
                )
              ]))
            ],
          ),
          // userRegistration(context, userRegistrationController, co!),
        ],
      ),
    );
  }
}

Widget userRegistration(BuildContext context,
    UserRegistrationController userRegistrationController, CommonProvider? co) {
  return Column(
    children: [
      SizedBox(
        // height: height(context) * 0.4,
        child: ListView(
          children: [
            SizedBox(
              height: height(context) * 0.375,
              child: Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      height: height(context) * 0.15,
                      width: width(context),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30)),
                      ),
                      child: CircleAvatar(
                        child: Center(
                          child: userRegistrationController.profilepic == null
                              ? Icon(
                                  Icons.person,
                                  color: Colors.blueGrey,
                                  size: width(context) * 0.15,
                                )
                              : Container(
                                  height: height(context) * 0.27,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: CircleAvatar(
                                    backgroundImage: FileImage(
                                        userRegistrationController.profilepic!),
                                    radius: 100,
                                  ),
                                ),
                        ),
                        radius: 30,
                        backgroundColor: Colors.grey[100],
                      ),
                    ),
                    Container(
                      height: 40,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30)),
                        // border: Border.all()
                      ),
                      child: TextButton(
                          onPressed: () async {
                            await userRegistrationController.profilePic();
                            userRegistrationController.refresh();

                            log(userRegistrationController.profilepic
                                .toString());
                          },
                          // icon: Icon(Icons.select_all),
                          child: Text(
                            co?.getText("choose_image"),
                            style: TextStyle(fontSize: 18, color: Colors.grey),
                          )),
                    ),
                  ]),
            ),
            Container(
              height: height(context) * 0.1,
              width: width(context) * 1,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(15)),
              child: TextFormField(
                onSaved: (item) => userRegistrationController.name,
                keyboardType: TextInputType.name,
                controller: userRegistrationController.nameTf,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      borderSide: BorderSide(width: 1, color: Colors.white)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      borderSide: BorderSide(width: 1, color: Colors.white)),
                  hintStyle: TextStyle(fontSize: 17, color: Colors.grey),
                  hintText: co?.getText("name_hint"),
                  suffixIcon: Icon(Icons.person),
                  //border: InputBorder.none,
                  contentPadding: EdgeInsets.all(20),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return co?.getText("empty_name_error");
                  }
                  if (value.length < 5) {
                    return co?.getText("name_length_error");
                  }
                  return null;
                },
                onChanged: (value) {
                  userRegistrationController.name = value;
                },
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
