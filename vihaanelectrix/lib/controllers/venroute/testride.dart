import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:vihaanelectrix/repo/api_methods.dart';
import 'package:vihaanelectrix/repo/api_urls.dart';
import 'package:vihaanelectrix/widgets/snackbar.dart';
import 'package:geolocator/geolocator.dart';


class TestRideController extends ControllerMVC {
  TextEditingController aadharController = TextEditingController();
  String? idProof;
  File? idProofFile;
  DateTime? pickedDate;
  int? selectedTime;
  Position? postion;
  // String? vehicleDetails;

  Future<void> aadharFile() async {
    try {
      final image = await ImagePicker().pickImage(
        source: ImageSource.camera,
        imageQuality: 20,
        preferredCameraDevice: CameraDevice.front,
      );
      final profilepicTemp = File(image!.path);
      idProofFile = profilepicTemp;
      setState(() {});
    } on PlatformException catch (e) {
      log(e.toString());
    }
  }

  Future<void> uploadimage() async {
    if (idProofFile == null) return;
    var postImageRef = FirebaseStorage.instance.ref().child('ProfilePic');
    UploadTask uploadTask = postImageRef
        .child(DateTime.now().toString() + ".jpg")
        .putFile(idProofFile!);
    log(uploadTask.toString());
    var imageUrl = await (await uploadTask).ref.getDownloadURL();
    idProof = imageUrl.toString();
    log(idProof.toString());
  }

  Future<void> submit(
      String? userDetils, String? vehicleDetails, BuildContext context) async {
    await uploadimage();
    log(idProof.toString());
    var body = {
      "adharNumber": aadharController.text.toString(),
      "identityProof.0": idProof!.toString(),
      "userDetails": userDetils.toString(),
      "vehicleDetails": vehicleDetails.toString(),
      "schedule": pickedDate!.millisecondsSinceEpoch.toString(),
      "timeSolt": selectedTime.toString(),
    };

    log(body.toString());

    var resp = await Server().postMethod(API.newTestRide, body).catchError((e) {
      log(e.toString());
    });
    log("respss ${resp.statusCode}");
    log("response ${resp.body}");
    if (resp.statusCode == 200) {
      snackbar(context, "test ride booking successfull");
      // await Navigator.pushAndRemoveUntil(context,
      //     MaterialPageRoute(builder: (_) => GoogleNavBar()), (route) => false);
    } else {
      snackbar(context, "something went wrong");
    }
    return resp;
  }
}
