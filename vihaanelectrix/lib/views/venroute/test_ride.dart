import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:vihaanelectrix/controllers/venroute/testride.dart';
import 'package:vihaanelectrix/widgets/app_config.dart';
import 'package:vihaanelectrix/widgets/date_time_picker.dart';
import 'package:vihaanelectrix/widgets/elevated_widget.dart';
import 'package:vihaanelectrix/widgets/geo_position.dart';
import 'package:vihaanelectrix/widgets/text_wid.dart';
import 'package:vihaanelectrix/widgets/textfield_widget.dart';

class TestRideBooking extends StatefulWidget {
  final String? productId;
  final String? userDetails;
  const TestRideBooking({Key? key, this.productId, this.userDetails})
      : super(key: key);

  @override
  _TestRideBookingState createState() => _TestRideBookingState();
}

TestRideController testRideControl = TestRideController();

class _TestRideBookingState extends State<TestRideBooking> {
  @override
  Widget build(BuildContext context) {
    log(widget.userDetails.toString());
    log(widget.productId.toString());

    // testRideControl.postion = getGeoLocationPosition();
    return Scaffold(
        body: SizedBox(
            height: height(context),
            width: width(context),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () async {
                    testRideControl.pickedDate = await pickDate(context);
                    setState(() {});
                  },
                  child: Container(
                    height: height(context) * 0.1,
                    width: width(context) * 0.92,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(
                      testRideControl.pickedDate == null
                          ? 'Select Date'
                          : testRideControl.pickedDate!.day.toString() +
                              '/' +
                              testRideControl.pickedDate!.month.toString() +
                              '/' +
                              testRideControl.pickedDate!.day.toString(),
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                ),
                SizedBox(
                  height: height(context) * 0.02,
                ),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    timeSlotChips(context, '9:00 AM-12:00 PM', testRideControl,
                        onTap: () {
                      testRideControl.selectedTime = 1;
                      log(testRideControl.selectedTime.toString());
                    }),
                    timeSlotChips(context, '12:00 PM-3:00 PM', testRideControl,
                        onTap: () {
                      testRideControl.selectedTime = 2;
                      log(testRideControl.selectedTime.toString());
                    }),
                    timeSlotChips(context, '3:00 PM-6:00 PM', testRideControl,
                        onTap: () {
                      testRideControl.selectedTime = 3;
                      log(testRideControl.selectedTime.toString());
                    })
                  ],
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
                Text(''),
                ElevatedButtonWidget(
                  buttonName: 'Book Ride',
                  height: height(context) * 0.06,
                  minWidth: width(context) * 0.92,
                  onClick: () {
                    log(widget.userDetails.toString() +
                        widget.productId.toString());
                    testRideControl.submit(
                        widget.userDetails, widget.productId, context);
                  },
                )
              ],
            )));
  }
}

timeSlotChips(
    BuildContext context, String timeSlot, TestRideController testRideControl,
    {Function? onTap}) {
  return InkWell(
    onTap: () {
      onTap!();
    },
    child: Container(
      height: height(context) * 0.05,
      width: width(context) * 0.3,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0), color: Colors.indigo[900]),
      child: TextWidget(
        text: timeSlot,
        color: Colors.white,
        size: width(context) * 0.03,
      ),
    ),
  );
}
