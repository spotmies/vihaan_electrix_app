import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vihaanelectrix/views/home/profile_drawer.dart';
import 'package:vihaanelectrix/widgets/text_wid.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      drawer: NavigationDrawerWidget(),
      appBar: homeScreenAppBar(context),
      body: Center(
        child: Text('Home'),
      ),
    );
  }
}

homeScreenAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: Colors.indigo[900],
    elevation: 1,
    title: TextWidget(
      text: 'Home',
      color: Colors.grey[50],
      size: 20,
      weight: FontWeight.w600,
    ),
  );
}

homeScreenDrawer(BuildContext context) {
  return SafeArea(
    child: Drawer(
        child: ListView(children: <Widget>[
      DrawerHeader(
        child: Text('Drawer Header'),
        decoration: BoxDecoration(
          color: Colors.blue,
        ),
      ),
      ListTile(
        title: Text('Item 1'),
        onTap: () {
          Navigator.pop(context);
        },
      ),
      ListTile(
        title: Text('Item 2'),
      ),
    ])),
  );
}
