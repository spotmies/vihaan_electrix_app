import 'package:flutter/material.dart';
import 'package:vihaanelectrix/widgets/app_config.dart';
import 'package:vihaanelectrix/widgets/text_wid.dart';

appbar(
  BuildContext context,
) {
  return AppBar(
    backgroundColor: Colors.white,
    elevation: 0,
    centerTitle: true,
    automaticallyImplyLeading: false,
    leading: IconButton(
      padding: EdgeInsets.all(width(context) * 0.045),
      icon: Image.asset(
        'assets/pngs/drawer_icon.png',
      ),
      onPressed: () {
        // log(drawerController!.dummy.toString());
        // drawerControl?.scaffoldkey?.currentState?.openDrawer();
      },
    ),
    title: Image.asset(
      'assets/pngs/vihaan_app_logo.png',
      height: height(context) * 0.1,
      width: width(context) * 0.4,
    ),
  );
}

appBarWithTitle(BuildContext context, {String? title, Color? color}) {
  return AppBar(
    backgroundColor: color ?? Colors.white,
    elevation: 0,
    leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(
          Icons.arrow_back,
          color: Colors.grey[900],
        )),
    title: TextWidget(
      text: title,
      size: width(context) * 0.06,
      color: Colors.grey[900],
      weight: FontWeight.w600,
    ),
  );
}
