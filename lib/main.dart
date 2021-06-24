// import 'package:elasticsearch_project/PDF_Screens/pdf_creator_screen.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'AdobeInternTeam.dart';
import 'FilePick_and_Upload.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Snippet',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Smart Snippet'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    );
    _animationController.forward();
    _animationController.repeat(reverse: true);
    _animationController.addListener(() {
      setState(() {});
    });
  }

  void _incrementCounter() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FilePickerElasticSearch()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.deepPurple,
        actions: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: IconButton(
              icon: Icon(Icons.person),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AdobeInternTeam()),
                );
              },
            ),
          )
        ],
      ),
      body: Container(
        color: Colors.deepPurple,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 2,
              child: Container(
                margin: EdgeInsets.only(top: _animationController.value * 60),
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Image.asset('assets/botpng.png'),
                ),
              ),
            ),
            Expanded(
              child: Container(
                  child: Column(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30)),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  'Smart',
                                  style: TextStyle(
                                      fontFamily: 'Lato',
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.10),
                                ),
                                DefaultTextStyle(
                                  style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              .12,
                                      color: Colors.black,
                                      fontFamily: 'Lobster'),
                                  child: AnimatedTextKit(
                                      repeatForever: true,
                                      animatedTexts: [
                                        RotateAnimatedText(' Snippet'),
                                        RotateAnimatedText(' Translator'),
                                        RotateAnimatedText(' Robot'),
                                      ]),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(10.0),
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.white),
                                  foregroundColor:
                                      MaterialStateProperty.all(Colors.black),
                                  overlayColor: MaterialStateProperty.all(
                                      Colors.deepPurple),
                                  shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20))),
                                ),
                                child: Text("Click Here"),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AdobeInternTeam(),
                                    ),
                                  );
                                },
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(10.0),
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.white),
                                  foregroundColor:
                                      MaterialStateProperty.all(Colors.black),
                                  overlayColor: MaterialStateProperty.all(
                                    Colors.deepPurple,
                                  ),
                                  shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20))),
                                ),
                                child: Text("Click Here "),
                                onPressed: _incrementCounter,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  color: Colors.deepPurple),
            ),
          ],
        ),
      ),
    );
  }
}
