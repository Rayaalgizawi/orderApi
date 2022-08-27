import 'package:beauty_pariour2/screens/Profile/maincontanainer/main_contanainer_dart.dart';
import 'package:beauty_pariour2/utilts/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  var widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  logErrorMessage('Application Started');
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Firebase.app();
  await MobileAds.instance.initialize();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  void initState() {
    super.initState();

    FlutterNativeSplash.remove();
  }

  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Cosmetics',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        splashColor: Colors.blue,
        highlightColor: Colors.transparent,
      ),
      home: const MainContanainerDart(),
    );
  }
}
