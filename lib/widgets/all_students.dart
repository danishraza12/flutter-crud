// ignore_for_file: prefer_const_constructors, deprecated_member_use, avoid_print

import '../models/student.dart' as student;
import 'package:flutter/material.dart';
import '../services/apis.dart';
import './update_dialog.dart';

class AllStudents extends StatefulWidget {
  const AllStudents({Key? key}) : super(key: key);

  @override
  State<AllStudents> createState() => _AllStudentsState();
}

class _AllStudentsState extends State<AllStudents> {
  late Future<List<student.Student>> futureStudent;

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

  @override
  void initState() {
    super.initState();
    futureStudent = fetchStudents();
  }

  void refreshStudents() {
    setState(() {
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
                return
                    // Center(
                    //   child: Container(
                    //     color: Colors.white,
                    //     height: MediaQuery.of(context).size.height,
                    //     child: SingleChildScrollView(
                    //       scrollDirection: Axis.vertical,
                    //       child: SingleChildScrollView(
                    //         scrollDirection: Axis.horizontal,
                    //         child: DataTable(
                    //           columns: <DataColumn>[
                    //             DataColumn(
                    //               label: Text(
                    //                 'Name',
                    //                 style: TextStyle(
                    //                     fontSize: 15.0,
                    //                     fontWeight: FontWeight.bold),
                    //               ),
                    //             ),
                    //             DataColumn(
                    //               label: Text(
                    //                 'Age',
                    //                 style: TextStyle(
                    //                     fontSize: 15.0,
                    //                     fontWeight: FontWeight.bold),
                    //               ),
                    //             ),
                    //             DataColumn(
                    //               label: Text(
                    //                 'City',
                    //                 style: TextStyle(
                    //                     fontSize: 15.0,
                    //                     fontWeight: FontWeight.bold),
                    //               ),
                    //             ),
                    //             DataColumn(
                    //               label: Text(
                    //                 'Batch',
                    //                 style: TextStyle(
                    //                     fontSize: 15.0,
                    //                     fontWeight: FontWeight.bold),
                    //               ),
                    //             ),
                    //             DataColumn(
                    //               label: Text(
                    //                 'Address',
                    //                 style: TextStyle(
                    //                     fontSize: 15.0,
                    //                     fontWeight: FontWeight.bold),
                    //               ),
                    //             ),
                    //             DataColumn(
                    //               label: Text(
                    //                 'Date Of Birth',
                    //                 style: TextStyle(
                    //                     fontSize: 15.0,
                    //                     fontWeight: FontWeight.bold),
                    //               ),
                    //             ),
                    //             DataColumn(
                    //               label: Text(
                    //                 'Father Name',
                    //                 style: TextStyle(
                    //                     fontSize: 15.0,
                    //                     fontWeight: FontWeight.bold),
                    //               ),
                    //             ),
                    //             DataColumn(
                    //               label: Text(
                    //                 'Gender',
                    //                 style: TextStyle(
                    //                     fontSize: 15.0,
                    //                     fontWeight: FontWeight.bold),
                    //               ),
                    //             ),
                    //             DataColumn(
                    //               label: Text(
                    //                 'Roll Number',
                    //                 style: TextStyle(
                    //                     fontSize: 15.0,
                    //                     fontWeight: FontWeight.bold),
                    //               ),
                    //             ),
                    //             DataColumn(
                    //               label: Text(
                    //                 'Degree Status',
                    //                 style: TextStyle(
                    //                     fontSize: 15.0,
                    //                     fontWeight: FontWeight.bold),
                    //               ),
                    //             ),
                    //           ],
                    //           rows: [
                    //             for (var student in snapshot.data)
                    //               DataRow(
                    //                 cells: <DataCell>[
                    //                   DataCell(Text(student.name)),
                    //                   DataCell(Text(student.age)),
                    //                   DataCell(Text(student.city)),
                    //                   DataCell(Text(student.batch)),
                    //                   DataCell(Text(student.address)),
                    //                   DataCell(Text(student.dateOfBirth)),
                    //                   DataCell(Text(student.fatherName)),
                    //                   DataCell(Text(student.gender)),
                    //                   DataCell(Text(student.rollNumber)),
                    //                   DataCell(Text(student.degreeStatus)),
                    //                 ],
                    //               ),
                    //           ],
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // );
                    Row(
                  children: <Widget>[
                    Expanded(
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height,
                        width: 200,
                        child: GridView.builder(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 180,
                                  childAspectRatio: 2 / 2.075,
                                  crossAxisSpacing: 20,
                                  mainAxisSpacing: 20),
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext ctxt, int index) {
                            return Card(
                                elevation: 4.0,
                                shadowColor: Colors.blue,
                                // margin: EdgeInsets.all(3),
                                shape: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        color: Colors.blue, width: 1)),
                                child: Column(
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      margin: const EdgeInsets.only(top: 16.0),
                                      child: Text(
                                        snapshot.data[index].name,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14.0),
                                      ),
                                    ),
                                    Divider(
                                      color: Colors.black,
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      child: Text(
                                        snapshot.data[index].age,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14.0,
                                            color:
                                                Colors.black.withOpacity(0.7)),
                                      ),
                                    ),
                                    Divider(
                                      color: Colors.black,
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      child: Text(
                                        snapshot.data[index].city,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14.0,
                                            color:
                                                Colors.black.withOpacity(0.7)),
                                      ),
                                    ),
                                    Divider(
                                      color: Colors.black,
                                    ),
                                    ListTile(
                                      title: Row(
                                        children: <Widget>[
                                          Expanded(
                                              child: FlatButton(
                                            onPressed: () async {
                                              deleteStudent(
                                                  context,
                                                  snapshot.data[index].id,
                                                  refreshStudents);
                                            },
                                            child: Text("Delete"),
                                            textColor: Colors.red,
                                            padding: EdgeInsets.symmetric(
                                                vertical: 1),
                                          )),
                                          Expanded(
                                              child: FlatButton(
                                            onPressed: () async {
                                              studentToUpdate.name =
                                                  snapshot.data[index].name;
                                              studentToUpdate.age =
                                                  snapshot.data[index].age;
                                              studentToUpdate.city =
                                                  snapshot.data[index].city;
                                              studentToUpdate.id =
                                                  snapshot.data[index].id;
                                              updateStudentDialog(
                                                  context,
                                                  studentToUpdate,
                                                  refreshStudents);
                                            },
                                            child: Text("Edit"),
                                            textColor: Colors.blue,
                                          )),
                                        ],
                                      ),
                                    )
                                  ],
                                ));
                          },
                        ),
                      ),
                    ),
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                );

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
