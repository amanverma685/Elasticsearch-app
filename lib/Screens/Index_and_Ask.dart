import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../AdobeBertModel.dart';

class IndexAndAsk extends StatefulWidget {
  const IndexAndAsk({Key key}) : super(key: key);

  @override
  _IndexAndAskState createState() => _IndexAndAskState();
}

class _IndexAndAskState extends State<IndexAndAsk> {
  final _formFieldKey = GlobalKey<FormFieldState>();
  TextEditingController contextController = TextEditingController();
  TextEditingController questionController = TextEditingController();
  String questionContext = "";
  String questionQuery = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Column(
            children: [
              Expanded(
                child: Form(
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        controller: contextController,
                        maxLength: null,
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        key: _formFieldKey,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter some Context to Index';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: questionController,
                        maxLength: null,
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        key: _formFieldKey,
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
                            String answer = await requestBertModel(
                                questionContext, questionQuery);
                            print(answer);
                            final snackBar = SnackBar(
                                backgroundColor: Colors.deepPurple,
                                content:
                                    Text('Processing Data Please Wait...'));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        },
                        child: Text('Submit Context'),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
