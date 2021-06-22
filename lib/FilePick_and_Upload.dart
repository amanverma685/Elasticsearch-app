import 'dart:convert';
import 'dart:io';
import 'AdobeBertModel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_tts/flutter_tts.dart';

class FilePickerElasticSearch extends StatefulWidget {
  const FilePickerElasticSearch({Key key}) : super(key: key);

  @override
  _FilePickerElasticSearchState createState() =>
      _FilePickerElasticSearchState();
}

class _FilePickerElasticSearchState extends State<FilePickerElasticSearch> {
  void filePickerPickFile() async {
    buttonData = "Upload Done Press here to Upload PDF again";
    var result = await FilePicker.platform.pickFiles(
        allowMultiple: true, type: FileType.custom, allowedExtensions: ['pdf']);
    String name = result.files.first.name;
    if (result != null) {
      File file = File(result.files.first.path);
      List<int> asString = await file.readAsBytes();
      var headers = {'Content-Type': 'application/pdf'};
      String urlString =
          "https://je1t14hikf.execute-api.ap-south-1.amazonaws.com/dev/public-files-329153277240/" +
              name;
      var url = Uri.parse(urlString);
      final response = await http.put(url, body: asString, headers: headers);
      print(response.statusCode);
      setState(() {});
    }
  }

  final flutterTts = FlutterTts();

  void speak() async {
    await flutterTts.speak(questionContext);
  }

  void stopSpeak() async {
    await flutterTts.stop();
  }

  bool isEnabled = false;
  String inputQuery = " ";
  final _formKey = GlobalKey<FormState>();
  String questionContext = " ";
  String buttonData = "Upload PDF to Index on ElasticSearch";
  String answerData = "";
  void _clearCachedFiles() {
    FilePicker.platform.clearTemporaryFiles().then((result) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: result ? Colors.green : Colors.red,
          content: Text((result
              ? 'Temporary files removed with success.'
              : 'Failed to clean temporary files')),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Speak"),
                  IconButton(
                    icon: Icon(
                      Icons.speaker,
                      color: Colors.green,
                    ),
                    onPressed: isEnabled ? speak : null,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Stop"),
                  IconButton(
                    icon: Icon(
                      Icons.stop_circle_rounded,
                      color: Colors.red,
                    ),
                    onPressed: stopSpeak,
                  ),
                ],
              ),
              ElevatedButton(
                child: Text(buttonData),
                onPressed: filePickerPickFile,
              ),
              TextButton(
                child: Text("Clear Cache"),
                onPressed: _clearCachedFiles,
              ),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(
                        icon: Icon(Icons.search),
                        hintText: 'Enter your Query',
                        labelText: 'Query',
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        if (value.length >= 0) {
                          inputQuery = value;
                        } else
                          inputQuery = null;
                      },
                    ),
                    Center(
                      child: Container(
                        child: ElevatedButton(
                          child: Text('Submit'),
                          onPressed: () async {
                            FocusScope.of(context).requestFocus(FocusNode());
                            if (_formKey.currentState.validate()) {
                              var headers = {
                                'Content-Type': 'application/json'
                              };
                              var body = {"question": inputQuery};

                              String urlString =
                                  "https://8ikakz8a3m.execute-api.ap-south-1.amazonaws.com/dev/search";
                              var url = Uri.parse(urlString);
                              final response = await http.post(url,
                                  body: jsonEncode(body), headers: headers);
                              var jsonResponse = json.decode(response.body);
                              questionContext = jsonResponse['context1'];
                              answerData = await requestBertModel(
                                  questionContext, inputQuery);
                              print("This is the answer");
                              print(answerData);

                              if (questionContext == null)
                                questionContext = "No data Found";
                              setState(() {
                                isEnabled = true;
                              });
                            }
                          },
                          // It returns true if the form is valid, otherwise returns false
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20.0),
                      child: Text(
                        inputQuery,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Divider(height: 3, thickness: 3),
                    Padding(
                      padding: EdgeInsets.only(left: 18.0),
                      child: Text(
                        questionContext,
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
