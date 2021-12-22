import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:vihaanelectrix/repo/api_methods.dart';
import 'package:vihaanelectrix/repo/api_urls.dart';
import 'package:vihaanelectrix/utilities/addressExtractor.dart';
import 'package:vihaanelectrix/widgets/geo_position.dart';
import 'package:vihaanelectrix/widgets/snackbar.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class TestRideController extends ControllerMVC {
  TextEditingController aadharController = TextEditingController();
  String? idProof;
  File? idProofFile;
  DateTime? pickedDate;
  int? selectedTime;
  Position? position;
  String? displayAddress;
  dynamic fullAddress;
  String? latitude;
  String? logitude;

  Future getAddressFromLatLong(geoLoc) async {
    log("calling getAddressFromlatLogn");
    position = await geoLoc != null ? geoLoc : getGeoLocationPosition();
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position!.latitude, position!.longitude);
    latitude = position!.latitude.toString();
    logitude = position!.longitude.toString();
    // log(placemarks.toString());
    Placemark place = placemarks[0];
    fullAddress = addressExtractor2(place);
    // displayAddress =
    //     '${place.street},  ${place.subLocality}, ${place.locality},${place.administrativeArea}, ${place.postalCode}, ${place.country}';
    setDisplayAddress();
    setState(() {});
  }

  setDisplayAddress() {
    displayAddress =
        "${fullAddress['addressLine']}, ${fullAddress['subLocality']}, ${fullAddress['locality']}, ${fullAddress['postalCode']},";
    setState(() {});
  }

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
    Map<String, String> body = {
      "adharNumber": aadharController.text.toString(),
      "identityProof.0": idProof!.toString(),
      "userDetails": userDetils.toString(),
      "vehicleDetails": vehicleDetails.toString(),
      "schedule": pickedDate!.millisecondsSinceEpoch.toString(),
      "timeSolt": '1'.toString(),
      // "bookingLocation.0": latitude.toString(),
      // "bookingLocation.1": logitude.toString(),
      // "bookingPlace.subLocality": fullAddress['subLocality'],
      // "bookingPlace.locality": fullAddress['locality'],
      // "bookingPlace.city": fullAddress['city'],
      // "bookingPlace.state": fullAddress['state'],
      // "bookingPlace.country": fullAddress['country'],
      // "bookingPlace.postalCode": fullAddress['postalCode'],
      // "bookingPlace.addressLine": fullAddress['addressLine'],
      // "bookingPlace.subAdminArea": fullAddress['subAdminArea'],
      // "bookingPlace.subThoroughfare": fullAddress['subThoroughfare'],
      // "bookingPlace.thoroughfare": fullAddress['thoroughfare'],
    };

    log(body.toString());
    snackbar(context, "Please wait a moment");
    var resp = await Server().postMethod(API.newTestRide, body).catchError((e) {
      log(e.toString());
    });
    log("respss ${resp.statusCode}");
    log("response ${resp.body}");
    if (resp.statusCode == 200) {
      snackbar(context, "test ride booking successfull");
      Navigator.pop(context);
    } else {
      snackbar(context, "something went wrong");
    }
    return resp;
  }
}
