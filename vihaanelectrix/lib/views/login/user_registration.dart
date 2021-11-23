import 'package:flutter/material.dart';
import 'package:vihaanelectrix/controllers/login.dart/user_registration_controller.dart';
import 'package:vihaanelectrix/widgets/app_config.dart';

class UserRegistration extends StatefulWidget {
  const UserRegistration({ Key? key }) : super(key: key);

  @override
  _UserRegistrationState createState() => _UserRegistrationState();
}

class _UserRegistrationState extends State<UserRegistration> {
  UserRegistrationController userRegistrationController = UserRegistrationController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: userRegistration(context, userRegistrationController),
    );
  }
}



Widget userRegistration(BuildContext context, UserRegistrationController userRegistrationController) {
  return Column(
    children: [
      SizedBox(
        height: height(context) * 0.75,
        child: ListView(
          children: [
            Container(
              height: height(context) * 0.1,
              width: width(context) * 1,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(15)),
              child: TextFormField(
                onSaved: (item) =>
                    userRegistrationController.name,
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
            SizedBox(
              height: 7,
            ),
            Container(
              //padding: EdgeInsets.all(10),
              height: height(context) * 0.1,
              width: width(context) * 1,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(15)),
              child: TextFormField(
                onSaved: (item) =>
                    userRegistrationController.email,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      borderSide: BorderSide(width: 1, color: Colors.white)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      borderSide: BorderSide(width: 1, color: Colors.white)),
                  hintStyle: TextStyle(fontSize: 17, color: Colors.grey),
                  hintText: 'Email(Optional)',
                  suffixIcon: Icon(Icons.email),
                  //border: InputBorder.none,
                  contentPadding: EdgeInsets.all(20),
                ),
                validator: (value) {
                  if (value!.length > 1 && !value.contains('@')) {
                    return 'Please Enter Valid Email';
                  }
                  return null;
                },
                controller: userRegistrationController.emailTf,
                onChanged: (value) {
                  userRegistrationController.email = value;
                },
              ),
            ),
            SizedBox(
              height: 7,
            ),
            Container(
              //padding: EdgeInsets.all(10),
              height: height(context) * 0.1,
              width: width(context) * 1,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(15)),
              child: TextFormField(
                maxLength: 10,
                onSaved: (item) =>
                    userRegistrationController.altnumber,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  // labelText: "optional",
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      borderSide: BorderSide(width: 1, color: Colors.white)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      borderSide: BorderSide(width: 1, color: Colors.white)),
                  hintStyle: TextStyle(fontSize: 17, color: Colors.grey),
                  hintText: 'Alternative Mobile (optional)',
                  suffixIcon: Icon(Icons.dialpad),
                  //border: InputBorder.none,
                  contentPadding: EdgeInsets.all(20),
                  counterText: "",
                ),
                validator: (value) {
                  if (value!.length == 10 && int.parse(value) < 5000000000) {
                    return 'Please Enter Valid Mobile Number';
                  } else if (value.isNotEmpty && value.length < 10) {
                    return 'Please Enter Valid Mobile Number';
                  }
                  return null;
                },
                controller: userRegistrationController.altnumberTf,
                onChanged: (value) {
                  userRegistrationController.altnumber = value;
                },
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
