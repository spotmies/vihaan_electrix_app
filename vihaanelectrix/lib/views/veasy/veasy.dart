import 'package:flutter/material.dart';
import 'package:vihaanelectrix/widgets/app_bar.dart';

class VEASY extends StatefulWidget {
  const VEASY({ Key? key }) : super(key: key);

  @override
  _VEASYState createState() => _VEASYState();
}

class _VEASYState extends State<VEASY> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(context),
        backgroundColor: Colors.blue[50],
      body: Center(
        child: Text('VEASY'),
      ),
    );
  }
}