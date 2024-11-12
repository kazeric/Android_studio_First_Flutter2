import 'package:flutter/material.dart';

void main() {
  runApp(ColorSpeechApp());
}

class ColorSpeechApp extends StatefulWidget{
  @override
  _ColorSpeechAppState  createState()=> _ColorSpeechAppState();
}

//the class _ColorSpeechAppState inherits from the state class of/for ColorSpeechapp
class _ColorSpeechAppState extends State<ColorSpeechApp> {
  Color _backgroundColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: _backgroundColor,
        appBar: AppBar(
          title: Text("Color Speech Aapp"),
        ),
        body: Center(
          child:Text(
            "Tap the button and say the color!",
            style:TextStyle(fontSize: 20),
            textAlign: TextAlign.center,
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _listenForColor,
          child: Icon(Icons.mic),

        ),
      ),
    );
  }
}

void _listenForColor(){

}