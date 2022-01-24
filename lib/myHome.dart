// ignore_for_file: file_names, prefer_const_constructors, avoid_print, implementation_imports

import 'dart:io';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:speech_translator/extras/customClipper.dart';
import 'package:speech_translator/extras/textField.dart';
import 'extras/Languages.dart';
import 'package:translator/translator.dart';

class SpeechScreen extends StatefulWidget {
  const SpeechScreen({Key? key}) : super(key: key);

  @override
  _SpeechScreenState createState() => _SpeechScreenState();
}

class _SpeechScreenState extends State<SpeechScreen> {
  stt.SpeechToText _speech = stt.SpeechToText();
  FlutterTts flutterTts = FlutterTts();
  bool isListening = false;
  //String text = "Press to start speaking";
  TextEditingController textController = TextEditingController();

  _speak() async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1);
    await flutterTts.getEngines;
    await flutterTts.speak(translatedText);
  }

  void initSpeech() async {
    isListening = await _speech.initialize();
    setState(() {});
  }

  final translator = GoogleTranslator();
  String translatedText = '';
  var chosenValue = "en";
  var secondValue = 'en';

  @override
  void initState() {
    super.initState();
    initSpeech();
    textController.text = "Press to start speaking or type here";
    translatedText = textController.text;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () => _onBackPressed(context),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
          backgroundColor: Colors.grey[900],
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.red,
            title: Text('Speech Translator'),
            elevation: 0,
            centerTitle: true,
          ),
          body: Stack(
            children: [
              Column(
                children: [
                  ClipPath(
                    clipper: NewCustomClipper(),
                    child: Container(
                      color: Colors.red,
                      height: height * 0.48,
                      child: SingleChildScrollView(
                        child: Container(
                            padding: EdgeInsets.all(20),
                            child: CustomTextField(
                              //borderColor: Colors.white,
                              maxLines: 10,
                              textAlign: TextAlign.center,
                              controller: textController,
                              style: TextStyle(fontSize: 20, color: Colors.white)
                            )
                            // Text(text,
                            //     style:
                            //         TextStyle(fontSize: 20, color: Colors.white))
                            ),
                      ),
                    ),
                  ),
                 
                  
                  SizedBox(
                    height: height * 0.3,
                    child: SingleChildScrollView(
                      child: Container(
                          padding: EdgeInsets.all(20),
                          child: Text(translatedText,
                              style: TextStyle(
                                  fontSize: 20, color: Colors.white))),
                    ),
                  ),
                ],
              ),
              Container(
                alignment: Alignment(1.1, 1.3),
                child: SizedBox(
                  height: height * 0.3,
                  child: Column(children: [
                    GestureDetector(
                      onTap: () async {
                        var trans = await translator.translate(translatedText,
                            from: chosenValue, to: secondValue);
                        setState(() {
                          translatedText = trans.text;
                          //_speak();
                          chosenValue = secondValue;
                        });
                      },
                      child: CircleAvatar(
                        backgroundColor: Colors.red,
                        radius: 30,
                        child: Icon(Icons.language, color: Colors.white),
                      ),
                    ),
                    //SizedBox(height:10),
                    AvatarGlow(
                      animate: isListening,
                      glowColor: Colors.red,
                      endRadius: 60.0,
                      duration: Duration(milliseconds: 2000),
                      repeatPauseDuration: Duration(milliseconds: 100),
                      repeat: true,
                      child: GestureDetector(
                        onTap: isListening ? listen : _stopListen,
                        child: CircleAvatar(
                          backgroundColor: Colors.red,
                          radius: 30,
                          child: Icon(isListening ? Icons.mic : Icons.mic_none),
                        ),
                      ),
                    )
                  ]),
                ),
              ),
              Container(
                alignment: Alignment(0,-0.2),
                child:                  Container(
                    padding: EdgeInsets.symmetric(horizontal:height*0.02),
                    decoration: BoxDecoration(
                      borderRadius:BorderRadius.circular(20),
                      color:Colors.white
                    ),
                    child: DropdownButton(
                      iconEnabledColor: Colors.black,
                        underline: DropdownButtonHideUnderline(child: Container()),
                        value: secondValue,
                        //dropdownColor: Colors.black,
                        style: TextStyle(color: Colors.black),
                        items:
                            // ["en", "fr", "es", "it", "hi", "ja"]
                            langs.entries.map((e) {
                          return DropdownMenuItem(
                            child: Text("${e.value}(${e.key.toUpperCase()})",
                                style: TextStyle(color: Colors.black)),
                            value: e.key,
                          );
                        }).toList(),
                        onChanged: (String? value) async {
                          //translatedText = text;
                          // var trans = await translator.translate(translatedText,
                          secondValue = value
                              .toString(); //     from: chosenValue, to: value.toString());
                          setState(() {
                            //translatedText = trans.text;
                            //chosenValue = value.toString();
                          });
                        }),
                  ),
                 
              )
            ],
          )),
    );
  }

  Future<bool> _onBackPressed(BuildContext context) async {
    final theme = Theme.of(context);
    return (await showDialog<bool>(
            context: context,
            builder: (c) => AlertDialog(
                  title: Center(
                      child: Text(
                    "Warning",
                  )),
                  content: Text(
                    "Do you really want to quit?",
                  ),
                  actions: [
                    TextButton(
                        onPressed: () {
                          exit(0);
                        },
                        child: Text(
                          "Yes",
                        )),
                    TextButton(
                        onPressed: () => Navigator.pop(c, false),
                        child: Text(
                          "No",
                        ))
                  ],
                ))) ??
        false;
  }

  void listen() async {
    await _speech.listen(onResult: _onSpeechResult);
    //isListening = true;
    setState(() {});
  }

  void _stopListen() async {
    await _speech.stop();
    //isListening = false;
    setState(() {});
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      textController.text = result.recognizedWords;
      translatedText = textController.text;
    });
  }

  // void listen() async {
  //   if (!isListening) {
  //     bool available = await _speech.initialize(
  //       onStatus: (val) => print('onStatus: $val'),
  //       onError: (val) => print('onError: $val'),
  //     );

  //     if (available) {
  //       setState(() {
  //         isListening = true;
  //       });
  //       _speech.listen(
  //         onResult: (val) => setState(() {
  //           text = val.recognizedWords;
  //           //_speak();
  //         }),
  //       );
  //     }
  //   } else {
  //     return setState(() {
  //       isListening = false;
  //       print('T H I S  B O O L  I S  $isListening');
  //       _speech.stop();
  //       //_speak();
  //     });
  //   }
  // }

}
