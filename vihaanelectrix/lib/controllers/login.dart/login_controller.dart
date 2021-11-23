// import 'dart:developer';

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:mvc_pattern/mvc_pattern.dart';
// import 'package:provider/provider.dart';
// import 'package:vihaanelectrix/models/login/login.dart';
// import 'package:vihaanelectrix/providers/time_provider.dart';
// import 'package:vihaanelectrix/repo/api_calling.dart';
// import 'package:vihaanelectrix/repo/api_urls.dart';
// import 'package:vihaanelectrix/views/login/onboarding_screen.dart';
// import 'package:vihaanelectrix/views/login/otp_screen.dart';
// import 'package:vihaanelectrix/widgets/snackbar.dart';

// class LoginPageController extends ControllerMVC {
//   TimeProvider? timerProvider;

//   GlobalKey scaffoldkey = GlobalKey<ScaffoldState>();
//   var formkey = GlobalKey<FormState>();
//   var formkey1 = GlobalKey<FormState>();

//   TextEditingController loginnum = TextEditingController();

//   LoginModel? loginModel;

//   BuildContext? context;

//   LoginPageController() {
//     loginModel = LoginModel();
//   }

//   String _verificationCode = "";

//   @override
//   void initState() {
//     timerProvider = Provider.of<TimeProvider>(context!, listen: false);

//     super.initState();
//   }

//   dataToOTP() {
//     if (formkey.currentState!.validate()) {
//       formkey.currentState!.save();
//       timerProvider!.setPhNumber(loginnum.text.toString());

//       verifyPhone();
//     }
//   }

//   verifyPhone({bool? navigate = true}) async {
//     timerProvider!.resetTimer();
//     timerProvider!.setLoader(true, loadingValue: "Sending OTP .....");
//     log("phnum ${timerProvider!.phNumber}");
//     try {
//       await FirebaseAuth.instance.verifyPhoneNumber(
//           phoneNumber: '+91${timerProvider!.phNumber}',
//           verificationCompleted: (PhoneAuthCredential credential) async {
//             await FirebaseAuth.instance
//                 .signInWithCredential(credential)
//                 .then((value) async {
//               if (value.user != null) {
//                 log("user already login");
//                 checkUserRegistered(value.user!.uid);
//                 // Navigator.pushAndRemoveUntil(
//                 //     context,
//                 //     MaterialPageRoute(
//                 //         builder: (context) => StepperPersonalInfo(
//                 //             value: '+91${widget.phone}'
//                 //             )),
//                 //     (route) => false);
//                 Navigator.pushAndRemoveUntil(
//                     context!,
//                     MaterialPageRoute(builder: (context) => OnBoardingScreen()),
//                     (route) => false);
//               }
//             });
//           },
//           verificationFailed: (FirebaseAuthException e) {
//             log(e.message.toString());
//             snackbar(context!, e.message.toString());
//             timerProvider!.setLoader(false);
//           },
//           codeSent: (String? verficationID, int? resendToken) {
//             timerProvider!.setLoader(false);
//             snackbar(context!, "Otp send successfully ");

//             _verificationCode = verficationID!;
//             timerProvider!.setVerificationCode(verficationID);
//             // log("verfication code $_verificationCode");

//             // if (navigate == true) {

//             //   Navigator.of(context!).push(MaterialPageRoute(
//             //       builder: (context) =>
//             //           OTPScreen(loginnum.text, _verificationCode)));
//             // }
//           },
//           codeAutoRetrievalTimeout: (String? verificationID) {
//             _verificationCode = verificationID!;
//             timerProvider!.setVerificationCode(verificationID);
//             log("verfication code $_verificationCode");
//           },
//           timeout: Duration(seconds: 85));
//     } catch (e) {
//       log(e.toString());
//       snackbar(context!, e.toString());
//       timerProvider!.setLoader(false);
//     }
//   }

//   loginUserWithOtp(otpValue) async {
//     log("verfication code ${timerProvider!.verificationCode}");
//     log(otpValue.toString());
//     timerProvider!.setLoader(true);
//     try {
//       await FirebaseAuth.instance
//           .signInWithCredential(PhoneAuthProvider.credential(
//               verificationId: timerProvider!.verificationCode,
//               smsCode: otpValue))
//           .then((value) async {
//         if (value.user != null) {
//           // log("${value.user}");
//           // log("$value");
//           timerProvider!.setPhoneNumber(timerProvider!.phNumber.toString());
//           // print("user already login");
//           bool resp = await checkUserRegistered(value.user!.uid);
//           timerProvider!.setLoader(false);
//           if (resp == false) {
//             Navigator.pushAndRemoveUntil(
//                 context!,
//                 MaterialPageRoute(builder: (context) => OnBoardingScreen()),
//                 (route) => false);
//           } else {
//             Navigator.pushAndRemoveUntil(
//                 context!,
//                 MaterialPageRoute(builder: (context) => OnBoardingScreen()),
//                 (route) => false);
//           }
//         } else {
//           timerProvider!.setLoader(false);
//           snackbar(context!, "Something went wrong");
//         }
//       });
//     } catch (e) {
//       FocusScope.of(context!).unfocus();
//       log(e.toString());
//       timerProvider!.setLoader(false);
//       snackbar(context!, "Invalid OTP");
//     }
//   }
// }

// checkUserRegistered(uid) async {
//   // dynamic deviceToken = await FirebaseMessaging.instance.getToken();
//   // var obj = {
//   //   "lastLogin": DateTime.now().millisecondsSinceEpoch.toString(),
//   //   "userDeviceToken": deviceToken?.toString() ?? "",
//   // };
//   // print("checkUserreg");
//   // var response = await Server().editMethod(API.userDetails + uid, obj);
//   // print("36 $response");
//   // if (response.statusCode == 200 || response.statusCode == 204) {
//   //   return true;
//   // } else {
//   //   return false;
//   // }
// }
