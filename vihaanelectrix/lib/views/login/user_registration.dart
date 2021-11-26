import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:vihaanelectrix/controllers/login.dart/user_registration_controller.dart';
import 'package:vihaanelectrix/utilities/shared_preference.dart';
import 'package:vihaanelectrix/widgets/app_config.dart';
import 'package:vihaanelectrix/widgets/elevated_widget.dart';

class UserRegistration extends StatefulWidget {
  const UserRegistration({Key? key}) : super(key: key);

  @override
  _UserRegistrationState createState() => _UserRegistrationState();
}

class _UserRegistrationState extends State<UserRegistration> {
  UserRegistrationController userRegistrationController =
      UserRegistrationController();


  /* -------------------------- THIS IS FOR CONSTATNS ------------------------- */
  dynamic constants;
  bool showUi = false;

  getText(String objId) {
    // log(constants.toString());
    if (constants == null) return "loading..";
    int index = constants?.indexWhere(
        (element) => element['objId'].toString() == objId.toString());
    // log(index.toString());
    if (index == -1) return "null";
    return constants[index]['label'];
  }

  constantsFunc() async {
    dynamic allConstants = await getAppConstants();
    setState(() {
      showUi = true;
    });
    constants = allConstants['signup'];
  }

  /* -------------------------- END OF THE CONSTANTS -------------------------- */



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          userRegistration(context, userRegistrationController),
          Container(
            margin: EdgeInsets.all(10),
            width: double.infinity,
            child: ElevatedButtonWidget(
              onClick: () {
                userRegistrationController.createUser(context);
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
      ),
    );
  }
}

Widget userRegistration(BuildContext context,
    UserRegistrationController userRegistrationController) {
  return Column(
    children: [
      SizedBox(
        height: height(context) * 0.75,
        child: ListView(
          children: [
            SizedBox(
              height: height(context) * 0.375,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Container(
                        padding: EdgeInsets.all(10),
                        height: height(context) * 0.15,
                        width: double.infinity,
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
                                          userRegistrationController
                                              .profilepic!),
                                      radius: 100,
                                    ),
                                  ),
                          ),
                          radius: 30,
                          backgroundColor: Colors.grey[100],
                        ),
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
                            'Choose Image',
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
                  hintText: 'Name',
                  suffixIcon: Icon(Icons.person),
                  //border: InputBorder.none,
                  contentPadding: EdgeInsets.all(20),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please Enter Your Name';
                  }
                  if (value.length < 5) {
                    return 'name should be greater than 4 letters';
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

// Widget profilePic(BuildContext context,
//     UserRegistrationController userRegistrationController) {
//   return Column(
//     children: [
      
//     ],
//   );
// }
