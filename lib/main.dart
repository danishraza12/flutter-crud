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
    const appTitle = 'Flutter CRUD';
    return MaterialApp(
        title: appTitle,
        home: Scaffold(
            drawer: new Drawer(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(top: 25),
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text("Test Button"),
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Text('v1.1'),
                    ),
                  ),
                ],
              ),
            ),
            appBar: AppBar(
              title: const Text(appTitle),
              leading: Builder(
                builder: (context) => IconButton(
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  icon: Icon(Icons.menu),
                ),
              ),
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
  final _formKey = GlobalKey<FormState>();
  late Future<List<student.Student>> futureStudent;

  @override
  void initState() {
    super.initState();
    futureStudent = fetchStudents();
  }

  final NameController = TextEditingController();
  final AgeController = TextEditingController();
  final CityController = TextEditingController();
  late Future<student.Student> _updateStudent;

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 15, left: 20),
          child: Text(
            'ADD DETAILS',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 30, color: Colors.blue),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 35, vertical: 12),
          child: TextField(
            controller: NameController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Name',
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 35, vertical: 12),
          child: TextField(
            controller: AgeController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Age',
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 35, vertical: 12),
          child: TextField(
            controller: CityController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'City',
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () async {
            print("Post Button clicked");
            if (NameController.text.isEmpty ||
                AgeController.text.isEmpty ||
                CityController.text.isEmpty) {
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
              postStudents(context, NameController.text, AgeController.text,
                  CityController.text);
              NameController.clear();
              AgeController.clear();
              CityController.clear();
            }
          },
          child: Text('Add Student'),
        ),
        FutureBuilder<List<student.Student>>(
            future: futureStudent,
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.data != null) {
                if (snapshot.hasData) {
                  return Row(
                    children: <Widget>[
                      Expanded(
                        child: SizedBox(
                          height: 200,
                          width: 200,
                          child: new GridView.builder(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            gridDelegate:
                                const SliverGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent: 200,
                                    childAspectRatio: 3 / 2,
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
                                        margin:
                                            const EdgeInsets.only(top: 16.0),
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
                                              onPressed: () {
                                                Future<post_student.PostStudent>
                                                    delete_student =
                                                    deleteStudent(
                                                        context, '1005');
                                              },
                                              child: Text("Delete"),
                                              textColor: Colors.red,
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 1),
                                            )),
                                            Expanded(
                                                child: FlatButton(
                                              onPressed: () {
                                                student.Student data =
                                                    new student.Student(
                                                        name:
                                                            NameController.text,
                                                        age: AgeController.text,
                                                        city: CityController
                                                            .text);
                                                String body = json.encode(data);
                                                _updateStudent =
                                                    updateStudent('5', data);
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
                  return CircularProgressIndicator(); // loading
                }
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.

              else {
                return CircularProgressIndicator(); // loading
              }
            })
      ],
    );
  }
}
