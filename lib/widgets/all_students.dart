// ignore_for_file: prefer_const_constructors, deprecated_member_use, avoid_print, prefer_const_literals_to_create_immutables

import '../models/student.dart' as student;
import 'package:flutter/material.dart';
import '../services/apis.dart';
import './update_dialog.dart';

// List<student.Student> _data = [];

student.Student studentToUpdate = student.Student(
    name: "",
    age: "",
    city: "",
    id: null,
    batch: "",
    address: "",
    dateOfBirth: "",
    fatherName: "",
    gender: "",
    rollNumber: "",
    degreeStatus: "");

class AllStudents extends StatefulWidget {
  const AllStudents({Key? key}) : super(key: key);

  @override
  State<AllStudents> createState() => _AllStudentsState();
}

class _AllStudentsState extends State<AllStudents> {
  late int ctr;
  late Future<List<student.Student>> futureStudent;

  @override
  void initState() {
    super.initState();
    ctr = 0;
    futureStudent = fetchStudents();
  }

  void refreshStudents() {
    setState(() {
      ctr = 0;
      futureStudent = fetchStudents();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Students'),
      ),
      body: FutureBuilder<List<student.Student>>(
          // initialData: initStudents,
          future: futureStudent,
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.data != null) {
              if (snapshot.hasData) {
                return Column(children: [
                  //  Container(
                  //   color: Colors.white,
                  //   height: MediaQuery.of(context).size.height,
                  //   child: SingleChildScrollView(
                  //     scrollDirection: Axis.vertical,
                  //     child: SingleChildScrollView(
                  //       scrollDirection: Axis.horizontal,
                  // SizedBox(
                  //   height: 2,
                  // ),
                  SingleChildScrollView(
                    child: PaginatedDataTable(
                      sortAscending: true,
                      // header: Text('header'),
                      columns: <DataColumn>[
                        // DataColumn(
                        //   label: Text(
                        //     'S.No',
                        //     style: TextStyle(
                        //         fontSize: 15.0,
                        //         fontWeight: FontWeight.bold),
                        //   ),
                        // ),
                        DataColumn(
                          label: Text(
                            'Name',
                            style: TextStyle(
                                fontSize: 15.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Age',
                            style: TextStyle(
                                fontSize: 15.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'City',
                            style: TextStyle(
                                fontSize: 15.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Batch',
                            style: TextStyle(
                                fontSize: 15.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Address',
                            style: TextStyle(
                                fontSize: 15.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Date Of Birth',
                            style: TextStyle(
                                fontSize: 15.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Father Name',
                            style: TextStyle(
                                fontSize: 15.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Gender',
                            style: TextStyle(
                                fontSize: 15.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Roll Number',
                            style: TextStyle(
                                fontSize: 15.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Degree Status',
                            style: TextStyle(
                                fontSize: 15.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Action',
                            style: TextStyle(
                                fontSize: 15.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                      source: MyDataTableSource(snapshot.data),
                      columnSpacing: 100,
                      horizontalMargin: 10,
                      rowsPerPage: 8,
                      showCheckboxColumn: false,
                      // rows: [
                      //   for (var student in snapshot.data)
                      //     DataRow(
                      //       cells: <DataCell>[
                      //         DataCell(Text("${ctr += 1}.")),
                      //         DataCell(Text(student.name)),
                      //         DataCell(Text(student.age)),
                      //         DataCell(Text(student.city)),
                      //         DataCell(Text(student.batch)),
                      //         DataCell(Text(student.address)),
                      //         DataCell(Text(student.dateOfBirth)),
                      //         DataCell(Text(student.fatherName)),
                      //         DataCell(Text(student.gender)),
                      //         DataCell(Text(student.rollNumber)),
                      //         DataCell(Text(student.degreeStatus)),
                      //         DataCell(
                      //           Row(
                      //             children: <Widget>[
                      //               Padding(
                      //                 padding: EdgeInsets.only(right: 5),
                      //                 child: ElevatedButton(
                      //                     onPressed: () async {
                      //                       ctr = 0;
                      //                       studentToUpdate.name =
                      //                           student.name;
                      //                       studentToUpdate.age =
                      //                           student.age;
                      //                       studentToUpdate.city =
                      //                           student.city;
                      //                       studentToUpdate.id = student.id;
                      //                       studentToUpdate.batch =
                      //                           student.batch;
                      //                       studentToUpdate.address =
                      //                           student.address;
                      //                       studentToUpdate.dateOfBirth =
                      //                           student.dateOfBirth;
                      //                       studentToUpdate.fatherName =
                      //                           student.fatherName;
                      //                       studentToUpdate.gender =
                      //                           student.gender;
                      //                       studentToUpdate.rollNumber =
                      //                           student.rollNumber;
                      //                       studentToUpdate.degreeStatus =
                      //                           student.degreeStatus;
                      //                       updateStudentDialog(
                      //                           context,
                      //                           studentToUpdate,
                      //                           refreshStudents);
                      //                     },
                      //                     child: Text("Edit")),
                      //               ),
                      //               Padding(
                      //                 padding: EdgeInsets.only(left: 5),
                      //                 child: ElevatedButton(
                      //                     style: ButtonStyle(
                      //                       backgroundColor:
                      //                           MaterialStateProperty.all(
                      //                               Colors.red),
                      //                     ),
                      //                     onPressed: () async {
                      //                       deleteStudent(
                      //                           context,
                      //                           student.id,
                      //                           refreshStudents);
                      //                     },
                      //                     child: Text("Delete")),
                      //               ),
                      //             ],
                      //           ),
                      //         )
                      //       ],
                      //     ),
                      // ],
                    ),
                  ),
                  // ),
                  // ),
                ]);

                /* Card creation code for student list */

                //     Row(
                //   children: <Widget>[
                //     Expanded(
                //       child: SizedBox(
                //         height: MediaQuery.of(context).size.height,
                //         width: 200,
                //         child: GridView.builder(
                //           padding: EdgeInsets.symmetric(horizontal: 15),
                //           gridDelegate:
                //               const SliverGridDelegateWithMaxCrossAxisExtent(
                //                   maxCrossAxisExtent: 180,
                //                   childAspectRatio: 2 / 2.075,
                //                   crossAxisSpacing: 20,
                //                   mainAxisSpacing: 20),
                //           itemCount: snapshot.data.length,
                //           itemBuilder: (BuildContext ctxt, int index) {
                //             return Card(
                //               elevation: 4.0,
                //               shadowColor: Colors.blue,
                //               // margin: EdgeInsets.all(3),
                //               shape: OutlineInputBorder(
                //                   borderRadius: BorderRadius.circular(10),
                //                   borderSide:
                //                       BorderSide(color: Colors.blue, width: 1)),
                //               child: Column(
                //                 children: [
                //                   Container(
                //                     alignment: Alignment.center,
                //                     margin: const EdgeInsets.only(top: 16.0),
                //                     child: Text(
                //                       snapshot.data[index].name,
                //                       style: TextStyle(
                //                           fontWeight: FontWeight.bold,
                //                           fontSize: 14.0),
                //                     ),
                //                   ),
                //                   Divider(
                //                     color: Colors.black,
                //                   ),
                //                   Container(
                //                     alignment: Alignment.center,
                //                     child: Text(
                //                       snapshot.data[index].age,
                //                       style: TextStyle(
                //                           fontWeight: FontWeight.bold,
                //                           fontSize: 14.0,
                //                           color: Colors.black.withOpacity(0.7)),
                //                     ),
                //                   ),
                //                   Divider(
                //                     color: Colors.black,
                //                   ),
                //                   Container(
                //                     alignment: Alignment.center,
                //                     child: Text(
                //                       snapshot.data[index].city,
                //                       style: TextStyle(
                //                           fontWeight: FontWeight.bold,
                //                           fontSize: 14.0,
                //                           color: Colors.black.withOpacity(0.7)),
                //                     ),
                //                   ),
                //                   Divider(
                //                     color: Colors.black,
                //                   ),
                //                   ListTile(
                //                     title: Row(
                //                       children: <Widget>[
                //                         Expanded(
                //                             child: FlatButton(
                //                           onPressed: () async {
                //                             deleteStudent(
                //                                 context,
                //                                 snapshot.data[index].id,
                //                                 refreshStudents);
                //                           },
                //                           child: Text("Delete"),
                //                           textColor: Colors.red,
                //                           padding:
                //                               EdgeInsets.symmetric(vertical: 1),
                //                         )),
                //                         Expanded(
                //                             child: FlatButton(
                //                           onPressed: () async {
                //                             studentToUpdate.name =
                //                                 snapshot.data[index].name;
                //                             studentToUpdate.age =
                //                                 snapshot.data[index].age;
                //                             studentToUpdate.city =
                //                                 snapshot.data[index].city;
                //                             studentToUpdate.id =
                //                                 snapshot.data[index].id;
                //                             studentToUpdate.batch =
                //                                 snapshot.data[index].batch;
                //                             studentToUpdate.address =
                //                                 snapshot.data[index].address;
                //                             studentToUpdate.dateOfBirth =
                //                                 snapshot
                //                                     .data[index].dateOfBirth;
                //                             studentToUpdate.fatherName =
                //                                 snapshot.data[index].fatherName;
                //                             studentToUpdate.gender =
                //                                 snapshot.data[index].gender;
                //                             studentToUpdate.rollNumber =
                //                                 snapshot.data[index].rollNumber;
                //                             studentToUpdate.degreeStatus =
                //                                 snapshot
                //                                     .data[index].degreeStatus;
                //                             updateStudentDialog(
                //                                 context,
                //                                 studentToUpdate,
                //                                 refreshStudents);
                //                           },
                //                           child: Text("Edit"),
                //                           textColor: Colors.blue,
                //                         )),
                //                       ],
                //                     ),
                //                   )
                //                 ],
                //               ),
                //             );
                //           },
                //         ),
                //       ),
                //     ),
                //   ],
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // );

                // Row ends here

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
    );
  }
}

class MyDataTableSource extends DataTableSource {
  MyDataTableSource(this.data);

  final List<student.Student> data;

  @override
  DataRow? getRow(int index) {
    if (index >= data.length) {
      return null;
    }
    for (int i = 0; i < data.length; i++) {
      return DataRow.byIndex(
        index: index,
        cells: [
          DataCell(Text('${data[i].name}')),
          DataCell(Text('${data[i].age}')),
          DataCell(Text('${data[i].city}')),
          DataCell(Text('${data[i].batch}')),
          DataCell(Text('${data[i].address}')),
          DataCell(Text('${data[i].dateOfBirth}')),
          DataCell(Text('${data[i].fatherName}')),
          DataCell(Text('${data[i].gender}')),
          DataCell(Text('${data[i].rollNumber}')),
          DataCell(Text('${data[i].degreeStatus}')),
          DataCell(
            Row(
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(right: 5),
                    child: ElevatedButton(
                      child: Text('Edit'),
                      onPressed: () async {
                        studentToUpdate.name = data[i].name;
                        studentToUpdate.age = data[i].age;
                        studentToUpdate.city = data[i].city;
                        studentToUpdate.id = data[i].id;
                        studentToUpdate.batch = data[i].batch;
                        studentToUpdate.address = data[i].address;
                        studentToUpdate.dateOfBirth = data[i].dateOfBirth;
                        studentToUpdate.fatherName = data[i].fatherName;
                        studentToUpdate.gender = data[i].gender;
                        studentToUpdate.rollNumber = data[i].rollNumber;
                        studentToUpdate.degreeStatus = data[i].degreeStatus;
                        // updateStudentDialog(
                        //     context, studentToUpdate, refreshStudents);
                      },
                    )),
                Padding(
                  padding: EdgeInsets.only(left: 5),
                  child: ElevatedButton(
                    child: Text("Delete"),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.red),
                    ),
                    onPressed: () async {
                      //   deleteStudent(
                      //       context,
                      //       student.id,
                      //       refreshStudents);
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      );
    }
  }

  @override
  int get selectedRowCount {
    return 0;
  }

  @override
  bool get isRowCountApproximate {
    return false;
  }

  @override
  int get rowCount {
    return data.length;
  }
}
