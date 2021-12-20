import 'package:flutter/material.dart';
import 'package:vihaanelectrix/widgets/app_config.dart';
import 'package:vihaanelectrix/widgets/text_wid.dart';

specItems(BuildContext context, String image, String text, String? spec) {
  return Container(
    height: height(context) * 0.11,
    width: width(context) * 0.22,
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey[200]!,
            blurRadius: 1.0,
            spreadRadius: 1.0,
            offset: Offset(
              0.0,
              -2.0,
            ),
          ),
          BoxShadow(
            color: Colors.grey[100]!,
            blurRadius: 10.0,
            spreadRadius: 3.0,
            offset: Offset(
              3.0,
              3.0,
            ),
          )
        ]),
    child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      SizedBox(
          height: height(context) * 0.03,
          width: width(context) * 0.15,
          child: Image.asset('assets/pngs/$image.png')),
      Column(
        children: [
          TextWidget(
            text: text,
            color: Colors.grey[900],
            size: width(context) * 0.035,
            weight: FontWeight.w600,
          ),
          TextWidget(
            text: spec,
            color: Colors.grey[900],
            size: width(context) * 0.04,
            weight: FontWeight.w500,
          )
        ],
      )
    ]),
  );
}
