import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:vihaanelectrix/widgets/app_config.dart';
import 'package:vihaanelectrix/widgets/text_wid.dart';

class ProgressWaiter extends StatelessWidget {
  final BuildContext? contextt;
  final bool? loaderState;
  final String? loadingName;
  
  const ProgressWaiter({Key? key, 
    
      this.contextt,
      this.loaderState,
      this.loadingName = "Verifying Please Wait..."}) : super(key: key);

  

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: loaderState!,
      child: Positioned.fill(
          child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 0.5, sigmaY: 0.5),
        child: AbsorbPointer(
          absorbing: loaderState!,
          child: Padding(
            padding: const EdgeInsets.only(top: 250.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  // strokeWidth: 6.0,
                  // backgroundColor: Colors.white,
                  color: Colors.indigo[900],
                ),
                Container(
                  padding: EdgeInsets.only(top: 20),
                  child: TextWidget(
                    text: loadingName,
                    color: Colors.indigo[900],
                    weight: FontWeight.bold,
                    size: width(context) * 0.06,
                  ),
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
