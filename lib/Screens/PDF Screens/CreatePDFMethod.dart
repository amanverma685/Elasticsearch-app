import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'mobile.dart';
import 'dart:typed_data';
import 'package:flutter/services.dart' show rootBundle;

Future<void> createPDF(
    String pdfHeading, String pdfText, String pdfName) async {
  PdfDocument document = PdfDocument();
  final page = document.pages.add();
  //Add the pages to the document
  for (int i = 1; i <= 1; i++) {
    document.pages.add();
  }

//Create the header with specific bounds
  PdfPageTemplateElement header = PdfPageTemplateElement(
      Rect.fromLTWH(0, 0, document.pages[0].getClientSize().width, 50));

//Create the date and time field
  PdfDateTimeField dateAndTimeField = PdfDateTimeField(
      font: PdfStandardFont(PdfFontFamily.timesRoman, 19),
      brush: PdfSolidBrush(PdfColor(0, 0, 0)));
  dateAndTimeField.date = DateTime.now();
  dateAndTimeField.dateFormatString = 'E, MM.dd.yyyy';

//Create the composite field with date field
  PdfCompositeField compositefields = PdfCompositeField(
      font: PdfStandardFont(PdfFontFamily.timesRoman, 19),
      brush: PdfSolidBrush(PdfColor(0, 0, 0)),
      text:
          '{0}                                                Adobe Internship',
      fields: <PdfAutomaticField>[dateAndTimeField]);

//Add composite field in header
  compositefields.draw(header.graphics,
      Offset(0, PdfStandardFont(PdfFontFamily.timesRoman, 11).height));

  page.graphics.drawString(
      pdfHeading, PdfStandardFont(PdfFontFamily.helvetica, 25),
      brush: PdfBrushes.black, bounds: Rect.fromLTRB(0, 40, 500, 30));

//Add the header at top of the document
  document.template.top = header;
  page.graphics.drawString(
      pdfText, PdfStandardFont(PdfFontFamily.helvetica, 15),
      brush: PdfBrushes.black, bounds: Rect.fromLTRB(0, 80, 500, 750));

//Create the footer with specific bounds
  PdfPageTemplateElement footer = PdfPageTemplateElement(
      Rect.fromLTWH(0, 0, document.pages[0].getClientSize().width, 50));

//Create the page number field
  PdfPageNumberField pageNumber = PdfPageNumberField(
      font: PdfStandardFont(PdfFontFamily.timesRoman, 19),
      brush: PdfSolidBrush(PdfColor(0, 0, 0)));

//Sets the number style for page number
  pageNumber.numberStyle = PdfNumberStyle.numeric;

//Create the page count field
  PdfPageCountField count = PdfPageCountField(
      font: PdfStandardFont(PdfFontFamily.timesRoman, 19),
      brush: PdfSolidBrush(PdfColor(0, 0, 0)));

//set the number style for page count
  count.numberStyle = PdfNumberStyle.numeric;

//Create the date and time field
  PdfDateTimeField dateTimeField = PdfDateTimeField(
      font: PdfStandardFont(PdfFontFamily.timesRoman, 19),
      brush: PdfSolidBrush(PdfColor(0, 0, 0)));

//Sets the date and time
  dateTimeField.date = DateTime.now();

//Create the composite field with page number page count
  PdfCompositeField compositeField = PdfCompositeField(
      font: PdfStandardFont(PdfFontFamily.timesRoman, 19),
      brush: PdfSolidBrush(PdfColor(0, 0, 0)),
      text: 'Page {0} of {1}',
      fields: <PdfAutomaticField>[pageNumber, count]);
  compositeField.bounds = footer.bounds;

//Add the composite field in footer
  compositeField.draw(footer.graphics,
      Offset(0, 50 - PdfStandardFont(PdfFontFamily.timesRoman, 19).height));

  // page.graphics.drawString(
  //     pdfHeading, PdfStandardFont(PdfFontFamily.helvetica, 15),
  //     brush: PdfBrushes.black, bounds: Rect.fromLTWH(0, 0, 0, 0));
//Add the footer at the bottom of the document
  document.template.bottom = footer;

  List<int> bytes = document.save();
  document.dispose();
  saveAndLaunchFile(bytes, pdfName);
}

Future<Uint8List> readImageData(String name) async {
  final data = await rootBundle.load('assets/$name');
  return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
}
