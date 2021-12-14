import 'package:flutter/material.dart';
import 'package:vihaanelectrix/widgets/app_bar.dart';

class VEnergy extends StatefulWidget {
  const VEnergy({Key? key}) : super(key: key);

  @override
  _VEnergyState createState() => _VEnergyState();
}

class _VEnergyState extends State<VEnergy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
         appBar: appbar(context),
        backgroundColor: Colors.blue[50],
      body: Center(
        child: Text('VEnergy'),
      ),
    );
  }
}
