import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:vihaanelectrix/controllers/login.dart/user_registration_controller.dart';
import 'package:vihaanelectrix/utilities/shared_preference.dart';
import 'package:vihaanelectrix/views/login/user_registration.dart';
import 'package:vihaanelectrix/widgets/snackbar.dart';

class OTPScreen extends StatefulWidget {
  final String phone;
  const OTPScreen(this.phone, {Key? key}) : super(key: key);
  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  UserRegistrationController controller = UserRegistrationController();

  // final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  String? _verificationCode;
  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();
  final BoxDecoration pinPutDecoration = BoxDecoration(
    color: const Color.fromRGBO(43, 46, 66, 1),
    borderRadius: BorderRadius.circular(10.0),
    border: Border.all(
      color: const Color.fromRGBO(126, 203, 224, 1),
    ),
  );

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
    constants = allConstants['otp'];
    log(constants.toString());
  }

  /* -------------------------- END OF THE CONSTANTS -------------------------- */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: controller.scaffoldkey,
      appBar: AppBar(
        title: Text(getText("app_bar_title")),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 40),
            child: Center(
              child: Text(
                'Verify +91-${widget.phone}',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: PinPut(
              fieldsCount: 6,
              textStyle: const TextStyle(fontSize: 25.0, color: Colors.white),
              eachFieldWidth: 40.0,
              eachFieldHeight: 55.0,
              focusNode: _pinPutFocusNode,
              controller: _pinPutController,
              submittedFieldDecoration: pinPutDecoration,
              selectedFieldDecoration: pinPutDecoration,
              followingFieldDecoration: pinPutDecoration,
              pinAnimationType: PinAnimationType.fade,
              onSubmit: (pin) async {
                try {
                  await FirebaseAuth.instance
                      .signInWithCredential(PhoneAuthProvider.credential(
                          verificationId: _verificationCode!, smsCode: pin))
                      .then((value) async {
                    log(value.toString());
                    if (value.user != null) {
                      controller.checkUser(context,
                          uId: value.user?.uid.toString(), phone: widget.phone);
                    }
                  });
                } catch (e) {
                  FocusScope.of(context).unfocus();
                  snackbar(context, 'invalid OTP');
                }
              },
            ),
          )
        ],
      ),
    );
  }

  _verifyPhone() async {
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
        timeout: Duration(seconds: 120));
  }

  @override
  void initState() {
    super.initState();
    constantsFunc();
    _verifyPhone();
  }
}
