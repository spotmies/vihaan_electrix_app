import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:vihaanelectrix/providers/location_provider.dart';
import 'package:vihaanelectrix/providers/product_details_provider.dart';
import 'package:vihaanelectrix/providers/user_details_provider.dart';
import 'package:vihaanelectrix/repo/api_calls.dart';
import 'package:vihaanelectrix/utilities/shared_preference.dart';
import 'package:vihaanelectrix/views/venroute/venroute.dart';
import 'package:vihaanelectrix/views/venergy/venergy.dart';
import 'package:vihaanelectrix/views/vequipment/vequipment.dart';
import 'package:vihaanelectrix/views/veasy/veasy.dart';
import 'package:vihaanelectrix/views/home/home.dart';
import 'package:vihaanelectrix/widgets/app_config.dart';
import 'package:provider/provider.dart';
// import 'package:vihaanelectrix/widgets/geo_position.dart';
// import 'package:geolocator/geolocator.dart';

class NavigationBarWidget extends StatefulWidget {
  const NavigationBarWidget({Key? key}) : super(key: key);

  @override
  _NavigationBarWidgetState createState() => _NavigationBarWidgetState();
}

class _NavigationBarWidgetState extends State<NavigationBarWidget> {
  var bottomNavIndex = 2;
  static List<Widget> widgetOptions = <Widget>[
    Center(
      child: VEnroute(),
    ),
    Center(
      child: VEnergy(),
    ),
    Center(
      child: Home(),
    ),
    Center(
      child: VEquipment(),
    ),
    Center(
      child: VEASY(),
    ),
  ];
  List icons = <IconData>[
    Icons.electric_moped,
    Icons.shopping_cart,
    Icons.home,
    Icons.electrical_services,
    Icons.miscellaneous_services,
  ];

  UserDetailsProvider? profileProvider;
  ProductDetailsProvider? productDetailsProvider;
  LocationProvider? locationProvider;

  recieveData() async {
    dynamic user = await getMyuserDetails();

    if (user != null) profileProvider!.setUser(user);
  }

  hitAPIS() async {
    dynamic user = await getUserDetailsFromDB();
    dynamic products = await getProductDetailsFromDB();
    // Position? position = await getGeoLocationPosition();
    // log(position.toString());

    if (user != null && products != null) {
      profileProvider!.setUser(user);
      productDetailsProvider!.setProduct(products);
      log(user.toString());
      log(products.toString());
      if (user['appConfig'] == "true") {
        log("fetching new constatns from DB");
        constantsAPI();
      }
    } else {
      log("failed to fetch data from DB");
    }
    // locationProvider!.setLocation(position);
  }

  @override
  void initState() {
    recieveData();
    hitAPIS();

    profileProvider = Provider.of<UserDetailsProvider>(context, listen: false);
    productDetailsProvider =
        Provider.of<ProductDetailsProvider>(context, listen: false);
    locationProvider = Provider.of<LocationProvider>(context, listen: false);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // body: Consumer<LocationProvider>(builder: (context, data, child) {
        //   log('testing location:' + data.getLocation.toString());
        //   return SizedBox(
        //     // color: Colors.amber,
        //     width: double.infinity,
        //     height: double.infinity,
        //     child: widgetOptions.elementAt(bottomNavIndex),
        //   );
        // }),
        body: SizedBox(
          // color: Colors.amber,
          width: double.infinity,
          height: double.infinity,
          child: widgetOptions.elementAt(bottomNavIndex),
        ),
        bottomNavigationBar: CustomNavigationBar(
          iconSize: 30.0,
          selectedColor: Color(0xff040307),
          strokeColor: Colors.grey[100]!,
          unSelectedColor: Color(0xffacacac),
          backgroundColor: Colors.white,
          borderRadius: Radius.circular(30.0),
          // blurEffect: true,
          items: [
            CustomNavigationBarItem(
              icon: Icon(
                icons[0],
                size: width(context) * 0.07,
              ),
            ),
            CustomNavigationBarItem(
              icon: Icon(
                icons[1],
                size: width(context) * 0.07,
              ),
            ),
            CustomNavigationBarItem(
              icon: Icon(
                icons[2],
                size: width(context) * 0.07,
              ),
            ),
            CustomNavigationBarItem(
              icon: Icon(
                icons[3],
                size: width(context) * 0.07,
              ),
            ),
            CustomNavigationBarItem(
              icon: Icon(
                icons[4],
                size: width(context) * 0.07,
              ),
            )
          ],
          currentIndex: bottomNavIndex,
          onTap: (index) {
            setState(() {
              bottomNavIndex = index;
            });
          },
        ));
  }
}
