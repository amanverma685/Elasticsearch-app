import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class ViewContext extends StatefulWidget {
  const ViewContext({Key key, @required this.text, this.text1})
      : super(key: key);
  final String text;
  final String text1;

  @override
  _ViewContextState createState() => _ViewContextState();
}

class _ViewContextState extends State<ViewContext> {
  final flutterTts = FlutterTts();

  void speak() async {
    String text = widget.text;
    await flutterTts.speak(text);
  }

  void stopSpeak() async {
    await flutterTts.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        actions: [
          IconButton(onPressed: speak, icon: Icon(Icons.speaker)),
          IconButton(onPressed: stopSpeak, icon: Icon(Icons.stop))
        ],
        backgroundColor: Colors.deepPurple,
        title: Text("Find Your Answer"),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                "Here you can find the Context",
                style: TextStyle(fontSize: 30, fontFamily: 'Lobster'),
              ),
              Divider(height: 10, color: Colors.purple, thickness: 2),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "${widget.text}",
                  maxLines: null,
                  style: TextStyle(fontSize: 20),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
