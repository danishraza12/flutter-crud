// ignore_for_file: prefer_const_constructors, deprecated_member_use, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterform/models/countries.dart';
import '../services/apis.dart';
import 'dart:io' as io;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:convert';
import 'package:universal_html/html.dart' as html;
import '../models/student.dart' as student;
import '../models/countries.dart' as countries;
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as excel_sheet;
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:open_file/open_file.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import '../models/countries_and_cities.dart' as countries_and_cities;
import 'package:responsive_grid/responsive_grid.dart';

class AddStudent extends StatefulWidget {
  const AddStudent({Key? key}) : super(key: key);

  @override
  State<AddStudent> createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {
  // For value extraction
  final NameController = TextEditingController();
  final AgeController = TextEditingController();
  final CityController = TextEditingController();
  final BatchController = TextEditingController();
  final AddressController = TextEditingController();
  final DateOfBirthController = TextEditingController();
  final FatherNameController = TextEditingController();
  final GenderController = TextEditingController();
  final RollNumberController = TextEditingController();
  final DegreeStatusController = TextEditingController();

  // For validation
  bool _validateName = false;
  bool _validateAge = false;
  bool _validateCity = false;
  bool _validateBatch = false;
  bool _validateAddress = false;
  bool _validateDateOfBirth = false;
  bool _validateFatherName = false;
  bool _validateGender = false;
  bool _validateRollNumber = false;
  bool _validateDegreeStatus = false;

  // PDF
  pw.Document pdf = pw.Document();

  // Student List
  late Future<List<student.Student>> futureStudent;

  // For Country DropDown
  String? countryDropDownValue;
  late List<String?> countryDropDownEntries;

  // For City Dropdown
  String? cityDropDownValue;
  late Future<List<String>?> cityDropDownEntries = Future.value([]);
  late List<String> extractedCityDropDownEntries = [];

  // For Both Countries and Cities
  late Future<countries_and_cities.CountriesAndCities> countriesAndCities;

  @override
  void initState() {
    super.initState();
    // countryDropDownEntries = getAllCountries();
    futureStudent = fetchStudents();
    countriesAndCities = getCountriesAndCities();
  }

  void extractCountries() async {
    // countriesAndCities = getCountriesAndCities();
    var simpleCountriesAndCities = await Future.value(countriesAndCities);

    // Extracting countries from list
    var countriesOnly =
        simpleCountriesAndCities.data!.map((e) => e.country).toList();
    countryDropDownEntries = countriesOnly;
  }

  void refreshStudents() {
    setState(() {
      // futureStudent = await Future.value(fetchStudents()); // Extract value from future
      futureStudent = Future.value(fetchStudents());
      // futureStudent = fetchStudents();
    });
  }

  void refreshPDF() {
    setState(() {
      pdf = pw.Document();
    });
  }

  @override
  Widget build(BuildContext context) {
    void createPDF(var FetchedStudents) {
      refreshStudents();
      pdf.addPage(pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
            return pw.Flexible(
              child: pw.Row(
                // mainAxisAlignment: pw.MainAxisAlignment.start,
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: <pw.Widget>[
                  pw.Container(
                    alignment: pw.Alignment.topLeft,
                    child: pw.Container(
                      margin: pw.EdgeInsets.all(1.0),
                      child: pw.Table(
                        // defaultColumnWidth: pw.FixedColumnWidth(200.0),
                        border: pw.TableBorder.all(
                            // color: Colors.black,
                            style: pw.BorderStyle.solid,
                            width: 1),
                        children: [
                          pw.TableRow(children: [
                            pw.Padding(
                              padding: pw.EdgeInsets.all(2.0),
                              child: pw.Column(
                                  crossAxisAlignment:
                                      pw.CrossAxisAlignment.start,
                                  children: [
                                    pw.Text('Name',
                                        style: pw.TextStyle(
                                            fontSize: 11.0,
                                            fontWeight: pw.FontWeight.bold))
                                  ]),
                            ),
                            pw.Padding(
                              padding: pw.EdgeInsets.all(2.0),
                              child: pw.Column(
                                  crossAxisAlignment:
                                      pw.CrossAxisAlignment.start,
                                  children: [
                                    pw.Text('Age',
                                        style: pw.TextStyle(
                                            fontSize: 11.0,
                                            fontWeight: pw.FontWeight.bold)),
                                  ]),
                            ),
                            pw.Padding(
                              padding: pw.EdgeInsets.all(2.0),
                              child: pw.Column(
                                  crossAxisAlignment:
                                      pw.CrossAxisAlignment.start,
                                  children: [
                                    pw.Text('City',
                                        style: pw.TextStyle(
                                            fontSize: 11.0,
                                            fontWeight: pw.FontWeight.bold))
                                  ]),
                            ),
                            pw.Padding(
                              padding: pw.EdgeInsets.all(2.0),
                              child: pw.Column(
                                  crossAxisAlignment:
                                      pw.CrossAxisAlignment.start,
                                  children: [
                                    pw.Text('Batch',
                                        style: pw.TextStyle(
                                            fontSize: 11.0,
                                            fontWeight: pw.FontWeight.bold))
                                  ]),
                            ),
                            pw.Padding(
                              padding: pw.EdgeInsets.all(2.0),
                              child: pw.Column(
                                  crossAxisAlignment:
                                      pw.CrossAxisAlignment.start,
                                  children: [
                                    pw.Text('Address',
                                        style: pw.TextStyle(
                                            fontSize: 11.0,
                                            fontWeight: pw.FontWeight.bold))
                                  ]),
                            ),
                            pw.Padding(
                              padding: pw.EdgeInsets.all(2.0),
                              child: pw.Column(
                                  crossAxisAlignment:
                                      pw.CrossAxisAlignment.start,
                                  children: [
                                    pw.Text('Date of Birth',
                                        style: pw.TextStyle(
                                            fontSize: 11.0,
                                            fontWeight: pw.FontWeight.bold))
                                  ]),
                            ),
                            pw.Padding(
                              padding: pw.EdgeInsets.all(2.0),
                              child: pw.Column(
                                  crossAxisAlignment:
                                      pw.CrossAxisAlignment.start,
                                  children: [
                                    pw.Text('Father Name',
                                        style: pw.TextStyle(
                                            fontSize: 11.0,
                                            fontWeight: pw.FontWeight.bold))
                                  ]),
                            ),
                            pw.Padding(
                              padding: pw.EdgeInsets.all(2.0),
                              child: pw.Column(
                                  crossAxisAlignment:
                                      pw.CrossAxisAlignment.start,
                                  children: [
                                    pw.Text('Gender',
                                        style: pw.TextStyle(
                                            fontSize: 11.0,
                                            fontWeight: pw.FontWeight.bold))
                                  ]),
                            ),
                            pw.Padding(
                              padding: pw.EdgeInsets.all(2.0),
                              child: pw.Column(
                                  crossAxisAlignment:
                                      pw.CrossAxisAlignment.start,
                                  children: [
                                    pw.Text('Roll Number',
                                        style: pw.TextStyle(
                                            fontSize: 11.0,
                                            fontWeight: pw.FontWeight.bold))
                                  ]),
                            ),
                            pw.Padding(
                              padding: pw.EdgeInsets.all(2.0),
                              child: pw.Column(
                                  crossAxisAlignment:
                                      pw.CrossAxisAlignment.start,
                                  children: [
                                    pw.Text('Degree Status',
                                        style: pw.TextStyle(
                                            fontSize: 11.0,
                                            fontWeight: pw.FontWeight.bold))
                                  ]),
                            ),
                          ]),
                          for (var student in FetchedStudents)
                            pw.TableRow(children: [
                              pw.Padding(
                                padding: pw.EdgeInsets.all(2.0),
                                child: pw.Column(children: [
                                  pw.Text(
                                    student.name,
                                    style: pw.TextStyle(fontSize: 10.0),
                                  )
                                ]),
                              ),
                              pw.Padding(
                                padding: pw.EdgeInsets.all(2.0),
                                child: pw.Column(children: [
                                  pw.Text(
                                    student.age,
                                    style: pw.TextStyle(fontSize: 10.0),
                                  )
                                ]),
                              ),
                              pw.Padding(
                                padding: pw.EdgeInsets.all(2.0),
                                child: pw.Column(children: [
                                  pw.Text(
                                    student.city,
                                    style: pw.TextStyle(fontSize: 10.0),
                                  )
                                ]),
                              ),
                              pw.Padding(
                                padding: pw.EdgeInsets.all(2.0),
                                child: pw.Column(children: [
                                  pw.Text(
                                    student.batch,
                                    style: pw.TextStyle(fontSize: 10.0),
                                  )
                                ]),
                              ),
                              pw.Padding(
                                padding: pw.EdgeInsets.all(2.0),
                                child: pw.Column(children: [
                                  pw.Text(
                                    student.address,
                                    style: pw.TextStyle(fontSize: 10.0),
                                  )
                                ]),
                              ),
                              pw.Padding(
                                padding: pw.EdgeInsets.all(2.0),
                                child: pw.Column(children: [
                                  pw.Text(
                                    student.dateOfBirth,
                                    style: pw.TextStyle(fontSize: 10.0),
                                  )
                                ]),
                              ),
                              pw.Padding(
                                padding: pw.EdgeInsets.all(2.0),
                                child: pw.Column(children: [
                                  pw.Text(
                                    student.fatherName,
                                    style: pw.TextStyle(fontSize: 10.0),
                                  )
                                ]),
                              ),
                              pw.Padding(
                                padding: pw.EdgeInsets.all(2.0),
                                child: pw.Column(children: [
                                  pw.Text(
                                    student.gender,
                                    style: pw.TextStyle(fontSize: 10.0),
                                  )
                                ]),
                              ),
                              pw.Padding(
                                padding: pw.EdgeInsets.all(2.0),
                                child: pw.Column(children: [
                                  pw.Text(
                                    student.rollNumber,
                                    style: pw.TextStyle(fontSize: 10.0),
                                  )
                                ]),
                              ),
                              pw.Padding(
                                padding: pw.EdgeInsets.all(2.0),
                                child: pw.Column(children: [
                                  pw.Text(
                                    student.degreeStatus,
                                    style: pw.TextStyle(fontSize: 10.0),
                                  )
                                ]),
                              ),
                            ])
                        ],
                      ),
                      // ),
                      // ],
                    ),
                  ),
                ],
              ),
            );
          }));
    }

    void createExcel(var studentList) async {
      refreshStudents();
      final excel_sheet.Workbook workbook = excel_sheet.Workbook();
      final excel_sheet.Worksheet sheet = workbook.worksheets[0];

      //To extract value from future
      List<student.Student> students = await Future.value(studentList);

      var excelDataRows = students.map<excel_sheet.ExcelDataRow>((dataRow) {
        return excel_sheet.ExcelDataRow(cells: <excel_sheet.ExcelDataCell>[
          excel_sheet.ExcelDataCell(
              columnHeader: 'Name', value: dataRow.name ?? ' '),
          excel_sheet.ExcelDataCell(
              columnHeader: 'Age', value: dataRow.age ?? ' '),
          excel_sheet.ExcelDataCell(
              columnHeader: 'City', value: dataRow.city ?? ' '),
          excel_sheet.ExcelDataCell(
              columnHeader: 'Batch', value: dataRow.batch ?? ' '),
          excel_sheet.ExcelDataCell(
              columnHeader: 'Address', value: dataRow.address ?? ' '),
          excel_sheet.ExcelDataCell(
              columnHeader: 'Date Of Birth', value: dataRow.dateOfBirth ?? ' '),
          excel_sheet.ExcelDataCell(
              columnHeader: 'Father Name', value: dataRow.fatherName ?? ' '),
          excel_sheet.ExcelDataCell(
              columnHeader: 'Gender', value: dataRow.gender ?? ' '),
          excel_sheet.ExcelDataCell(
              columnHeader: 'Roll Number', value: dataRow.rollNumber ?? ' '),
          excel_sheet.ExcelDataCell(
              columnHeader: 'Degree Status',
              value: dataRow.degreeStatus ?? ' '),
        ]);
      }).toList();

      sheet.importData(excelDataRows, 1, 1);

      final List<int> bytes = workbook.saveAsStream();
      workbook.dispose();

      if (kIsWeb) {
        html.AnchorElement(
            href:
                'data:application/octet-stream;charset=utf-16le;base64,${base64.encode(bytes)}')
          ..setAttribute('download', 'Generated_Excel.xlsx')
          ..click();
      } else {
        final String path =
            (await path_provider.getApplicationSupportDirectory()).path;
        final String fileName = io.Platform.isWindows
            ? '$path\\Generated_Excel.xlsx'
            : '$path/Generated_Excel.xlsx';
        final io.File file = io.File(fileName);
        await file.writeAsBytes(bytes, flush: true);
        OpenFile.open(fileName);
      }
    }

    // Build a Form widget using the _formKey created above.
    return Container(
      child: SingleChildScrollView(
        child: ResponsiveGridRow(
          children: [
            ResponsiveGridCol(
              lg: 12,
              child: Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Text(
                    'ADD DETAILS',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Colors.blue),
                  ),
                ),
              ),
            ),
            ResponsiveGridCol(
              lg: 4,
              child: Padding(
                padding: const EdgeInsets.only(top: 15, left: 20, right: 20),
                child: TextField(
                  key: Key('Name'),
                  controller: NameController,
                  inputFormatters: [
                    WhitelistingTextInputFormatter(RegExp("[a-zA-Z ]")),
                  ],
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Name',
                    errorText:
                        _validateName ? 'Enter Correct Name Field' : null,
                  ),
                ),
              ),
            ),
            ResponsiveGridCol(
              lg: 4,
              child: Padding(
                padding: const EdgeInsets.only(top: 15, left: 20, right: 20),
                child: TextField(
                  key: Key('Age'),
                  controller: AgeController,
                  inputFormatters: [
                    WhitelistingTextInputFormatter(RegExp("[0-9]")),
                  ],
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Age',
                    errorText: _validateAge ? 'Enter Correct Age Field' : null,
                  ),
                ),
              ),
            ),
            ResponsiveGridCol(
              lg: 4,
              child: Padding(
                padding: const EdgeInsets.only(top: 15, left: 20, right: 20),
                child: TextField(
                  key: Key('City'),
                  controller: CityController,
                  inputFormatters: [
                    WhitelistingTextInputFormatter(RegExp("[a-zA-Z ]")),
                  ],
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'City',
                    errorText:
                        _validateCity ? 'Enter Correct City Field' : null,
                  ),
                ),
              ),
            ),
            ResponsiveGridCol(
              lg: 4,
              child: Padding(
                padding: const EdgeInsets.only(top: 15, left: 20, right: 20),
                child: TextField(
                  key: Key('Batch'),
                  controller: BatchController,
                  inputFormatters: [
                    WhitelistingTextInputFormatter(RegExp("[a-zA-Z0-9 ]")),
                  ],
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Batch',
                    errorText:
                        _validateBatch ? 'Enter Correct Batch Field' : null,
                  ),
                ),
              ),
            ),
            ResponsiveGridCol(
              lg: 4,
              child: Padding(
                padding: const EdgeInsets.only(top: 15, left: 20, right: 20),
                child: TextField(
                  key: Key('Address'),
                  controller: AddressController,
                  inputFormatters: [
                    WhitelistingTextInputFormatter(RegExp("[a-zA-Z0-9 ]")),
                  ],
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Address',
                    errorText:
                        _validateAddress ? 'Enter Correct Address Field' : null,
                  ),
                ),
              ),
            ),
            ResponsiveGridCol(
              lg: 4,
              child: Padding(
                padding: const EdgeInsets.only(top: 15, left: 20, right: 20),
                child: TextField(
                  key: Key('Date of Birth'),
                  controller: DateOfBirthController,
                  inputFormatters: [
                    WhitelistingTextInputFormatter(RegExp("[a-zA-Z0-9 ]")),
                  ],
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Date of Birth',
                    errorText: _validateDateOfBirth
                        ? 'Enter Correct Date of Birth Field'
                        : null,
                  ),
                ),
              ),
            ),
            ResponsiveGridCol(
              lg: 4,
              child: Padding(
                padding: const EdgeInsets.only(top: 15, left: 20, right: 20),
                child: TextField(
                  key: Key('Father Name'),
                  controller: FatherNameController,
                  inputFormatters: [
                    WhitelistingTextInputFormatter(RegExp("[a-zA-Z ]")),
                  ],
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Father Name',
                    errorText: _validateFatherName
                        ? 'Enter Correct Father Name Field'
                        : null,
                  ),
                ),
              ),
            ),
            ResponsiveGridCol(
              lg: 4,
              child: Padding(
                padding: const EdgeInsets.only(top: 15, left: 20, right: 20),
                child: TextField(
                  key: Key('Gender'),
                  controller: GenderController,
                  inputFormatters: [
                    WhitelistingTextInputFormatter(RegExp("[a-zA-Z ]")),
                  ],
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Gender',
                    errorText:
                        _validateGender ? 'Enter Correct Gender Field' : null,
                  ),
                ),
              ),
            ),
            ResponsiveGridCol(
              lg: 4,
              child: Padding(
                padding: const EdgeInsets.only(top: 15, left: 20, right: 20),
                child: TextField(
                  key: Key('Roll Number'),
                  controller: RollNumberController,
                  inputFormatters: [
                    WhitelistingTextInputFormatter(RegExp("[a-zA-Z0-9 ]")),
                  ],
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Roll Number',
                    errorText: _validateRollNumber
                        ? 'Enter Correct Roll Number Field'
                        : null,
                  ),
                ),
              ),
            ),
            ResponsiveGridCol(
              lg: 4,
              child: Align(
                alignment: Alignment.center,
                child: Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 15),
                    child:
                        FutureBuilder<countries_and_cities.CountriesAndCities>(
                            future: countriesAndCities,
                            // initialData: [],
                            builder: (context, AsyncSnapshot snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return CircularProgressIndicator();
                              } else if (snapshot.data != null) {
                                if (snapshot.hasData) {
                                  // Extracting countries from fetched data
                                  var extractedCountries = (snapshot.data.data)
                                      .map((e) => e.country)
                                      .toList();
                                  return DropdownButton<String>(
                                    isExpanded: true,
                                    hint: Text(
                                      "Country",
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    icon: const Icon(
                                      Icons.arrow_downward,
                                      color: Colors.grey,
                                    ),
                                    elevation: 16,
                                    style: const TextStyle(color: Colors.grey),
                                    underline: Container(
                                      height: 2,
                                      color: Colors.grey,
                                    ),
                                    value: countryDropDownValue,
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        countryDropDownValue = newValue!;

                                        var extractedObject =
                                            (snapshot.data.data)
                                                .where((e) =>
                                                    e.country.toString() ==
                                                    newValue.toString())
                                                .toList();

                                        extractedCityDropDownEntries =
                                            extractedObject[0].cities;
                                      });
                                      // refreshCityDropdown(newValue);
                                    },
                                    items: extractedCountries
                                        .map<DropdownMenuItem<String>>(
                                          (value) => DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value.toString()),
                                          ),
                                        )
                                        .toList(),
                                    disabledHint: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "Country",
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                    ),
                                  );
                                } else {
                                  return CircularProgressIndicator();
                                }
                              } else if (snapshot.hasError) {
                                return Text('${snapshot.error}');
                              }
                              // By default, show a loading spinner.
                              else {
                                return CircularProgressIndicator(); // loading
                              }
                            })),
              ),
            ),
            ResponsiveGridCol(
              lg: 4,
              child: Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.only(top: 15, left: 20, right: 20),
                  child: TextField(
                    key: Key('Degree Status'),
                    controller: DegreeStatusController,
                    inputFormatters: [
                      WhitelistingTextInputFormatter(RegExp("[a-zA-Z ]")),
                    ],
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Degree Status',
                      errorText: _validateDegreeStatus
                          ? 'Enter Correct Degree Status Field'
                          : null,
                    ),
                  ),
                ),
              ),
            ),
            ResponsiveGridCol(
              lg: 4,
              child: Align(
                alignment: Alignment.center,
                child: Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 15),
                    child: FutureBuilder<List<String>?>(
                        future: cityDropDownEntries,
                        initialData: [],
                        builder: (context, AsyncSnapshot snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          } else if (snapshot.data != null) {
                            if (snapshot.hasData) {
                              return DropdownButton<String>(
                                isExpanded: true,
                                hint: Text(
                                  "City",
                                  style: TextStyle(color: Colors.grey),
                                ),
                                icon: const Icon(
                                  Icons.arrow_downward,
                                  color: Colors.grey,
                                ),
                                elevation: 16,
                                style: const TextStyle(color: Colors.grey),
                                underline: Container(
                                  height: 2,
                                  color: Colors.grey,
                                ),
                                value: cityDropDownValue,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    cityDropDownValue = newValue!;
                                  });
                                },
                                items: extractedCityDropDownEntries
                                    .map<DropdownMenuItem<String>>(
                                        (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                disabledHint: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "City",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ),
                              );
                            } else {
                              return CircularProgressIndicator();
                            }
                          } else if (snapshot.hasError) {
                            return Text('${snapshot.error}');
                          }
                          // By default, show a loading spinner.
                          else {
                            return CircularProgressIndicator(); // loading
                          }
                        })),
              ),
            ),
            ResponsiveGridCol(
              lg: 12,
              child: Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.only(top: 15, bottom: 15),
                  child: SizedBox(
                    width: 150,
                    child: ElevatedButton(
                      key: Key('Add Record Button'),
                      onPressed: () {
                        extractCountries();
                        if (NameController.text.isEmpty ||
                            AgeController.text.isEmpty ||
                            CityController.text.isEmpty ||
                            BatchController.text.isEmpty ||
                            AddressController.text.isEmpty ||
                            DateOfBirthController.text.isEmpty ||
                            FatherNameController.text.isEmpty ||
                            GenderController.text.isEmpty ||
                            RollNumberController.text.isEmpty ||
                            DegreeStatusController.text.isEmpty) {
                          setState(() {
                            NameController.text.isEmpty
                                ? _validateName = true
                                : _validateName = false;
                            AgeController.text.isEmpty
                                ? _validateAge = true
                                : _validateAge = false;
                            CityController.text.isEmpty
                                ? _validateCity = true
                                : _validateCity = false;
                            BatchController.text.isEmpty
                                ? _validateBatch = true
                                : _validateBatch = false;
                            AddressController.text.isEmpty
                                ? _validateAddress = true
                                : _validateAddress = false;
                            DateOfBirthController.text.isEmpty
                                ? _validateDateOfBirth = true
                                : _validateDateOfBirth = false;
                            FatherNameController.text.isEmpty
                                ? _validateFatherName = true
                                : _validateFatherName = false;
                            GenderController.text.isEmpty
                                ? _validateGender = true
                                : _validateGender = false;
                            RollNumberController.text.isEmpty
                                ? _validateRollNumber = true
                                : _validateRollNumber = false;
                            DegreeStatusController.text.isEmpty
                                ? _validateDegreeStatus = true
                                : _validateDegreeStatus = false;
                          });
                        } else {
                          postStudents(
                              context,
                              NameController.text,
                              AgeController.text,
                              CityController.text,
                              BatchController.text,
                              AddressController.text,
                              DateOfBirthController.text,
                              FatherNameController.text,
                              GenderController.text,
                              RollNumberController.text,
                              DegreeStatusController.text,
                              refreshStudents);

                          setState(() {
                            _validateName = false;
                            _validateAge = false;
                            _validateCity = false;
                            _validateBatch = false;
                            _validateAddress = false;
                            _validateDateOfBirth = false;
                            _validateFatherName = false;
                            _validateGender = false;
                            _validateRollNumber = false;
                            _validateDegreeStatus = false;
                          });

                          NameController.clear();
                          AgeController.clear();
                          CityController.clear();
                          BatchController.clear();
                          AddressController.clear();
                          DateOfBirthController.clear();
                          FatherNameController.clear();
                          GenderController.clear();
                          RollNumberController.clear();
                          DegreeStatusController.clear();

                          // refreshStudents();
                        }
                      },
                      child: Text('Add Student'),
                    ),
                  ),
                ),
              ),
            ),
            ResponsiveGridCol(
              lg: 12,
              child: Align(
                alignment: Alignment.center,
                child: Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 15),
                    child: FutureBuilder<List<student.Student>>(
                        // initialData: initStudents,
                        future: futureStudent,
                        builder: (context, AsyncSnapshot snapshot) {
                          if (snapshot.data != null) {
                            if (snapshot.hasData) {
                              return SizedBox(
                                width: 150,
                                child: ElevatedButton(
                                  onPressed: () {
                                    createExcel(snapshot.data);
                                  },
                                  child: Text('Create Excel'),
                                ),
                              );
                            } else {
                              return CircularProgressIndicator();
                            }
                          } else if (snapshot.hasError) {
                            return Text('${snapshot.error}');
                          }
                          // By default, show a loading spinner.
                          else {
                            return CircularProgressIndicator(); // loading
                          }
                        })),
              ),
            ),
            ResponsiveGridCol(
              lg: 12,
              child: Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 15),
                  child: FutureBuilder<List<student.Student>>(
                      // initialData: initStudents,
                      future: futureStudent,
                      builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.data != null) {
                          if (snapshot.hasData) {
                            return SizedBox(
                              width: 150,
                              child: ElevatedButton(
                                key: Key('Generate PDF'),
                                onPressed: () async {
                                  refreshStudents();
                                  refreshPDF();

                                  createPDF(snapshot.data);
                                  final bytes = await pdf.save();
                                  final blob =
                                      html.Blob([bytes], 'application/pdf');

                                  final url =
                                      html.Url.createObjectUrlFromBlob(blob);
                                  final anchor = html.document
                                      .createElement('a') as html.AnchorElement
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
                              ),
                            );
                          } else {
                            return CircularProgressIndicator();
                          }
                        } else if (snapshot.hasError) {
                          return Text('${snapshot.error}');
                        }
                        // By default, show a loading spinner.
                        else {
                          return CircularProgressIndicator(); // loading
                        }
                      }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
