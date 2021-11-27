import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:vihaanelectrix/repo/api_calling.dart';
import 'package:vihaanelectrix/repo/api_urls.dart';
import 'package:vihaanelectrix/widgets/snackbar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class UserRegistrationController extends ControllerMVC {
  TextEditingController nameTf = TextEditingController();
  String? name;
  File? profilepic;
  String? imageLink = "";
  String? location;
  String? address;
  UserRegistrationController? userRegistrationModel;

  // UserRegistrationController() {
  //   userRegistrationModel = UserRegistrationModel() as UserRegistrationController?;
  // }

  Future<void> profilePic() async {
    try {
      final image = await ImagePicker().pickImage(
        source: ImageSource.camera,
        imageQuality: 20,
        preferredCameraDevice: CameraDevice.front,
      );
      final profilepicTemp = File(image!.path);
      profilepic = profilepicTemp;
      setState(() {});
      // WidgetsBinding.instance!.addPostFrameCallback((_) => setState(() {}));
    } on PlatformException catch (e) {
      log(e.toString());
    }
  }

  Future<void> uploadimage() async {
    if (profilepic == null) return;
    var postImageRef = FirebaseStorage.instance.ref().child('ProfilePic');
    UploadTask uploadTask = postImageRef
        .child(DateTime.now().toString() + ".jpg")
        .putFile(profilepic!);
    log(uploadTask.toString());
    var imageUrl = await (await uploadTask).ref.getDownloadURL();
    imageLink = imageUrl.toString();
    log(imageLink.toString());
  }

  Future<Position> getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future<void> getAddressFromLatLong(Position position) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    log(placemarks.toString());
    Placemark place = placemarks[0];
    address =
        '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
    setState(() {});
  }

  createUser(BuildContext context) async {
    await uploadimage();
    Position position = await getGeoLocationPosition();
    dynamic deviceToken = await FirebaseMessaging.instance.getToken();
    var body = {
      "name": name.toString(),
      "uId": API.uid.toString(),
      "mobile": '8330933883'.toString(),
      "pic": imageLink.toString(),
      "deviceToken": deviceToken.toString(),
      "coordinates.0": position.latitude.toString(),
      "coordinates.1": position.longitude.toString(),
    };
    log(body.toString());
    var resp = await Server().postMethod(API.newUser, body).catchError((e) {
      log(e.toString());
    });
    log("respss ${resp.statusCode}");
    log("response ${resp.body}");
    if (resp.statusCode == 200) {
      snackbar(context, "Registration successfull");
      // await Navigator.pushAndRemoveUntil(context,
      //     MaterialPageRoute(builder: (_) => GoogleNavBar()), (route) => false);
    } else {
      snackbar(context, "something went wrong");
    }
    return resp;
  }
}
