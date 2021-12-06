import 'package:flutter/material.dart';
import 'package:vihaanelectrix/widgets/app_config.dart';
import 'package:vihaanelectrix/widgets/text_wid.dart';

loginHeader(BuildContext context) {
  return Container(
      height: height(context) * 0.275,
      width: width(context),
      padding: EdgeInsets.only(
          left: width(context) * 0.05, right: width(context) * 0.02),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextWidget(
              text: "Welcome",
              size: height(context) * 0.05,
              weight: FontWeight.bold,
              color: Colors.indigo[900],
            ),
            SizedBox(
              height: height(context) * 0.01,
            ),
            TextWidget(
              text: "Improve the world through EV",
              size: height(context) * 0.02,
              weight: FontWeight.w500,
              color: Colors.grey[900],
            )
          ],
        ),
        Image.asset(
          'assets/pngs/velogo.png',
          height: height(context) * 0.12,
          width: width(context) * 0.3,
        ),
      ]));
}

loginBackgroundTemp(BuildContext context) {
  return Column(
    children: [
      Container(
        height: height(context) * 0.17,
        width: width(context),
        decoration: BoxDecoration(
          color: Colors.white,
        ),
      ),
      ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft:
                Radius.elliptical(width(context) * 0.5, height(context) * 0.15),
            topRight: Radius.elliptical(
                width(context) * 0.5, height(context) * 0.15)),
        child: Container(
          height: height(context) * 0.68,
          width: width(context),
          decoration: BoxDecoration(
            color: Colors.grey[100],
          ),
        ),
      ),
    ],
  );
}
