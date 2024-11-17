import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:flutter_tts/flutter_tts.dart';

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
  stt.SpeechToText _speech = stt.SpeechToText();
  bool _isListening = false;
  FlutterTts _tts = FlutterTts();


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
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: AvatarGlow(
          animate: _isListening,
          glowColor: Theme.of(context).primaryColor,
          duration: const Duration(milliseconds: 2000),
          repeat: true,
          child: FloatingActionButton(
          onPressed: (){
            _listenForColor();
            print("Button pressed, starting listening...");

          },
          child: Icon(_isListening ? Icons.mic : Icons.mic_none),

        ),
        ),
      ),
    );
  }
// function to set color
  void _setColor(String colorName) {
    Color? newColor = colorMap[colorName.toLowerCase()];
    if (newColor != null){
      setState(() {
        _backgroundColor = newColor;
      });
      _speak('The color is $colorName');
    }else{
      _speak("Color not recognized. Please try again");
    }
  }


  @override
  void initState(){
    super.initState();
    _speech = stt.SpeechToText();

  }

  void _listenForColor() async{
    //by default the app isnt listening
    //so we need to check if is listening is true
    if(!_isListening){
      print("listening");
      //now if it is false then we initialise the speech once this function is called
      bool available = await _speech.initialize();
      // once it returns an ok then we can go on and collect the the data from the speech
      if(available) {
        //first tell every function that speech is happening, Maybe to avoid clashes with other asyncs
        setState((){_isListening = true;});

        //this is where we collect the result once done and
        _speech.listen(onResult: (result){
          setState(() {
            _isListening = false;
            String colorName = result.recognizedWords;
            _setColor(colorName);
          });

        },
            listenFor: Duration(seconds: 10)
        );

      }
    }else {
      _speech.stop();
      print("hit the else");
      setState(() => _isListening = false);
    }


  }

  void _speak(String text) async {
    await _tts.speak(text);
  }

  final Map<String, Color> colorMap = {
    "red": Colors.red,
    'green': Colors.green,
    'yellow': Colors.yellow,
    'black': Colors.black,
    'white': Colors.white,
    'purple': Colors.purple,
    'orange': Colors.orange,

  };


}


