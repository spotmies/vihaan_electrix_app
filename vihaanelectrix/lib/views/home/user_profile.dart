
import 'package:flutter/material.dart';
import 'package:vihaanelectrix/widgets/app_config.dart';
import 'package:vihaanelectrix/widgets/image_wid.dart';
import 'package:vihaanelectrix/widgets/text_wid.dart';

class UserPage extends StatelessWidget {
  final String name;
  final String urlImage;

  const UserPage({
    Key? key,
    required this.name,
    required this.urlImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.indigo[900],
          title: TextWidget(
            text: name,
            color: Colors.white,
            size: width(context) * 0.07,
            weight: FontWeight.w600,
          ),
        ),
       
        body: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Container(
                  padding: EdgeInsets.only(top: 10),
                  child: ImageWid(
                    profile: urlImage,
                    name: name,
                    size: width(context) * 0.18,
                  ),
                ),
              )
            ],
          ),
        ),
      );
}
