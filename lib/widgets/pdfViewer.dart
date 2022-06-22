import 'dart:io';
import 'package:capstone_project/classes/medical_record.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import '../classes/patient.dart';
import 'package:pdf/widgets.dart' as pw;

import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

Future<void> generatePDF(Patient p, Directory output) async {
  final pdf = pw.Document();
  final ttf = await fontFromAssetBundle('fonts/open_sans.ttf');

  pdf.addPage(pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) {
        return pw.Column(
          children: [
            pw.Center(
              child: pw.Text(
                "Medical Record",
                textAlign: pw.TextAlign.center,
                style: pw.TextStyle(
                  font: ttf,
                  fontSize: 28,
                ),
              ),
            ),
            pw.Center(
              child: pw.Text(
                p.MRN,
                textAlign: pw.TextAlign.center,
                style: pw.TextStyle(
                    font: ttf, fontSize: 18, fontWeight: pw.FontWeight.bold),
              ),
            ),
            pw.Center(
              child: pw.Text(
                "Visit No.: " + p.nbrOfVisits.toString(),
                textAlign: pw.TextAlign.center,
                style: pw.TextStyle(
                    font: ttf, fontSize: 14, fontWeight: pw.FontWeight.bold),
              ),
            ),
            pw.Divider(),
            pw.SizedBox(height: 40),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
              children: [
                pw.SizedBox(
                  width: 150,
                  child: pw.Text(
                    "Name: " +
                        p.firstName +
                        ' ' +
                        p.middleName +
                        ' ' +
                        p.lastName,
                    textAlign: pw.TextAlign.left,
                    style: pw.TextStyle(
                      font: ttf,
                      fontSize: 14,
                    ),
                  ),
                ),
                pw.SizedBox(
                  width: 150,
                  child: pw.Text(
                    "Starting Date: " + p.startingDate,
                    textAlign: pw.TextAlign.left,
                    style: pw.TextStyle(
                      font: ttf,
                      fontSize: 14,
                    ),
                  ),
                )
              ],
            ),
            pw.SizedBox(height: 20),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
              children: [
                pw.SizedBox(
                  width: 150,
                  child: pw.Text(
                    "Date of Birth: " + p.dob,
                    textAlign: pw.TextAlign.left,
                    style: pw.TextStyle(
                      font: ttf,
                      fontSize: 14,
                    ),
                  ),
                ),
                pw.SizedBox(
                  width: 150,
                  child: pw.Text(
                    "Phone No.: " + p.phoneNbr,
                    textAlign: pw.TextAlign.left,
                    style: pw.TextStyle(
                      font: ttf,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
            pw.SizedBox(height: 20),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
              children: [
                pw.SizedBox(
                  width: 150,
                  child: pw.Text(
                    "Address: " + p.address,
                    textAlign: pw.TextAlign.left,
                    style: pw.TextStyle(
                      font: ttf,
                      fontSize: 14,
                    ),
                  ),
                ),
                pw.SizedBox(
                  width: 150,
                  child: pw.Text(
                    "Occupation: " + p.occupation,
                    textAlign: pw.TextAlign.left,
                    style: pw.TextStyle(
                      font: ttf,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
            pw.SizedBox(height: 20),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
              children: [
                pw.SizedBox(
                  width: 75,
                  child: pw.Text(
                    "Blood Type: " + p.bloodType,
                    textAlign: pw.TextAlign.left,
                    style: pw.TextStyle(
                      font: ttf,
                      fontSize: 14,
                    ),
                  ),
                ),
                pw.SizedBox(
                  width: 75,
                  child: pw.Text(
                    "Gender Type: " + p.selectedGender,
                    textAlign: pw.TextAlign.left,
                    style: pw.TextStyle(
                      font: ttf,
                      fontSize: 14,
                    ),
                  ),
                ),
                pw.SizedBox(
                  width: 75,
                  child: pw.Text(
                    "Marital Status: " + p.status,
                    textAlign: pw.TextAlign.left,
                    style: pw.TextStyle(
                      font: ttf,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ); // Center
      }));
  for (Map<String, dynamic> mr in p.medicalRecords!) {
    MedicalRecord medicalRecord = MedicalRecord.fromJson(mr);
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(children: [
            pw.Center(
              child: pw.Text(
                "Medical Record",
                textAlign: pw.TextAlign.left,
                style: pw.TextStyle(
                  font: ttf,
                  fontSize: 28,
                ),
              ),
            ),
            pw.Divider(),
            pw.SizedBox(height: 40),
            pw.Row(
              children: [
                pw.Text(
                  "Chief Complaint: " + medicalRecord.chiefComplaint,
                  textAlign: pw.TextAlign.left,
                  style: pw.TextStyle(
                    font: ttf,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            pw.SizedBox(height: 40),
            pw.Row(
              children: [
                pw.Text(
                  "History of Present Illness (HPI): " + medicalRecord.hpi,
                  textAlign: pw.TextAlign.left,
                  style: pw.TextStyle(
                    font: ttf,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            pw.SizedBox(height: 40),
            pw.Row(
              children: [
                pw.Text(
                  "Past Medical History " + medicalRecord.pmh,
                  textAlign: pw.TextAlign.left,
                  style: pw.TextStyle(
                    font: ttf,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            pw.SizedBox(height: 40),
            pw.Row(
              children: [
                pw.Text(
                  (medicalRecord.labs.isNotEmpty)
                      ? "Labs: " + medicalRecord.pmh
                      : "Labs: No labs done",
                  textAlign: pw.TextAlign.left,
                  style: pw.TextStyle(
                    font: ttf,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            pw.SizedBox(height: 40),
            pw.Row(
              children: [
                pw.Text(
                  (medicalRecord.imaging.isNotEmpty)
                      ? "Imaging: " + medicalRecord.pmh
                      : "Imaging: No imaging done",
                  textAlign: pw.TextAlign.left,
                  style: pw.TextStyle(
                    font: ttf,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            pw.SizedBox(height: 40),
            (medicalRecord.vitals.isNotEmpty)
                ? pw.Text(
                    'Vitals',
                    style: pw.TextStyle(
                      font: ttf,
                      fontSize: 28,
                    ),
                  )
                : pw.Text(''),
            (medicalRecord.vitals.isNotEmpty) ? pw.Divider() : pw.Text(''),
            pw.SizedBox(height: 40),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
              children: [
                pw.Text(
                  (medicalRecord.vitals.isNotEmpty)
                      ? "Temperature: " +
                          medicalRecord.vitals['temperature'].elementAt(0) +
                          " " +
                          medicalRecord.vitals['temperature'].elementAt(1)
                      : '',
                  textAlign: pw.TextAlign.left,
                  style: pw.TextStyle(
                    font: ttf,
                    fontSize: 14,
                  ),
                ),
                pw.Text(
                  (medicalRecord.vitals.isNotEmpty)
                      ? "Heart Rate: " +
                          medicalRecord.vitals['heartRate'].elementAt(0) +
                          " " +
                          medicalRecord.vitals['heartRate'].elementAt(1)
                      : '',
                  textAlign: pw.TextAlign.left,
                  style: pw.TextStyle(
                    font: ttf,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            pw.SizedBox(height: 40),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
              children: [
                pw.Text(
                  (medicalRecord.vitals.isNotEmpty)
                      ? "Respiration Rate: " +
                          medicalRecord.vitals['respirationRate'].elementAt(0) +
                          " " +
                          medicalRecord.vitals['respirationRate'].elementAt(1)
                      : '',
                  textAlign: pw.TextAlign.left,
                  style: pw.TextStyle(
                    font: ttf,
                    fontSize: 14,
                  ),
                ),
                pw.Text(
                  (medicalRecord.vitals.isNotEmpty)
                      ? "Blood Pressure: " +
                          medicalRecord.vitals['bloodPressure'].elementAt(0) +
                          " " +
                          medicalRecord.vitals['bloodPressure'].elementAt(1)
                      : '',
                  textAlign: pw.TextAlign.left,
                  style: pw.TextStyle(
                    font: ttf,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ]);
        },
      ),
    );
  }
  // Page
  final file = File("${output.path}/patient.pdf");
  await file.writeAsBytes(await pdf.save());
}

class pdfCustomField extends StatelessWidget {
  const pdfCustomField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class pdfView extends StatefulWidget {
  const pdfView({Key? key, this.output}) : super(key: key);
  static String id = 'pdfView';
  final Directory? output;

  @override
  State<pdfView> createState() => _pdfViewState();
}

class _pdfViewState extends State<pdfView> {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SfPdfViewer.file(
      File('${widget.output!.path}/patient.pdf'),
      key: _pdfViewerKey,
      pageSpacing: 2,
      onDocumentLoadFailed: (PdfDocumentLoadFailedDetails details) {
        AlertDialog(
          title: Text(details.error),
          content: Text(details.description),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    ));
  }
}

//create file in path specified
Future<String> get _localPath async {
  final directory = await getTemporaryDirectory();
  // print(directory.path);
  return directory.path;
}

Future<File> get _localFile async {
  final path = await _localPath;
  return File('$path/patient.pdf');
}
