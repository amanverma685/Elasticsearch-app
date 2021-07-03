import 'package:flutter/material.dart';

import 'package:flutter/services.dart';

import 'CreatePDFMethod.dart';

class PDFCreator extends StatefulWidget {
  @override
  _PDFCreatorState createState() => _PDFCreatorState();
}

class _PDFCreatorState extends State<PDFCreator> {
  String pdfText;
  String pdfHeading;
  String pdfName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          margin: EdgeInsets.only(top: 30),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        labelText: 'Enter Pdf Header',
                        hintText: 'PDF Header'),
                    keyboardType: TextInputType.multiline,
                    minLines: 1, //Normal textInputField will be displayed
                    maxLines: 2, // when user presses enter it will adapt to it
                    onChanged: (value) {
                      pdfHeading = value;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        labelText: 'Enter Pdf Text',
                        hintText: 'PDF Text'),
                    keyboardType: TextInputType.multiline,
                    minLines: 1, //Normal textInputField will be displayed
                    maxLines: 100,
                    onChanged: (value) {
                      pdfText = value;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        labelText: 'Enter Pdf Name with .pdf Extension',
                        hintText: 'PDF Name with .pdf extension'),
                    onChanged: (value) {
                      pdfName = value;
                    },
                  ),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all(Colors.red),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.red)),
                    ),
                  ),
                  child: Text(
                    'Create PDF',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () async {
                    createPDF(pdfHeading, pdfText, pdfName);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
