import 'package:elasticsearch_project/PDF_Screens/pdf_creator_screen.dart';
import 'package:flutter/material.dart';

import 'filePicker.dart';

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

class _MyHomePageState extends State<MyHomePage> {
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
        backgroundColor: Colors.red[600],
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              icon: Icon(Icons.person),
              onPressed: () {},
            ),
          )
        ],
      ),
      body: Container(
        color: Colors.red[500],
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 6,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.red[500],
                    ),
                    borderRadius:
                        BorderRadius.only(bottomLeft: Radius.circular(50))),
                child: Image.asset('assets/botpng.png'),
              ),
            ),
            Expanded(
              flex: 4,
              child: Container(
                color: Colors.white,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.red[500],
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(50),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.question_answer),
      ),
    );
  }
}
