import 'dart:io';
import 'package:elasticsearch_project/PDF_Screens/pdf_viewer_page.dart';
import 'package:flutter/material.dart' as material;
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:flutter/services.dart';
import 'package:pdf/widgets.dart';

reportView(context, heading, text, pdfName) async {
  final Document pdf = Document();
  final font = await rootBundle.load("assets/Lato-Regular.ttf");
  final ttf = Font.ttf(font);
  pdf.addPage(
    MultiPage(
      // pageFormat:
      //     PdfPageFormat.letter.copyWith(marginBottom: 1.5 * PdfPageFormat.cm),
      pageFormat: PdfPageFormat.a4,
      crossAxisAlignment: CrossAxisAlignment.start,
      header: (Context context) {
        if (context.pageNumber == 1) {
          return null;
        }
        return Container(
            alignment: Alignment.centerRight,
            margin: EdgeInsets.only(bottom: 3.0 * PdfPageFormat.mm),
            padding: EdgeInsets.only(bottom: 3.0 * PdfPageFormat.mm),
            decoration: BoxDecoration(
              border: Border.all(
                width: 8,
              ),
            ),
            // Border(bottom: true, width: 0.5, color: PdfColors.grey)),
            child: Text(heading,
                style: Theme.of(context)
                    .defaultTextStyle
                    .copyWith(color: PdfColors.grey)));
      },
      footer: (Context context) {
        return Container(
            alignment: Alignment.centerRight,
            margin: EdgeInsets.only(top: 1.0 * PdfPageFormat.cm),
            child: Text('Page ${context.pageNumber} of ${context.pagesCount}',
                style: Theme.of(context)
                    .defaultTextStyle
                    .copyWith(color: PdfColors.grey)));
      },
      build: (Context context) => <Widget>[
        Header(
            level: 0,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(heading, textScaleFactor: 2),
                  PdfLogo()
                ])),
        Header(level: 1, text: heading, outlineStyle: PdfOutlineStyle.normal),
        Paragraph(text: text, style: TextStyle(font: ttf))
      ],
    ),
  );
  //save PDF

  final String dir = (await getApplicationDocumentsDirectory()).path;
  final String path = '$dir/' + pdfName;
  final File file = File(path);
  await file.writeAsBytes(pdf.save());
  material.Navigator.of(context).push(
    material.MaterialPageRoute(
      builder: (_) => PdfViewerPage(path: path),
    ),
  );
}
