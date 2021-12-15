// ignore_for_file: prefer_const_constructors, unnecessary_new, unused_import

import 'package:flutter/material.dart';
import 'services/apis.dart';
import 'package:http/http.dart' as http;
import 'models/student.dart' as student;
import './widgets/update_dialog.dart';
import 'dart:convert';
import '../models/post_student.dart' as post_student;
import './widgets/all_students.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    const appTitle = 'Flutter CRUD';
    return MaterialApp(
        title: appTitle,
        initialRoute: '/',
        routes: {
          '/all': (context) => const AllStudents(),
        },
        home: MyHome());
  }
}

class MyFlutterForm extends StatefulWidget {
  const MyFlutterForm({Key? key}) : super(key: key);

  @override
  State<MyFlutterForm> createState() => _MyFlutterFormState();
}

class _MyFlutterFormState extends State<MyFlutterForm> {
  final NameController = TextEditingController();
  final AgeController = TextEditingController();
  final CityController = TextEditingController();

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
        // Text("$_ctr"),
        ElevatedButton(
          onPressed: () {
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
      ],
    );
  }
}

class MyHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
          child: Container(
            color: Colors.white,
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                ListTile(
                  title: Text('All Students',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 18,
                      )),
                  contentPadding: EdgeInsets.fromLTRB(20, 5, 0, 5),
                  trailing: Icon(
                    Icons.arrow_right,
                    color: Colors.blue,
                  ),
                  onTap: () {
                    // Navigator.of(context).pop();
                    // Navigator.of(context).push(MaterialPageRoute(
                    //     builder: (BuildContext context) => AllStudents()));
                    Navigator.pushNamed(context, '/all');
                  },
                ),
              ],
            ),
          ),
        ),
        appBar: AppBar(
          title: const Text('Flutter CRUD'),
          leading: Builder(
            builder: (context) => IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: Icon(Icons.menu),
            ),
          ),
        ),
        body: const MyFlutterForm());
  }
}
