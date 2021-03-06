import 'package:flutter/material.dart';
import 'package:speech_translator/launcher.dart';

import 'myHome.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'speech_translator',
      theme: ThemeData(
        fontFamily: 'Quicksand',
        primarySwatch: Colors.blue,
      ),
      home: const Launcher(),
    );
  }
}
