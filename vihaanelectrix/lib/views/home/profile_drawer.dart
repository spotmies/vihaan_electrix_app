import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vihaanelectrix/providers/user_details_provider.dart';
import 'package:vihaanelectrix/repo/api_calls.dart';
import 'package:vihaanelectrix/views/home/user_profile.dart';
import 'package:provider/provider.dart';
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

  @override
  void initState() {
    profileProvider = Provider.of<UserDetailsProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: Colors.indigo[900],
        child: Consumer<UserDetailsProvider>(builder: (context, data, child) {
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
                      text: 'My Orders',
                      icon: Icons.shopping_basket,
                      onClicked: () => selectedItem(context, 0),
                    ),
                    SizedBox(height: height(context) * 0.02),
                    buildMenuItem(
                      text: 'Favourites',
                      icon: Icons.favorite,
                      onClicked: () => selectedItem(context, 1),
                    ),
                    SizedBox(height: height(context) * 0.02),
                    buildMenuItem(
                      text: 'Cart',
                      icon: Icons.shopping_cart,
                      onClicked: () => selectedItem(context, 2),
                    ),
                    SizedBox(height: height(context) * 0.02),
                    buildMenuItem(
                      text: 'Privacy Policies',
                      icon: Icons.security,
                      onClicked: () => selectedItem(context, 3),
                    ),
                    SizedBox(height: height(context) * 0.02),
                    buildMenuItem(
                      text: 'Help',
                      icon: Icons.help,
                      onClicked: () => selectedItem(context, 4),
                    ),
                    SizedBox(height: height(context) * 0.035),
                    Divider(color: Colors.white70),
                    SizedBox(height: height(context) * 0.035),
                    buildMenuItem(
                      text: 'Edit Profile',
                      icon: Icons.edit,
                      onClicked: () => selectedItem(context, 5),
                    ),
                    SizedBox(height: height(context) * 0.02),
                    buildMenuItem(
                      text: 'Sign out',
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
                        color: Colors.white),
                  ),
                  SizedBox(height: height(context) * 0.01),
                  TextWidget(
                      text: mobile,
                      size: width(context) * 0.035,
                      color: Colors.white),
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
  }) {
    const color = Colors.white;
    const hoverColor = Colors.white70;

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(text, style: TextStyle(color: color)),
      hoverColor: hoverColor,
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
        break;
      case 2:
        log('Cart');
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
