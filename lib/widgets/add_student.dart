// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../services/apis.dart';

class AddStudent extends StatefulWidget {
  const AddStudent({Key? key}) : super(key: key);

  @override
  State<AddStudent> createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {
  final NameController = TextEditingController();
  final AgeController = TextEditingController();
  final CityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
          margin: new EdgeInsets.symmetric(horizontal: 35, vertical: 12),
          child: TextField(
            controller: NameController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Name',
            ),
          ),
        ),
        Container(
          width: 300,
          margin: new EdgeInsets.symmetric(horizontal: 35, vertical: 12),
          alignment: Alignment.center,
          child: TextField(
            controller: AgeController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Age',
            ),
          ),
        ),
        Container(
          width: 300,
          margin: new EdgeInsets.symmetric(horizontal: 35, vertical: 12),
          alignment: Alignment.center,
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
