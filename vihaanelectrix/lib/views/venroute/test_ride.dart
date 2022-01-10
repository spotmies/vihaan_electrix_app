import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:vihaanelectrix/controllers/venroute/testride.dart';
// import 'package:vihaanelectrix/providers/location_provider.dart';
import 'package:vihaanelectrix/widgets/app_config.dart';
import 'package:vihaanelectrix/widgets/date_time_picker.dart';
import 'package:vihaanelectrix/widgets/elevated_widget.dart';
import 'package:vihaanelectrix/widgets/snackbar.dart';
import 'package:vihaanelectrix/widgets/text_wid.dart';
import 'package:vihaanelectrix/widgets/textfield_widget.dart';

class TestRideBooking extends StatefulWidget {
  final String? productId;
  final String? userDetails;

  const TestRideBooking(
      {Key? key, @required this.productId, @required this.userDetails})
      : super(key: key);

  @override
  _TestRideBookingState createState() => _TestRideBookingState();
}

TestRideController testRideControl = TestRideController();

class _TestRideBookingState extends State<TestRideBooking> {
  // LocationProvider? locationProvider;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  dynamic position;
  @override
  void initState() {
    super.initState();
    // locationProvider = Provider.of<LocationProvider>(context, listen: false);
    resetForm();
    // getCurrentLocation();
  }

  resetForm() {
    formkey.currentState?.reset();
    testRideControl.aadharController.clear();
    testRideControl.idProofFile = null;
    testRideControl.selectedTime = null;
  }

  // getCurrentLocation() {
  //   // position = locationProvider?.getLocation;
  //   log("location $position");
  //   testRideControl.getAddressFromLatLong(position);
  //   testRideControl.refresh();
  // }

  onSubmit() async {
    log(widget.userDetails.toString() + widget.productId.toString());

    if (testRideControl.pickedDate == null) {
      testRideControl.pickedDate = await pickDate(context);
      setState(() {});
      return;
    }
    if (testRideControl.idProofFile == null) {
      snackbar(context, "Please upload id proof");
      return;
    }

    if (formkey.currentState!.validate()) {
      testRideControl.submit(widget.userDetails, widget.productId, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Fill details',
            style: TextStyle(color: Colors.grey[900]),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.grey[900],
              )),
        ),
        body: SafeArea(
          child: SizedBox(
            width: width(context),
            height: height(context),
            child: Form(
              key: formkey,
              child: SingleChildScrollView(
                  // height: height(context),
                  // width: width(context),
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () async {
                      log(testRideControl.pickedDate.toString());
                      testRideControl.pickedDate = await pickDate(context);
                      setState(() {});
                    },
                    child: Container(
                      height: height(context) * 0.1,
                      width: width(context) * 0.92,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: TextWidget(
                        text: testRideControl.pickedDate == null
                            ? 'Select Date'
                            : 'Schedule Date:  ' +
                                testRideControl.pickedDate!.day.toString() +
                                '/' +
                                testRideControl.pickedDate!.month.toString() +
                                '/' +
                                testRideControl.pickedDate!.day.toString(),
                        size: width(context) * 0.07,
                        weight: FontWeight.w600,
                        flow: TextOverflow.visible,
                        align: TextAlign.center,
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
                      maxLength: 12,
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
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //   children: [
                  //     timeSlotChips(context, '9:00 AM-12:00 PM', testRideControl,
                  //         onTap: () {
                  //       testRideControl.selectedTime = 1;
                  //       log(testRideControl.selectedTime.toString());
                  //     }),
                  //     timeSlotChips(context, '12:00 PM-3:00 PM', testRideControl,
                  //         onTap: () {
                  //       testRideControl.selectedTime = 2;
                  //       log(testRideControl.selectedTime.toString());
                  //     }),
                  //     timeSlotChips(context, '3:00 PM-6:00 PM', testRideControl,
                  //         onTap: () {
                  //       testRideControl.selectedTime = 3;
                  //       log(testRideControl.selectedTime.toString());
                  //     })
                  //   ],
                  // ),
                  // SizedBox(
                  //   height: height(context) * 0.02,
                  // ),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
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
                  SizedBox(
                    height: height(context) * 0.02,
                  ),
                  // Container(
                  //     height: height(context) * 0.18,
                  //     width: width(context) * 0.92,
                  //     padding: EdgeInsets.only(left: width(context) * 0.02),
                  //     decoration: BoxDecoration(
                  //       boxShadow: [
                  //         BoxShadow(
                  //           color: Colors.grey[300]!,
                  //           blurRadius: 10.0,
                  //           offset: Offset(0.0, 5.0),
                  //         ),
                  //       ],
                  //       borderRadius: BorderRadius.circular(15.0),
                  //       color: Colors.white,
                  //     ),
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //       children: [
                  //         testRideControl.displayAddress != null
                  //             ? SizedBox(
                  //                 width: width(context) * 0.72,
                  //                 child: TextWidget(
                  //                   text: testRideControl.displayAddress
                  //                       .toString(),
                  //                   flow: TextOverflow.visible,
                  //                   size: width(context) * 0.05,
                  //                 ),
                  //               )
                  //             : TextButton(
                  //                 onPressed: getCurrentLocation,
                  //                 child:
                  //                     TextWidget(text: "Current location")),
                  //         TextButton(
                  //             onPressed: () {
                  //               log('Clicked change button');

                  //               Navigator.push(
                  //                   context,
                  //                   MaterialPageRoute(
                  //                       builder: (context) => Maps(
                  //                             isNavigate: false,
                  //                             actionLabel: "Change address",
                  //                             popBackTwice: true,
                  //                             onSave: (Map<String, double>
                  //                                     generatedCords,
                  //                                 generatedAddress) {
                  //                               testRideControl.logitude =
                  //                                   generatedCords['lat']
                  //                                       .toString();
                  //                               testRideControl.logitude =
                  //                                   generatedCords['log']
                  //                                       .toString();
                  //                               testRideControl.fullAddress =
                  //                                   generatedAddress;
                  //                               testRideControl
                  //                                   .setDisplayAddress();
                  //                               setState(() {});
                  //                             },
                  //                           )));
                  //             },
                  //             child: TextWidget(
                  //               text: 'Change',
                  //               color: Colors.indigo[900],
                  //             ))
                  //       ],
                  //     )),
                  SizedBox(
                    height: height(context) * 0.15,
                  ),
                  ElevatedButtonWidget(
                    buttonName: 'Book Ride',
                    bgColor: Colors.indigo[900],
                    textColor: Colors.white,
                    textSize: width(context) * 0.05,
                    // style: TextStyle(fontWeight: FontWeight.w600),
                    height: height(context) * 0.06,
                    minWidth: width(context) * 0.92,
                    allRadius: true,
                    borderRadius: 15.0,
                    onClick: () {
                      onSubmit();
                    },
                  )
                ],
              )),
            ),
          ),
        ));
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
        weight: FontWeight.w600,
      ),
    ),
  );
}
