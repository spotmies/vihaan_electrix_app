// ignore_for_file: file_names

import 'dart:developer';

addressExtractor(address) {
  Map<String, String> val = {
    "subLocality": "${address.subLocality}",
    "locality": "${address.locality}",
    "latitude": "${address.coordinates.latitude}",
    "logitude": "${address.coordinates.longitude}",
    "addressLine": "${address.addressLine}",
    "subAdminArea": "${address.subAdminArea}",
    "postalCode": "${address.postalCode}",
    "adminArea": "${address.adminArea}",
    "subThoroughfare": "${address.subThoroughfare}",
    "featureName": "${address.featureName}",
    "thoroughfare": "${address.thoroughfare}",
  };
  log(val.toString());
  return val;
}
