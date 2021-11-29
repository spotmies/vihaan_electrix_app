import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vihaanelectrix/providers/time_provider.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:vihaanelectrix/providers/user_details_provider.dart';
import 'package:vihaanelectrix/views/home/navbar.dart';
import 'package:vihaanelectrix/views/login/splash_creen.dart';

// Future<void> backGroundHandler(RemoteMessage message) async {
//   displayAwesomeNotificationBackground(message);
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  // awesomeInitilize();
  //FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  // FirebaseMessaging.onBackgroundMessage(backGroundHandler);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MultiProvider(providers: [
      ChangeNotifierProvider<TimeProvider>(create: (context) => TimeProvider()),
      ChangeNotifierProvider<UserDetailsProvider>(
          create: (context) => UserDetailsProvider()),
    ], child: MyApp()));
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Vihaan Electrix',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
    );
  }
}
