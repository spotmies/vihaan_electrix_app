import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:vihaanelectrix/views/login/login_screen.dart';
import 'package:vihaanelectrix/views/login/onboarding_screen.dart';
import 'package:vihaanelectrix/widgets/text_wid.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  checkUser() async {
    if (FirebaseAuth.instance.currentUser != null) {
      bool resp =
          await checkUserRegistered(FirebaseAuth.instance.currentUser!.uid);
      if (resp != false) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => OnBoardingScreen()),
            (route) => false);
      } else {
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (_) => LoginScreen()), (route) => false);
      }
    } else {
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (_) => LoginScreen()), (route) => false);
    }
  }

  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 2), () {
      // print("18 ${FirebaseAuth.instance.currentUser}");
      checkUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    final _hight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        kToolbarHeight;
    final _width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                  height: _hight * 0.43,
                  child: Lottie.asset('assets/splash_animation.json')),
              SizedBox(
                height: _hight * 0.1,
              ),
              Column(
                children: [
                  TextWidget(
                    text: 'VIHAAN ELECTRIX',
                    size: _width * 0.08,
                    color: Colors.indigo[900],
                    lSpace: 3.0,
                    weight: FontWeight.w600,
                    align: TextAlign.justify,
                    flow: TextOverflow.ellipsis,
                  ),
                  TextWidget(
                    text: 'VE CARES EV',
                    size: _width * 0.05,
                    color: Colors.grey[700],
                    weight: FontWeight.w600,
                    align: TextAlign.justify,
                    flow: TextOverflow.ellipsis,
                    lSpace: 8.0,
                  ),
                  // SizedBox(
                  //   height: _hight * 0.1,
                  // ),
                ],
              ),
            ],
          ),
        ));
  }
}

checkUserRegistered(uid) async {
  // dynamic deviceToken = await FirebaseMessaging.instance.getToken();
  // var obj = {
  //   "lastLogin": DateTime.now().millisecondsSinceEpoch.toString(),
  //   "userDeviceToken": deviceToken?.toString() ?? "",
  // };
  // log(obj.toString());
  // var response = await Server().editMethod(API.userDetails + uid, obj);
  // // print("36 $response");
  // if (response.statusCode == 200 || response.statusCode == 204) {
  // return true;
  // } else {
  return false;
  // }
}
