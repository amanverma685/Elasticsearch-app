import 'package:flutter/material.dart';
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';
import 'dart:io';
import 'package:pdf/widgets.dart' as pw;

class PdfViewerPage extends StatelessWidget {
  final String path;
  final String pdfName;
  final pdf;

  PdfViewerPage({Key key, this.path, this.pdfName, this.pdf}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PDFViewerScaffold(
      appBar: AppBar(
        title: Text(pdfName),
        actions: [
          IconButton(
              icon: Icon(Icons.save),
              onPressed: () async {
                print(pdf);
                print(path);
                final File file = File(path);
                await file.writeAsBytes(pdf.save());
                print("File Saved");
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.green,
                    content: Text("File Saved"),
                  ),
                );
                Navigator.pop(context);
              })
        ],
      ),
      path: path,
    );
  }
}
