import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:vihaanelectrix/providers/common_provider.dart';
import 'package:vihaanelectrix/providers/user_details_provider.dart';
import 'package:vihaanelectrix/repo/api_calls.dart';
import 'package:vihaanelectrix/views/home/user_profile.dart';
import 'package:provider/provider.dart';
import 'package:vihaanelectrix/views/vequipment/cart.dart';
import 'package:vihaanelectrix/views/vequipment/wishlist.dart';
import 'package:vihaanelectrix/widgets/app_config.dart';
import 'package:vihaanelectrix/widgets/image_wid.dart';
import 'package:vihaanelectrix/widgets/text_wid.dart';

class NavigationDrawerWidget extends StatefulWidget {
  const NavigationDrawerWidget({Key? key}) : super(key: key);

  @override
  State<NavigationDrawerWidget> createState() => _NavigationDrawerWidgetState();
}

class _NavigationDrawerWidgetState extends State<NavigationDrawerWidget> {
  final padding = EdgeInsets.symmetric(horizontal: 20);
  UserDetailsProvider? profileProvider;
  // DrawerControl? drawerControl;
  CommonProvider? co;

  @override
  void initState() {
    profileProvider = Provider.of<UserDetailsProvider>(context, listen: false);
    co = Provider.of<CommonProvider>(context, listen: false);
    co?.setCurrentConstants("profile");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // log(drawerControl?.dummy.toString());
    return Drawer(
      child: Scaffold(
        // key: drawerControl?.scaffoldkey,
        backgroundColor: Colors.white,
        body: Consumer<UserDetailsProvider>(builder: (context, data, child) {
          var u = data.getUser;
          log(u.toString());
          return ListView(
            children: <Widget>[
              buildHeader(
                urlImage: u['pic'],
                name: u['name'],
                mobile: u['mobile'].toString(),
                onClicked: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => UserPage(
                      name: u['name'],
                      urlImage: u['pic'],
                    ),
                  ));
                },
              ),
              Container(
                padding: padding,
                child: Column(
                  children: [
                    buildMenuItem(
                      text: co?.getText("my_order"),
                      icon: Icons.shopping_basket,
                      onClicked: () => selectedItem(context, 0),
                    ),
                    SizedBox(height: height(context) * 0.02),
                    buildMenuItem(
                      text: co?.getText("favorites"),
                      icon: Icons.favorite,
                      onClicked: () => selectedItem(context, 1),
                      items: u['wishList'].length,
                    ),
                    SizedBox(height: height(context) * 0.02),
                    buildMenuItem(
                      text: co?.getText("cart"),
                      icon: Icons.shopping_bag,
                      onClicked: () => selectedItem(context, 2),
                      items: u['cart'].length,
                    ),
                    SizedBox(height: height(context) * 0.02),
                    buildMenuItem(
                      text: co?.getText("privacy_policies"),
                      icon: Icons.security,
                      onClicked: () => selectedItem(context, 3),
                    ),
                    SizedBox(height: height(context) * 0.02),
                    buildMenuItem(
                      text: co?.getText("help"),
                      icon: Icons.help,
                      onClicked: () => selectedItem(context, 4),
                    ),
                    SizedBox(height: height(context) * 0.035),
                    Divider(color: Colors.grey[400]),
                    SizedBox(height: height(context) * 0.035),
                    buildMenuItem(
                      text: co?.getText("edit_profile"),
                      icon: Icons.edit,
                      onClicked: () => selectedItem(context, 5),
                    ),
                    SizedBox(height: height(context) * 0.02),
                    buildMenuItem(
                      text: co?.getText("sign_out"),
                      icon: Icons.logout,
                      onClicked: () => selectedItem(context, 6),
                    ),
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget buildHeader({
    required String urlImage,
    required String name,
    required String mobile,
    required VoidCallback onClicked,
  }) =>
      InkWell(
        onTap: onClicked,
        child: Container(
          padding: padding.add(EdgeInsets.symmetric(vertical: 40)),
          child: Row(
            children: [
              ImageWid(profile: urlImage, name: name),

              SizedBox(width: width(context) * 0.08),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: width(context) * 0.3,
                    child: TextWidget(
                        text: name.toUpperCase(),
                        size: width(context) * 0.05,
                        weight: FontWeight.w600,
                        color: Colors.grey[900]),
                  ),
                  SizedBox(height: height(context) * 0.01),
                  TextWidget(
                      text: mobile,
                      size: width(context) * 0.035,
                      color: Colors.grey[900]),
                ],
              ),
              // Spacer(),
              // CircleAvatar(
              //   radius: 24,
              //   backgroundColor: Color.fromRGBO(30, 60, 168, 1),
              //   child: Icon(Icons.add_comment_outlined, color: Colors.white),
              // )
            ],
          ),
        ),
      );

  Widget buildMenuItem({
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
    int? items,
  }) {
    var color = Colors.grey[900]!;
    const hoverColor = Colors.white70;

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(text, style: TextStyle(color: color)),
      hoverColor: hoverColor,
      trailing: items == null
          ? null
          : CircleAvatar(
              radius: width(context) * 0.03,
              backgroundColor: Colors.grey[200],
              child: TextWidget(
                text: '$items',
                weight: FontWeight.w600,
                size: width(context) * 0.04,
              ),
            ),
      onTap: onClicked,
    );
  }

  void selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop();

    switch (index) {
      case 0:
        log('My Orders');
        break;
      case 1:
        log('Favourites');
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => WishList()));
        break;
      case 2:
        log('Cart');
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => CartList()));
        break;
      case 3:
        log('Privacy Policies');
        break;
      case 4:
        log('Help');
        break;
      case 5:
        log('Edit Profile');
        break;
      case 6:
        signout(context);
        break;
    }
  }
}
