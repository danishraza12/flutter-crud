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

  student.Student studentToUpdate =
      student.Student(name: "", age: "", city: "", id: null);

  @override
  void initState() {
    super.initState();
    futureStudent = fetchStudents();
  }

  void refreshStudents() {
    print("In refresh");
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
                return Row(
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
                                  childAspectRatio: 5 / 4,
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
                                      child: Text(snapshot.data[index].name),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      child: Text(snapshot.data[index].age),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      child: Text(snapshot.data[index].city),
                                    ),
                                    ListTile(
                                      title: Row(
                                        children: <Widget>[
                                          Expanded(
                                              child: FlatButton(
                                            onPressed: () async {
                                              print(
                                                  "Delete pressed, ID: ${snapshot.data[index].id}");

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
                                            onPressed: () {
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
