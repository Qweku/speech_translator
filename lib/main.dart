

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'package:speech_translator/launcher.dart';


List<String> testDeviceIds = ["37616A164D7CF31F7DC8708FE683E91C"];

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();


  RequestConfiguration configuration =
       RequestConfiguration(testDeviceIds: testDeviceIds);
  MobileAds.instance.updateRequestConfiguration(configuration);
  
  runApp(
     const MyApp());
}




class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  
   @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Speech_translator',
      theme: ThemeData(
        fontFamily: 'Quicksand',
        primaryColor: const Color.fromARGB(255, 2, 82, 255),
        primaryColorDark: const Color.fromARGB(255, 8, 8, 8),
        primarySwatch: Colors.blue,
      ),
      home: const Launcher(),
    );
  }
}
