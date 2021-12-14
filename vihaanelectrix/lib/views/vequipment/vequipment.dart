import 'package:flutter/material.dart';
import 'package:vihaanelectrix/widgets/app_bar.dart';

class VEquipment extends StatefulWidget {
  const VEquipment({Key? key}) : super(key: key);

  @override
  _VEquipmentState createState() => _VEquipmentState();
}

class _VEquipmentState extends State<VEquipment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
         appBar: appbar(context),
        backgroundColor: Colors.blue[50],
      body: Center(
        child: Text('VEquipment'),
      ),
    );
  }
}
