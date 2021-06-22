// import 'package:elasticsearch_project/PDF_Screens/pdf_creator_screen.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'FilePick_and_Upload.dart';
import 'AdobeBertModel.dart';

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
        backgroundColor: Colors.grey,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: IconButton(
              icon: Icon(Icons.person),
              onPressed: () {},
            ),
          )
        ],
      ),
      body: Container(
        color: Colors.deepPurple,
        child: Column(
          children: [
            Expanded(
                child: Container(
                    child: Container(
              child: Image.asset('assets/botpng.png'),
            ))),
            Expanded(
              child: Container(
                child: Container(
                    // child: ElevatedButton(
                    //   child: Text("click Here"),
                    //   onPressed: () async {
                    //     // String answerData = await requestBertModel();
                    //     print(answerData);
                    //   },
                    // ),
                    color: Colors.white),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: "Question Answer",
        elevation: 5,
        child: Icon(Icons.question_answer),
      ),
    );
  }
}
