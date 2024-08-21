import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:speech_to_text/speech_to_text.dart';

class My_wid extends StatefulWidget {
  const My_wid ({super.key});

  @override
  State<My_wid> createState() => _State();
}

class _State extends State<My_wid> {
  final SpeechToText _speechToText = SpeechToText();
  bool _enable = false;
  String _speechText = " ";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initSpeech();
  }

  void initSpeech() async{
    _enable = await _speechToText.initialize();
    setState(() {    });
  }

  //function for start listening to user
  void _toListen() async{
    await _speechToText.listen(onResult: _onSpeechResult );
  }
  //function for stop listening to user
  void _stopListen()  async{
      await _speechToText.stop();
      setState(() {      });
  }
  void _onSpeechResult(result){
    setState(() {
      _speechText = "${result.recognizedWords}";
    });
  }

  @override

      Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      backgroundColor: Colors.tealAccent,
      title: Text("Speech demo", style: TextStyle(
        color: Colors.white,
          ),
        ),
      ),
      body: Center(child: Column(
        children: [Container(
          padding: EdgeInsets.all(16),
          child: Text(_speechToText.isListening ? "listening..." : _enable? "Tap mic to write"
                      : "Speech not available",
                        style: TextStyle(fontSize: 20.0),
                    ),
            ),
          Expanded(
            child: Container(
            padding: EdgeInsets.all(26),
            child: Text(
                _speechText,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w200,
                ),
              ),
            ),
          )]
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: _speechToText.isListening ? _stopListen : _toListen
          tooltip: 'Listen',
          child: Icon(
            _speechToText.isNotListening ? Icons.mic_off : Icons.mic,
            color: Colors.black12,
          ),
        backgroundColor: Colors.yellow,
      ),
    );
  }
}
