import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../AdobeBertModel.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class IndexAndAsk extends StatefulWidget {
  const IndexAndAsk({Key key}) : super(key: key);

  @override
  _IndexAndAskState createState() => _IndexAndAskState();
}

class _IndexAndAskState extends State<IndexAndAsk> {
  var _formFieldKey = GlobalKey<FormFieldState>();
  TextEditingController contextController = TextEditingController();
  TextEditingController questionController = TextEditingController();
  String questionContext = "";
  String answerText = "";
  String questionQuery = "";
  bool progressHUD = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          "Find your answers",
          style: TextStyle(fontFamily: 'Lobster', fontSize: 20),
        ),
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
              child: Form(
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      key: _formFieldKey,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      controller: contextController,
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
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
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
                    ElevatedButton(
                      onPressed: () async {
                        if (_formFieldKey.currentState.validate()) {
                          questionContext = questionController.text;
                          questionQuery = contextController.text;
                          final snackBar = SnackBar(
                              backgroundColor: Colors.deepPurple,
                              content: Text(
                                  'Getting your answers... Please Wait...'));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          progressHUD = true;
                          setState(() {});

                          answerText = await requestBertModel(
                              questionContext, questionQuery);
                        }
                        progressHUD = false;
                        setState(() {});
                      },
                      child: Text('Submit Context'),
                    ),
                  ],
                ),
              ),
            ),
            Divider(
              height: 2,
              thickness: 3,
            ),
            Expanded(
              flex: 4,
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
                        padding: const EdgeInsets.all(15.0),
                        child: ModalProgressHUD(
                          inAsyncCall: progressHUD,
                          child: Text(
                            answerText,
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                    ],
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
