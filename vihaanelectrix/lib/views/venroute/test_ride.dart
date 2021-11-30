import 'package:flutter/material.dart';
import 'package:vihaanelectrix/controllers/venroute/testride.dart';
import 'package:vihaanelectrix/widgets/app_config.dart';
import 'package:vihaanelectrix/widgets/text_wid.dart';
import 'package:vihaanelectrix/widgets/textfield_widget.dart';

class TestRideBooking extends StatefulWidget {
  const TestRideBooking({Key? key}) : super(key: key);

  @override
  _TestRideBookingState createState() => _TestRideBookingState();
}

TestRideController testRideControl = TestRideController();

class _TestRideBookingState extends State<TestRideBooking> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
            height: height(context),
            width: width(context),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // TextWidget(
                //   // text: pickDate(context),
                //   size: 20,
                //   weight: FontWeight.bold,
                // ),
                SizedBox(
                  width: width(context) * 0.92,
                  child: TextFieldWidget(
                    label: 'Aadhar Number',
                    hint: 'Enter Aadhar Number',
                    keyBoardType: TextInputType.number,
                    postIcon: Icon(Icons.fingerprint),
                    hintColor: Colors.grey[500],
                    enableBorderColor: Colors.grey[900],
                    focusBorderColor: Colors.grey[900],
                    prefixColor: Colors.grey[900],
                    postIconColor: Colors.grey[900],
                    borderRadius: 15.0,
                    errorBorderRadius: 15.0,
                    focusBorderRadius: 15.0,
                    enableBorderRadius: 15.0,
                    focusErrorRadius: 15.0,
                    controller: testRideControl.aadharController,
                  ),
                ),
                SizedBox(
                  height: height(context) * 0.02,
                ),
                testRideControl.idProofFile == null
                    ? InkWell(
                        onTap: () async {
                          await testRideControl.aadharFile();
                          setState(() {});
                        },
                        child: Container(
                            height: height(context) * 0.25,
                            width: width(context) * 0.92,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey[300]!,
                                    blurRadius: 10.0,
                                    offset: Offset(0.0, 5.0),
                                  ),
                                ]),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.document_scanner,
                                  size: width(context) * 0.11,
                                ),
                                TextWidget(text: 'Upload ID Proof'),
                              ],
                            )),
                      )
                    : InkWell(
                        onTap: () async {},
                        child: Container(
                          height: height(context) * 0.25,
                          width: width(context) * 0.92,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              color: Colors.white,
                              image: DecorationImage(
                                  image:
                                      FileImage(testRideControl.idProofFile!),
                                  fit: BoxFit.cover)),
                        ),
                      ),
              ],
            )));
  }
}
