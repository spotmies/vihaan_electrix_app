import 'package:flutter/material.dart';
import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:vihaanelectrix/providers/user_details_provider.dart';
import 'package:vihaanelectrix/repo/api_calls.dart';
import 'package:vihaanelectrix/repo/api_urls.dart';
import 'package:vihaanelectrix/utilities/shared_preference.dart';
import 'package:vihaanelectrix/views/venroute/venroute.dart';
import 'package:vihaanelectrix/views/venergy/venergy.dart';
import 'package:vihaanelectrix/views/vequipment/vequipment.dart';
import 'package:vihaanelectrix/views/veasy/veasy.dart';
import 'package:vihaanelectrix/views/home/home.dart';
import 'package:vihaanelectrix/widgets/app_config.dart';
import 'package:provider/provider.dart';

class NavigationBar extends StatefulWidget {
  const NavigationBar({Key? key}) : super(key: key);

  @override
  _NavigationBarState createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {
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

  recieveData() async {
    dynamic user = await getMyuserDetails();

    if (user != null) profileProvider!.setUser(user);
  }

  hitAPIS(uuId) async {
    dynamic user = await getUserDetailsFromDB(uuId);

    if (user != null) {
      profileProvider!.setUser(user);
    }
  }

  @override
  void initState() {
    hitAPIS(API.uid);
    recieveData();

    profileProvider = Provider.of<UserDetailsProvider>(context, listen: false);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
