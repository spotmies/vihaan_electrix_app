import 'package:flutter/material.dart';
import 'package:vihaanelectrix/controllers/venroute/testride.dart';
import 'package:vihaanelectrix/views/venroute/test_ride.dart';

class VEnroute extends StatefulWidget {
  const VEnroute({Key? key}) : super(key: key);

  @override
  _VEnrouteState createState() => _VEnrouteState();
}

TestRideController testRideController = TestRideController();

class _VEnrouteState extends State<VEnroute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Enroute'),
        ),
        body: TestRideBooking());
  }
}
