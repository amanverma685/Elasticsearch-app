import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../AdobeBertModel.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class IndexAndAsk extends StatefulWidget {
  const IndexAndAsk({Key key}) : super(key: key);

  @override
  _IndexAndAskState createState() => _IndexAndAskState();
}

class _IndexAndAskState extends State<IndexAndAsk> {
  final flutterTts = FlutterTts();

  void speak() async {
    await flutterTts.speak(answerText);
  }

  void stopSpeak() async {
    await flutterTts.stop();
  }

  var _formFieldKey = GlobalKey<FormFieldState>();
  TextEditingController contextController = TextEditingController();
  TextEditingController questionController = TextEditingController();
  String questionContext = "";
  String answerText = "";
  String questionQuery = "";
  bool progressHUD = false;
  bool isEnabled = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          "Find your answers",
          style: TextStyle(fontFamily: 'Lobster', fontSize: 30),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Expanded(
              flex: 6,
              child: SingleChildScrollView(
                child: Container(
                  child: Form(
                    child: Column(
                      children: <Widget>[
                        Text(
                          "Please Enter your paragraph",
                          style: TextStyle(fontSize: 22),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: TextFormField(
                            key: _formFieldKey,
                            decoration: InputDecoration(
                              hoverColor: Colors.deepPurple,
                              focusColor: Colors.deepPurple,
                              fillColor: Colors.deepPurple,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            controller: contextController,
                            cursorHeight: 20,
                            maxLength: null,
                            maxLines: null,
                            keyboardType: TextInputType.multiline,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter some Context to ask questions.';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        Text(
                          "Please Enter your Question",
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            controller: questionController,
                            maxLength: null,
                            maxLines: null,
                            keyboardType: TextInputType.multiline,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter some Context to Index';
                              }
                              return null;
                            },
                          ),
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.deepPurple)),
                          onPressed: () async {
                            FocusScope.of(context)
                                .requestFocus(new FocusNode());

                            if (_formFieldKey.currentState.validate()) {
                              questionContext = questionController.text;
                              questionQuery = contextController.text;
                              final snackBar = SnackBar(
                                  duration: Duration(milliseconds: 1000),
                                  backgroundColor: Colors.deepPurple,
                                  content: Text(
                                      'Getting your answers... Please Wait...'));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                              progressHUD = true;
                              setState(() {});

                              answerText = await requestBertModel(
                                  questionContext, questionQuery);
                            }

                            progressHUD = false;
                            isEnabled = true;

                            setState(() {});
                          },
                          child: Text('Submit Context and question..'),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    Text("Speak Answer"),
                                    IconButton(
                                      icon: Icon(
                                        Icons.speaker,
                                      ),
                                      onPressed: isEnabled ? speak : null,
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Text("   Stop "),
                                    IconButton(
                                      hoverColor: Colors.deepPurple,
                                      icon: Icon(
                                        Icons.stop_circle_rounded,
                                        color: Colors.black,
                                      ),
                                      onPressed: stopSpeak,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Divider(
              height: 2,
              thickness: 3,
            ),
            Expanded(
              flex: 4,
              child: ModalProgressHUD(
                inAsyncCall: progressHUD,
                child: SingleChildScrollView(
                  child: Container(
                    child: Column(
                      children: [
                        Text(
                          "Answer",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Text(
                            answerText,
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
