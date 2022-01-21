// ignore_for_file: file_names, prefer_const_constructors, avoid_print

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class SpeechScreen extends StatefulWidget {
  const SpeechScreen({Key? key}) : super(key: key);

  @override
  _SpeechScreenState createState() => _SpeechScreenState();
}

class _SpeechScreenState extends State<SpeechScreen> {
  late stt.SpeechToText _speech;
  FlutterTts flutterTts = FlutterTts();
  bool isListening = false;
  String text = "Press to start speaking";

  _speak() async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1);
    await flutterTts.speak(text);
  }

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Flutter Voice'),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: AvatarGlow(
          animate: isListening,
          glowColor: Theme.of(context).primaryColor,
          endRadius: 75.0,
          duration: Duration(milliseconds: 2000),
          repeatPauseDuration: Duration(milliseconds: 100),
          repeat: true,
          child: FloatingActionButton(
            onPressed: () {
              listen();
            },
            child: Icon(isListening ? Icons.mic : Icons.mic_none),
          ),
        ),
        body: Column(
          children: [
            SingleChildScrollView(
              child: Container(
                  padding: EdgeInsets.all(20),
                  child: Text(text,
                      style: TextStyle(fontSize: 20, color: Colors.black))),
            ),
          Divider(color: Colors.grey,),
         
          ],
        ));
  }

  void listen() async {
    if (!isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );

      if (available) {
        setState(() {
          isListening = true;
        });
        _speech.listen(
          onResult: (val) => setState(() {
            text = val.recognizedWords;
            //_speak();
          }),
        );
      }
    } else {     
      return setState(() {
          isListening = false;
          print('T H I S  B O O L  I S  $isListening');
          _speech.stop();
          _speak();
        });
      
    }
  }
}
