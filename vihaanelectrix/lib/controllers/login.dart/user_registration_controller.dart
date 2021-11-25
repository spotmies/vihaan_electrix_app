import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UserRegistrationController extends ControllerMVC {
  TextEditingController nameTf = TextEditingController();
  String? name;
  File? profilepic;
  String? imageLink = "";

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
      setState(() { });
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
  }
}
