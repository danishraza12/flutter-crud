// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  bool _validate1 = false;
  bool _validate2 = false;
  bool _validate3 = false;

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
          margin: EdgeInsets.symmetric(horizontal: 35, vertical: 12),
          child: TextField(
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
        // Text("$_ctr"),
        ElevatedButton(
          onPressed: () {
            print("Post Button clicked");
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
      ],
    );
  }
}
