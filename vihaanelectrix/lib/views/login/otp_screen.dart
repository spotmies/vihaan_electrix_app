import 'dart:async';
import 'dart:developer';
import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:vihaanelectrix/controllers/login.dart/login_control.dart';
import 'package:vihaanelectrix/providers/common_provider.dart';
import 'package:provider/provider.dart';
import 'package:vihaanelectrix/views/login/login_utils.dart';
import 'package:vihaanelectrix/views/login/user_registration.dart';
import 'package:vihaanelectrix/widgets/app_config.dart';
import 'package:vihaanelectrix/widgets/elevated_widget.dart';
import 'package:vihaanelectrix/widgets/indicators.dart';
import 'package:vihaanelectrix/widgets/snackbar.dart';
import 'package:vihaanelectrix/widgets/text_wid.dart';

class OTPScreen extends StatefulWidget {
  final String phone;
  const OTPScreen(this.phone, {Key? key}) : super(key: key);
  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  LoginPageController controller = LoginPageController();
  CommonProvider? co;

  // final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  String? _verificationCode;
  Timer? timer;
  // ignore: non_constant_identifier_names, prefer_typing_uninitialized_variables
  var sms_code;
  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();
  final BoxDecoration pinPutDecoration = BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(
        color: Colors.grey[100]!,
      ),
      boxShadow: [
        BoxShadow(color: Colors.grey[100]!, blurRadius: 5.0, spreadRadius: 2.0)
      ]);

  startResendOTPTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      co?.updateTime();
      if (co?.resendOtpCount == 0) timer.cancel();
    });
  }

  @override
  void initState() {
    super.initState();
    co = Provider.of<CommonProvider>(context, listen: false);
    co?.setCurrentConstants("otp");
    _verifyPhone();
    startResendOTPTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      key: controller.otpscaffoldkey,
      body: Consumer<CommonProvider>(builder: (context, data, child) {
        return SingleChildScrollView(
          child: Column(
            children: [
              loginHeader(context),
              Stack(
                children: [
                  loginBackgroundTemp(context),
                  Positioned(
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/pngs/otp_image.png',
                          height: height(context) * 0.3,
                          width: width(context),
                        ),
                        SizedBox(
                          height: height(context) * 0.06,
                        ),
                        TextWidget(
                          text: 'Enter OTP',
                          color: Colors.indigo[900],
                          size: width(context) * 0.06,
                          weight: FontWeight.bold,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: PinPut(
                            fieldsCount: 6,
                            textStyle: TextStyle(
                                fontSize: width(context) * 0.04,
                                color: Colors.grey[900]),
                            eachFieldWidth: width(context) * 0.05,
                            eachFieldHeight: height(context) * 0.07,
                            focusNode: _pinPutFocusNode,
                            controller: _pinPutController,
                            submittedFieldDecoration: pinPutDecoration,
                            selectedFieldDecoration: pinPutDecoration,
                            followingFieldDecoration: pinPutDecoration,
                            pinAnimationType: PinAnimationType.fade,
                            onSubmit: (pin) async {
                              sms_code = pin;
                              try {
                                await FirebaseAuth.instance
                                    .signInWithCredential(
                                        PhoneAuthProvider.credential(
                                            verificationId: _verificationCode!,
                                            smsCode: pin))
                                    .then((value) async {
                                  log(value.toString());
                                  if (value.user != null) {
                                    controller.checkUser(context,
                                        uId: value.user?.uid.toString(),
                                        phone: widget.phone);
                                  }
                                });
                              } catch (e) {
                                FocusScope.of(context).unfocus();
                                snackbar(context, 'invalid OTP');
                              }
                            },
                          ),
                        ),
                        Container(
                          alignment: data.resendOtpCount > 0
                              ? Alignment.center
                              : Alignment.centerRight,
                          child: data.resendOtpCount > 0
                              ? CircularPercentIndicator(
                                  radius: 55,
                                  lineWidth: 3,
                                  animation: true,
                                  animationDuration: 99999,
                                  progressColor: Colors.indigo[50],
                                  percent: 1.0,
                                  backgroundColor: Colors.indigo[900]!,
                                  center: TextWidget(
                                    text: '${data.resendOtpCount}',
                                    color: Colors.indigo[900],
                                    size: width(context) * 0.055,
                                    weight: FontWeight.w600,
                                  ))
                              : ElevatedButtonWidget(
                                  bgColor: Colors.transparent,
                                  buttonName: 'Resend',
                                  textSize: width(context) * 0.045,
                                  textStyle: FontWeight.w600,
                                  textColor: Colors.indigo[900],
                                  height: height(context) * 0.07,
                                  minWidth: width(context) * 0.4,
                                  borderSideColor: Colors.transparent,
                                  trailingIcon: Icon(Icons.sync,
                                      color: Colors.indigo[900],
                                      size: width(context) * 0.05),
                                  onClick: () {
                                    resendOtp();
                                  }),
                        ),
                        SizedBox(
                          height: height(context) * 0.06,
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          padding:
                              EdgeInsets.only(right: width(context) * 0.05),
                          child: ElevatedButtonWidget(
                            onClick: () async {
                              log(sms_code.toString());
                              try {
                                await FirebaseAuth.instance
                                    .signInWithCredential(
                                        PhoneAuthProvider.credential(
                                            verificationId: _verificationCode!,
                                            smsCode: sms_code))
                                    .then((value) async {
                                  log(value.toString());
                                  if (value.user != null) {
                                    controller.checkUser(context,
                                        uId: value.user?.uid.toString(),
                                        phone: widget.phone);
                                  }
                                });
                              } catch (e) {
                                FocusScope.of(context).unfocus();
                                snackbar(context, 'invalid OTP');
                              }
                            },
                            height: height(context) * 0.057,
                            minWidth: width(context) * 0.33,
                            buttonName: 'Submit',
                            trailingIcon: Icon(
                              Icons.arrow_forward,
                              size: width(context) * 0.05,
                            ),
                            bgColor: Colors.indigo[900],
                            textSize: width(context) * 0.05,
                            allRadius: true,
                            borderRadius: 20.0,
                            textColor: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      }),
    );
  }

  void resendOtp() {
    log("resned otp...");
    co?.resetTimer();

    _verifyPhone();
    startResendOTPTimer();
  }

  _verifyPhone() async {
    log("send otp....");
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+91${widget.phone}',
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance
              .signInWithCredential(credential)
              .then((value) async {
            log(value.toString());
            if (value.user != null) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UserRegistration(widget.phone)),
                  (route) => false);
            }
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          log(e.message.toString());
          snackbar(context, e.message.toString());
        },
        codeSent: (String? verficationID, int? resendToken) {
          log(verficationID.toString());
          snackbar(context, "Otp send successfully ");
          setState(() {
            _verificationCode = verficationID;
          });
        },
        codeAutoRetrievalTimeout: (String verificationID) {
          setState(() {
            _verificationCode = verificationID;
          });
        },
        timeout: Duration(seconds: 99));
  }
}
