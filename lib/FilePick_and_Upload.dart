import 'dart:convert';
import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:translator/translator.dart';

import 'AdobeBertModel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_tts/flutter_tts.dart';

import 'Screens/CarouselSlider.dart';
import 'Screens/ContextViewScreen.dart';

class FilePickerElasticSearch extends StatefulWidget {
  const FilePickerElasticSearch({Key key}) : super(key: key);

  @override
  _FilePickerElasticSearchState createState() =>
      _FilePickerElasticSearchState();
}

class _FilePickerElasticSearchState extends State<FilePickerElasticSearch> {
  final translator = GoogleTranslator();

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

  String dropDownTitle = "Select Language";
  final flutterTts = FlutterTts();

  void speak() async {
    await flutterTts.speak(answerData);
  }

  void stopSpeak() async {
    await flutterTts.stop();
  }

  Future<String> translateIntoDesiredForm(String to) async {
    var translation = await translator.translate(answerData, to: to);
    return translation.text;
  }

  bool isEnabled = false;
  bool modalHudProgress = false;
  String inputQuery = " ";
  final _formKey = GlobalKey<FormState>();
  String questionContext = " ";
  String buttonData = "Upload PDF to Index on ElasticSearch";
  String answerData = " ";
  String questionContext1 = "";
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
      appBar: AppBar(
        title: Text("Upload PDF To Index"),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: ModalProgressHUD(
        inAsyncCall: modalHudProgress,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.deepPurple,
                      offset: const Offset(
                        5.0,
                        5.0,
                      ),
                      blurRadius: 10.0,
                      spreadRadius: 2.0,
                    ), //BoxShadow
                    BoxShadow(
                      color: Colors.white,
                      offset: const Offset(0.0, 0.0),
                      blurRadius: 0.0,
                      spreadRadius: 0.0,
                    ), //BoxShadow
                  ],
                ),
                child: CarouselSlider(
                    options: CarouselOptions(
                        scrollDirection: Axis.horizontal,
                        viewportFraction: 0.98,
                        aspectRatio: 2.0,
                        autoPlayCurve: Curves.easeInOutQuart,
                        autoPlay: true,
                        enlargeCenterPage: true),
                    items: [
                      MyImageView("assets/1.jpeg"),
                      MyImageView("assets/2.jpeg"),
                      MyImageView("assets/3.jpeg"),
                      MyImageView("assets/4.jpeg"),
                    ]),
              ),
            ),
            Expanded(
              flex: 4,
              child: Container(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.deepPurple)),
                          child: Text(buttonData),
                          onPressed: filePickerPickFile,
                        ),
                      ),
                      TextButton(
                        style: ButtonStyle(
                            overlayColor:
                                MaterialStateProperty.all(Colors.deepPurple)),
                        child: Text(
                          "Clear Cache",
                          style: TextStyle(color: Colors.black),
                        ),
                        onPressed: _clearCachedFiles,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10.0, right: 8),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              TextFormField(
                                decoration: InputDecoration(
                                  icon: Icon(
                                    Icons.search,
                                    size: 25,
                                  ),
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
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.deepPurple)),
                                    child: Text('Submit'),
                                    onPressed: () async {
                                      FocusScope.of(context)
                                          .requestFocus(FocusNode());
                                      if (_formKey.currentState.validate()) {
                                        setState(() {
                                          modalHudProgress = true;
                                        });
                                        var headers = {
                                          'Content-Type': 'application/json'
                                        };
                                        var body = {"question": inputQuery};

                                        String urlString =
                                            "https://8ikakz8a3m.execute-api.ap-south-1.amazonaws.com/dev/search";
                                        var url = Uri.parse(urlString);
                                        final response = await http.post(url,
                                            body: jsonEncode(body),
                                            headers: headers);
                                        var jsonResponse =
                                            json.decode(response.body);
                                        questionContext =
                                            jsonResponse['context1'];

                                        answerData = await requestBertModel(
                                            questionContext, inputQuery);
                                        print("This is the answer");
                                        print(answerData);

                                        if (questionContext == null)
                                          questionContext = "No data Found";
                                        setState(() {
                                          isEnabled = true;
                                          modalHudProgress = false;
                                        });
                                      }
                                    },
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 15.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Text("Speak"),
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
                                          Text("Stop"),
                                          IconButton(
                                            hoverColor: Colors.deepPurple,
                                            icon: Icon(
                                              Icons.stop_circle_rounded,
                                              color: Colors.deepPurple,
                                            ),
                                            onPressed: stopSpeak,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Text("View Context"),
                                          IconButton(
                                              icon: Icon(
                                                Icons.forward,
                                              ),
                                              onPressed: isEnabled
                                                  ? () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              ViewContext(
                                                            text:
                                                                questionContext,
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                  : null),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    inputQuery,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 20),
                                    child: DropdownButton<String>(
                                      dropdownColor: Colors.deepPurple,
                                      style: TextStyle(color: Colors.white),
                                      iconEnabledColor: Colors.black,
                                      icon: Icon(Icons.arrow_drop_down),
                                      iconSize: 20,
                                      underline: SizedBox(),
                                      hint: Text(dropDownTitle),
                                      items: <String>[
                                        'German',
                                        'Italian',
                                        'Chinese',
                                        'Spanish',
                                        'English',
                                        'Hindi',
                                        'Dutch',
                                        'Urdu',
                                        'Russian'
                                      ].map((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: new Text(value),
                                        );
                                      }).toList(),
                                      onChanged: (String value) async {
                                        dropDownTitle = value;

                                        if (value == "Spanish") {
                                          answerData =
                                              await translateIntoDesiredForm(
                                                  'es');
                                        } else if (value == "Italian") {
                                          answerData =
                                              await translateIntoDesiredForm(
                                                  'it');
                                        } else if (value == "Hindi") {
                                          answerData =
                                              await translateIntoDesiredForm(
                                                  'hi');
                                        } else if (value == "Dutch") {
                                          answerData =
                                              await translateIntoDesiredForm(
                                                  'nl');
                                        } else if (value == "German") {
                                          answerData =
                                              await translateIntoDesiredForm(
                                                  'de');
                                        } else if (value == "Chinese") {
                                          translator.baseUrl =
                                              "translate.google.cn";
                                          var translated = await translator
                                              .translate(answerData,
                                                  to: 'zh-cn');
                                          answerData = translated.text;
                                        } else if (value == "English") {
                                          answerData =
                                              await translateIntoDesiredForm(
                                                  'en');
                                        } else if (value == "Russian") {
                                          answerData =
                                              await translateIntoDesiredForm(
                                                  'ru');
                                        } else if (value == "Urdu") {
                                          answerData =
                                              await translateIntoDesiredForm(
                                                  'ur');
                                        }

                                        setState(() {});
                                        print(value);
                                      },
                                    ),
                                  )
                                ],
                              ),
                              Divider(
                                height: 3,
                                thickness: 2,
                                color: Colors.deepPurple,
                              ),
                              Container(
                                child: Text(
                                  answerData,
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                            ],
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
