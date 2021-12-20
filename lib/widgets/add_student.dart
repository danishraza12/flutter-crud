// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../services/apis.dart';
import 'dart:io' as io;
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:convert';
import 'package:universal_html/html.dart' as html;
import '../models/student.dart' as student;
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as ExcelSheet;
import 'package:path_provider/path_provider.dart' as PathProvider;
import 'package:open_file/open_file.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class AddStudent extends StatefulWidget {
  const AddStudent({Key? key}) : super(key: key);

  @override
  State<AddStudent> createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {
  final NameController = TextEditingController();
  final AgeController = TextEditingController();
  final CityController = TextEditingController();
  bool _validate1 = false;
  bool _validate2 = false;
  bool _validate3 = false;
  final pdf = pw.Document();
  late Future<List<student.Student>> futureStudent;

  @override
  void initState() {
    super.initState();
    futureStudent = fetchStudents();
  }

  @override
  Widget build(BuildContext context) {
    void createPDF(var FetchedStudents) {
      pdf.addPage(pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
            return pw.Center(
              child: pw.Column(children: <pw.Widget>[
                pw.Container(
                  margin: pw.EdgeInsets.all(20),
                  child: pw.Table(
                    defaultColumnWidth: pw.FixedColumnWidth(120.0),
                    border: pw.TableBorder.all(
                        // color: Colors.black,
                        style: pw.BorderStyle.solid,
                        width: 2),
                    children: [
                      pw.TableRow(children: [
                        pw.Column(children: [
                          pw.Text('Name',
                              style: pw.TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: pw.FontWeight.bold))
                        ]),
                        pw.Column(children: [
                          pw.Text('Age',
                              style: pw.TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: pw.FontWeight.bold))
                        ]),
                        pw.Column(children: [
                          pw.Text('City',
                              style: pw.TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: pw.FontWeight.bold))
                        ]),
                      ]),
                      for (var student in FetchedStudents)
                        pw.TableRow(children: [
                          pw.Column(children: [pw.Text(student.name)]),
                          pw.Column(children: [pw.Text(student.age)]),
                          pw.Column(children: [pw.Text(student.city)]),
                        ])
                    ],
                  ),
                ),
              ]),
            );
          }));
    }

    Future<void> createExcel() async {
      final ExcelSheet.Workbook workbook = ExcelSheet.Workbook();
      final ExcelSheet.Worksheet sheet = workbook.worksheets[0];
      sheet.getRangeByName('A1').setText('Hello World!');
      final List<int> bytes = workbook.saveAsStream();
      workbook.dispose();

      if (kIsWeb) {
        html.AnchorElement(
            href:
                'data:application/octet-stream;charset=utf-16le;base64,${base64.encode(bytes)}')
          ..setAttribute('download', 'Output.xlsx')
          ..click();
      } else {
        final String path =
            (await PathProvider.getApplicationSupportDirectory()).path;
        final String fileName =
            io.Platform.isWindows ? '$path\\Output.xlsx' : '$path/Output.xlsx';
        final io.File file = io.File(fileName);
        await file.writeAsBytes(bytes, flush: true);
        OpenFile.open(fileName);
      }
    }

    // Build a Form widget using the _formKey created above.
    return Column(
      children: <Widget>[
        Row(children: <Widget>[]),
        Padding(
          padding: const EdgeInsets.only(top: 15, left: 20),
          child: Text(
            'ADD DETAILS',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 30, color: Colors.blue),
          ),
        ),
        Container(
          width: 300,
          alignment: Alignment.center,
          margin: EdgeInsets.symmetric(horizontal: 35, vertical: 12),
          child: TextField(
            key: Key('Name'),
            controller: NameController,
            inputFormatters: [
              WhitelistingTextInputFormatter(RegExp("[a-zA-Z ]")),
            ],
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Name',
              errorText: _validate1 ? 'Enter Correct Name Field' : null,
            ),
          ),
        ),
        Container(
          width: 300,
          margin: EdgeInsets.symmetric(horizontal: 35, vertical: 12),
          alignment: Alignment.center,
          child: TextField(
            key: Key('Age'),
            controller: AgeController,
            inputFormatters: [
              WhitelistingTextInputFormatter(RegExp("[0-9]")),
            ],
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Age',
              errorText: _validate2 ? 'Enter Correct Age Field' : null,
            ),
          ),
        ),
        Container(
          width: 300,
          margin: EdgeInsets.symmetric(horizontal: 35, vertical: 12),
          alignment: Alignment.center,
          child: TextField(
            key: Key('City'),
            controller: CityController,
            inputFormatters: [
              WhitelistingTextInputFormatter(RegExp("[a-zA-Z ]")),
            ],
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'City',
              errorText: _validate3 ? 'Enter Correct City Field' : null,
            ),
          ),
        ),
        ElevatedButton(
          key: Key('Add Record Button'),
          onPressed: () {
            if (NameController.text.isEmpty ||
                AgeController.text.isEmpty ||
                CityController.text.isEmpty) {
              setState(() {
                NameController.text.isEmpty
                    ? _validate1 = true
                    : _validate1 = false;
                AgeController.text.isEmpty
                    ? _validate2 = true
                    : _validate2 = false;
                CityController.text.isEmpty
                    ? _validate3 = true
                    : _validate3 = false;
              });
            } else {
              postStudents(context, NameController.text, AgeController.text,
                  CityController.text);

              setState(() {
                _validate1 = false;
                _validate2 = false;
                _validate3 = false;
              });

              NameController.clear();
              AgeController.clear();
              CityController.clear();
            }
          },
          child: Text('Add Student'),
        ),
        ElevatedButton(onPressed: createExcel, child: Text('Create Excel')),
        FutureBuilder<List<student.Student>>(
            // initialData: initStudents,
            future: futureStudent,
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.data != null) {
                if (snapshot.hasData) {
                  return ElevatedButton(
                    key: Key('Generate PDF'),
                    onPressed: () async {
                      createPDF(snapshot.data);
                      final bytes = await pdf.save();
                      final blob = html.Blob([bytes], 'application/pdf');

                      final url = html.Url.createObjectUrlFromBlob(blob);
                      final anchor =
                          html.document.createElement('a') as html.AnchorElement
                            ..href = url
                            ..style.display = 'none'
                            ..download = 'Generated Report.pdf';
                      html.document.body!.children.add(anchor);
                      anchor.click(); //download
                      //Cleanup
                      html.document.body!.children.remove(anchor);
                      html.Url.revokeObjectUrl(url);
                    },
                    child: Text('Generate PDF'),
                  );
                } else {
                  return Padding(
                      padding: const EdgeInsets.only(top: 15, left: 20),
                      child: CircularProgressIndicator());
                }
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              // By default, show a loading spinner.
              else {
                return Padding(
                    padding: const EdgeInsets.only(top: 15, left: 20),
                    child: CircularProgressIndicator()); // loading
              }
            }),
      ],
    );
  }
}
