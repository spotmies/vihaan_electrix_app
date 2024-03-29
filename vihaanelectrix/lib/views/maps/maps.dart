import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vihaanelectrix/providers/location_provider.dart';
import 'package:vihaanelectrix/utilities/addressExtractor.dart';
import 'package:vihaanelectrix/widgets/app_config.dart';
import 'package:vihaanelectrix/widgets/elevated_widget.dart';
import 'package:vihaanelectrix/widgets/snackbar.dart';
import 'package:vihaanelectrix/widgets/text_wid.dart';
import 'package:geocoding/geocoding.dart';
import 'package:provider/provider.dart';

class Maps extends StatefulWidget {
  final Map? coordinates;
  final bool? isNavigate;
  final bool? isSearch;
  final Function? onSave;
  final bool? popBackTwice;
  final String? actionLabel;
  // final AdController addresscontroller;
  const Maps(
      {Key? key,
      this.coordinates,
      this.isNavigate = true,
      this.isSearch = true,
      this.onSave,
      this.popBackTwice = false,
      this.actionLabel = "save"
      // this.addresscontroller
      })
      : super(key: key);
  @override
  // ignore: no_logic_in_create_state
  _MapsState createState() => _MapsState(coordinates);
}

class _MapsState extends State<Maps> {
  TextEditingController searchController = TextEditingController();

  Map? coordinates;
  _MapsState(this.coordinates);
  GlobalKey? formkey = GlobalKey<FormState>();
  GlobalKey? scaffoldkey = GlobalKey<ScaffoldState>();
  GoogleMapController? googleMapController;
  Map<String, double> generatedCoordinates = {"lat": 20.00, "log": 80.00};
  Position? position;
  double? lat;
  double? long;
  String? addressline;
  dynamic generatedAddress;
  Map<MarkerId, Marker>? markers = <MarkerId, Marker>{};
  void getmarker(double lat, double long) {
    MarkerId markerId = MarkerId(lat.toString() + long.toString());
    Marker _marker = Marker(
        markerId: markerId,
        position: LatLng(lat, long),
        onTap: () async {
          final coordinated = coordinates!.isEmpty
              ? LatLng(position!.latitude, position!.longitude)
              : LatLng(coordinates!['latitude'], coordinates!['logitude']);
          var address = await placemarkFromCoordinates(
              coordinated.latitude, coordinated.longitude);
          log(address.first.toString());

          var firstAddress = address.first;

          setState(() {
            lat = coordinates!.isEmpty
                ? position!.latitude
                : coordinates!['latitude'];
            long = coordinates!.isEmpty
                ? position!.latitude
                : coordinates!['logitude'];
            addressline = firstAddress as String;
          });
          coordinates!.isEmpty
              ? bottomAddressSheet(
                  position!.latitude,
                  position!.longitude,
                )
              : bottomAddressSheet(
                  coordinates!['latitude'],
                  coordinates!['logitude'],
                );
        },
        draggable: true,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        infoWindow: InfoWindow(snippet: 'Address'));
    setState(() {
      markers![markerId] = _marker;
    });
  }

  void getCurrentLocation() async {
    Position currentPosition =
        await GeolocatorPlatform.instance.getCurrentPosition();
    setState(() {
      position = currentPosition;
    });
  }

  LocationProvider? locationProvider;

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
    locationProvider = Provider.of<LocationProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    if (position == null) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return Scaffold(
      key: scaffoldkey,
      resizeToAvoidBottomInset: false,
      body: SizedBox(
        child: Stack(alignment: Alignment.topCenter, children: [
          GoogleMap(
            onTap: (tapped) async {
              final coordinated = LatLng(tapped.latitude, tapped.longitude);
              var address = await placemarkFromCoordinates(
                  coordinated.latitude, coordinated.longitude);
              log(address.first.toString());
              generatedAddress = addressExtractor2(address.first);
              String firstAddress = address.first.street.toString();
              if (markers!.isNotEmpty) markers!.clear();
              if (markers!.isEmpty) {
                getmarker(tapped.latitude, tapped.longitude);
              }

              setState(() {
                lat = tapped.latitude;
                long = tapped.longitude;
                // ignore: unnecessary_cast
                addressline = firstAddress as String;
              });
              bottomAddressSheet(
                lat!,
                long!,
              );
            },
            // mapType: MapType.satellite,

            buildingsEnabled: true,
            compassEnabled: false,
            trafficEnabled: true,
            myLocationButtonEnabled: true,

            onMapCreated: (GoogleMapController controller) {
              setState(() {
                googleMapController = controller;
              });
            },
            initialCameraPosition: CameraPosition(
                target: coordinates != null
                    ? navigateMaps(
                        coordinates!['latitude'], coordinates!['logitude'])
                    //LatLng(coordinates['latitude'], coordinates['logitude'])
                    : navigateMaps(position!.latitude, position!.longitude),
                zoom: 17),
            markers: Set<Marker>.of(markers!.values),
          ),
          if (widget.isSearch!)
            Positioned(
                top: height(context) * 0.07,
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: EdgeInsets.only(
                        left: width(context) * 0.05,
                        right: width(context) * 0.03),
                    height: height(context) * 0.07,
                    width: width(context) * 0.9,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey[300]!,
                              blurRadius: 5,
                              spreadRadius: 3)
                        ],
                        borderRadius: BorderRadius.circular(15)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextWidget(
                          text: 'Search',
                          size: width(context) * 0.05,
                          color: Colors.grey[500],
                        ),
                        Icon(
                          Icons.search,
                          color: Colors.grey[500],
                        ),
                      ],
                    ),
                  ),
                ))
        ]),
      ),
    );
  }

  navigateMaps(lati, logi) {
    // if (markers.isNotEmpty) markers.clear();
    if (markers!.isEmpty) getmarker(lati, logi);
    return LatLng(lati, logi);
  }

  @override
  void dispose() {
    super.dispose();
  }

  bottomAddressSheet(
    double? lat,
    double? long,
  ) {
    final hight = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    generatedCoordinates['lat'] = lat!;
    generatedCoordinates['log'] = long!;
    showModalBottomSheet(
        context: context,
        elevation: 22,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        builder: (BuildContext context) {
          return SizedBox(
            height: hight * 0.35,
            child: Column(
              children: [
                Container(
                  height: hight * 0.27,
                  padding: EdgeInsets.all(width * 0.05),
                  child: ListView(
                    children: [
                      TextWidget(
                        text: 'Your Address:',
                        size: width * 0.06,
                        weight: FontWeight.w600,
                        flow: TextOverflow.visible,
                      ),
                      SizedBox(
                        height: hight * 0.01,
                      ),
                      TextWidget(
                        text: addressline,
                        size: width * 0.055,
                        weight: FontWeight.w600,
                        flow: TextOverflow.visible,
                        color: Colors.grey[700],
                      ),
                      TextWidget(
                        text: lat.toString() + ", " + long.toString(),
                        size: width * 0.055,
                        weight: FontWeight.w600,
                        flow: TextOverflow.visible,
                        color: Colors.grey[700],
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButtonWidget(
                      minWidth: width * 0.3,
                      height: hight * 0.05,
                      bgColor: Colors.indigo[50],
                      buttonName: 'Close',
                      textColor: Colors.grey[900],
                      borderRadius: 15.0,
                      textSize: width * 0.04,
                      leadingIcon: Icon(
                        Icons.clear,
                        size: width * 0.04,
                        color: Colors.grey[900],
                      ),
                      borderSideColor: Colors.indigo[50],
                      onClick: () {
                        Navigator.pop(context);
                      },
                    ),
                    widget.isNavigate == true
                        ? ElevatedButtonWidget(
                            minWidth: width * 0.5,
                            height: hight * 0.05,
                            bgColor: Colors.indigo[900],
                            onClick: () async {
                              try {
                                launch(
                                    'https://www.google.com/maps/search/?api=1&query=$lat,$long');
                              } catch (e) {
                                snackbar(context, "something went worng");
                              }
                            },
                            buttonName: 'Navigate',
                            textColor: Colors.white,
                            borderRadius: 15.0,
                            textSize: width * 0.04,
                            trailingIcon: Icon(
                              Icons.near_me,
                              size: width * 0.03,
                              color: Colors.white,
                            ),
                            borderSideColor: Colors.indigo[900],
                          )
                        : ElevatedButtonWidget(
                            minWidth: width * 0.5,
                            height: hight * 0.05,
                            bgColor: Colors.indigo[900],
                            onClick: () async {
                              final coordinates = {
                                'latitide': lat,
                                'longitude': long
                              };
                              // Position? position = coordinates;
                              log(coordinates.toString());
                              if (widget.onSave != null) {
                                widget.onSave!(
                                    generatedCoordinates, generatedAddress);
                                Navigator.pop(context);
                                if (widget.popBackTwice!) {
                                  Navigator.pop(context);
                                }
                              }

                              // locationProvider!.setLocation(position);
                              // log(locationProvider!.getLocation.toString());

                              // final coordinates = LatLng(lat, long);
                              // var addresses = await placemarkFromCoordinates(
                              //     coordinates.latitude, coordinates.longitude);
                              // // log(addresses.toString());
                              // Map<String, String> generatedAddress =
                              //     addressExtractor(addresses.first);
                              // log(generatedAddress.toString());
                              // if (widget.onSave == null) {
                              //   return snackbar(
                              //       context, "something went wrong");
                              // }
                              // widget.onSave!(
                              //     generatedCoordinates, generatedAddress);
                              // Navigator.pop(context);
                              // if (widget.popBackTwice!) Navigator.pop(context);
                              // setState(() {
                              //   addresscontroller.fullAddress = val;
                              // });
                              // }
                              // Navigator.of(context)
                              //     .popUntil(ModalRoute.withName("/postad"));
                            },
                            buttonName: widget.actionLabel,
                            textColor: Colors.white,
                            borderRadius: 15.0,
                            textSize: width * 0.04,
                            trailingIcon: Icon(
                              Icons.gps_fixed,
                              size: width * 0.03,
                              color: Colors.white,
                            ),
                            borderSideColor: Colors.indigo[900],
                          )
                  ],
                )
              ],
            ),
          );
        });
  }
}
