// ignore_for_file: prefer_const_constructors, unnecessary_new

import 'package:flutter/material.dart';
import 'services/apis.dart';
import 'package:http/http.dart' as http;
import 'models/student.dart' as student;
import 'dart:convert';
import '../models/post_student.dart' as post_student;

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    const appTitle = 'Flutter Form';
    return MaterialApp(
        title: appTitle,
        home: Scaffold(
            appBar: AppBar(
              title: const Text(appTitle),
            ),
            body: const MyFlutterForm()));
  }
}

class MyFlutterForm extends StatefulWidget {
  const MyFlutterForm({Key? key}) : super(key: key);

  @override
  State<MyFlutterForm> createState() => _MyFlutterFormState();
}

class _MyFlutterFormState extends State<MyFlutterForm> {
  var nameController = new TextEditingController();
  var ageController = new TextEditingController();
  var cityController = new TextEditingController();

  late Future<List<student.Student>> futureStudents;

  // @override
  // void setState(VoidCallback fn) {
  //   // TODO: implement setState
  //   super.setState(fn);
  // }

  @override
  void initState() {
    super.initState();
    futureStudents = fetchStudents();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    nameController.dispose();
    ageController.dispose();
    cityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: Text(
            'Add Information',
            style: TextStyle(
                color: Colors.blue, fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          // child: TextField(
          child: TextFormField(
            controller: nameController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Enter name',
              labelStyle: TextStyle(color: Colors.grey),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextFormField(
            // child: TextField(
            controller: ageController,
            decoration: const InputDecoration(
              // border: UnderlineInputBorder(),
              border: OutlineInputBorder(),
              labelText: 'Enter age',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextFormField(
            // child: TextField(
            controller: cityController,
            decoration: const InputDecoration(
              // border: UnderlineInputBorder(),
              border: OutlineInputBorder(),
              labelText: 'Enter city',
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () async {
            print("Post Button clicked");
            if (nameController.text.isEmpty ||
                ageController.text.isEmpty ||
                cityController.text.isEmpty) {
              showDialog(
                context: context,
                builder: (context) {
                  return const AlertDialog(
                    title: Text(
                      'Warning!',
                      textAlign: TextAlign.center,
                    ),
                    content: Text('Enter all values'),
                    contentTextStyle: TextStyle(
                      color: Colors.blue,
                      fontSize: 15,
                    ),
                    titleTextStyle: TextStyle(
                        color: Colors.orange,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  );
                },
              );
            } else {
              postStudents(context, nameController.text, ageController.text,
                  cityController.text);
              nameController.clear();
              ageController.clear();
              cityController.clear();
            }
          },
          child: Text('Add Student'),
        ),
        Padding(
          padding: EdgeInsets.all(16.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(primary: Colors.red),
            onPressed: () async {
              print("Delete button clicked");
              Future<post_student.PostStudent> delete_student =
                  deleteStudent(context, '2012');
            },
            child: Text('Delete Student'),
          ),
        ),
        FutureBuilder<List<student.Student>>(
          future: futureStudents,
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.data != null) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              } else {
                return Row(
                  children: <Widget>[
                    Expanded(
                      child: SizedBox(
                        height: 200.0,
                        child: new GridView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2),
                          itemBuilder: (BuildContext ctxt, int index) {
                            // return new Text(snapshot.data[index].name);
                            return new Card(
                              child: new GridTile(
                                  child: Text(snapshot.data[index].name)),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                );
              }
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
        // FutureBuilder<post_student.PostStudent>(
        //     future: postStudent,
        //     builder: (context, AsyncSnapshot snapshot) {
        //       if (snapshot.data != null) {
        //         if (!snapshot.hasData) {
        //           return Center(child: CircularProgressIndicator());
        //         } else {
        //           //  print(response.toString());
        //           if (snapshot.data.statusCode == "200") {
        //             showDialog(
        //               context: context,
        //               builder: (context) {
        //                 return AlertDialog(
        //                   // Retrieve the text the user has entered by using the
        //                   // TextEditingController.
        //                   content: Text('Successfully saved the data'),
        //                 );
        //               },
        //             );
        //           }
        //           return Text('data');
        //         }
        //       } else {
        //         return Center(child: CircularProgressIndicator());
        //       }
        //     }),
      ],
    );
  }
}
