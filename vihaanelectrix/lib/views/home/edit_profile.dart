import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:vihaanelectrix/controllers/login.dart/user_registration_controller.dart';
import 'package:vihaanelectrix/providers/user_details_provider.dart';
import 'package:vihaanelectrix/widgets/app_bar.dart';
import 'package:vihaanelectrix/widgets/app_config.dart';
import 'package:vihaanelectrix/widgets/elevated_widget.dart';
import 'package:vihaanelectrix/widgets/progress.dart';
import 'package:vihaanelectrix/widgets/textfield_widget.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

UserDetailsProvider? profileProvider;
UserRegistrationController userRegistrationController =
    UserRegistrationController();

class _EditProfileState extends State<EditProfile> {
  @override
  void initState() {
    super.initState();

    profileProvider = Provider.of<UserDetailsProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWithTitle(
        context,
        title: 'Edit Profile',
      ),
      body: Consumer<UserDetailsProvider>(builder: (context, data, child) {
        // var u = data.user;
        if (data.loaderScreen == true) {
          return circleProgress(context);
        }
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () async {
                if (userRegistrationController.profilepic == null) {
                  await userRegistrationController.profilePic();
                  setState(() {});

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
                    radius: width(context) * 0.2,
                    backgroundColor: Colors.white,
                  ),
                  if (userRegistrationController.profilepic != null)
                    Positioned(
                        right: width(context) * 0.02,
                        top: width(context) * 0.02,
                        child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: width(context) * 0.03,
                            child: IconButton(
                                padding: EdgeInsets.all(0),
                                onPressed: () async {
                                  await userRegistrationController.profilePic();
                                  setState(() {});

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
              height: height(context) * 0.06,
            ),
            Container(
              height: height(context) * 0.085,
              padding: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 10),
              child: TextFieldWidget(
                controller: userRegistrationController.editNameController,
                hint: 'Enter your name Here',
                label: "Name",
                enableBorderColor: AppColors.grey,
                focusBorderColor: AppColors.primaryColorLite,
                enableBorderRadius: 15,
                focusBorderRadius: 15,
                errorBorderRadius: 15,
                focusErrorRadius: 15,
                validateMsg: 'Enter Valid Name',
                maxLines: 1,
                postIcon: Icon(
                  Icons.edit,
                  size: width(context) * 0.045,
                  color: AppColors.dark,
                ),
                postIconColor: AppColors.primaryColorLite,
              ),
            ),
            SizedBox(
              height: height(context) * 0.01,
            ),
            Container(
              margin: EdgeInsets.all(10),
              alignment: Alignment.center,
              child: ElevatedButtonWidget(
                onClick: () async {
                  setState(() {
                    data.loaderScreen = true;
                  });
                  var resp = await userRegistrationController.editUser(context);
                  // log(resp.body.toString());
                  if (resp.statusCode == 200) {
                    var data = jsonDecode(resp.body);
                    data.updateUserDetails(data['name'], data['pic']);
                  }

                  setState(() {
                    data.loaderScreen = false;
                  });
                  Navigator.pop(context);
                },
                height: height(context) * 0.06,
                minWidth: width(context) * 0.9,
                buttonName: 'Change',
                bgColor: Colors.indigo[900],
                textSize: width(context) * 0.05,
                borderRadius: 10.0,
                allRadius: true,
                textColor: Colors.white,
              ),
            ),
            SizedBox(
              height: height(context) * 0.15,
            ),
          ],
        );
      }),
    );
  }
}
