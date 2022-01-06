import 'dart:async';

import 'package:flutter/material.dart';
import 'package:vihaanelectrix/views/login/login_screen.dart';
import 'package:vihaanelectrix/widgets/app_config.dart';
import 'package:vihaanelectrix/widgets/elevated_widget.dart';
import 'package:vihaanelectrix/widgets/snackbar.dart';
import 'package:vihaanelectrix/widgets/text_wid.dart';

class Terms extends StatefulWidget {
  const Terms({Key? key}) : super(key: key);

  @override
  _TermsState createState() => _TermsState();
}

ScrollController scrollController = ScrollController();
bool accept = false;

step1(BuildContext context) {
  if (accept == true) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LoginScreen();
    }));
  } else {
    Timer(
        Duration(milliseconds: 100),
        () =>
            scrollController.jumpTo(scrollController.position.maxScrollExtent));

    snackbar(context, 'Need to accept all the terms & conditions');
  }
}

List terms = [
  "Vihaan Electrix not supposed to reveal or explore or share customer data to others",
  "we do not Entertain any illegal activities.if perform severe actions will be taken",
  "customers are responsible for the damages done during the testride and they bare whole forfeit",
  "we do not provide  any kind of training to perform any rides",
  "while taking test rides we will follow all the covid regulations",
];

class _TermsState extends State<Terms> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(15),
        // height: height(context) * 1,
        child: ListView.builder(
            controller: scrollController,
            itemCount: terms.length,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: [
                  if (index == 0)
                    TextWidget(
                      text: 'Terms and Conditions',
                      size: width(context) * 0.08,
                      flow: TextOverflow.visible,
                    ),
                  if (index == 0) SizedBox(height: height(context) * 0.05),
                  TextWidget(
                    text: "${index + 1}.  " + terms[index],
                    size: width(context) * 0.06,
                    flow: TextOverflow.visible,
                  ),
                  if (index != 4)
                    Divider(
                      color: Colors.grey[400],
                      indent: width(context) * 0.1,
                      endIndent: width(context) * 0.1,
                    ),
                  if (index == 4)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Checkbox(
                            activeColor: Colors.teal,
                            checkColor: Colors.white,
                            value: accept,
                            shape: CircleBorder(),
                            onChanged: (bool? value) {
                              accept = value!;
                              if (accept == true) {
                                // tca = 'accepted';
                              }
                              setState(() {});
                            }),
                        Text(
                          'I agree to accept the terms and Conditions',
                          style: TextStyle(fontSize: width(context) * 0.03),
                        ),
                      ],
                    ),
                  if (index == 4)
                    SizedBox(
                      height: height(context) * 0.2,
                    ),
                  if (index == 4)
                    Container(
                      margin: EdgeInsets.all(10),
                      alignment: Alignment.centerRight,
                      child: ElevatedButtonWidget(
                        onClick: () async {
                          step1(context);
                        },
                        height: height(context) * 0.06,
                        minWidth: width(context) * 0.33,
                        buttonName: 'Accept',
                        bgColor: Colors.indigo[900],
                        textSize: width(context) * 0.05,
                        borderRadius: 20.0,
                        allRadius: true,
                        textColor: Colors.white,
                      ),
                    )
                ],
              );
            }),
      ),
    );
  }
}
