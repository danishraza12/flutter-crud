// ignore_for_file: prefer_const_constructors, unnecessary_new, deprecated_member_use, non_constant_identifier_names, unused_local_variable

import 'package:flutter/material.dart';
import '../models/student.dart' as student;
import '../services/apis.dart';

void updateStudentDialog(BuildContext context, student.Student studentToUpdate,
    Function refresh) async {
  final UpdateNameController = TextEditingController();
  final UpdateAgeController = TextEditingController();
  final UpdateCityController = TextEditingController();

  UpdateNameController.text = studentToUpdate.name.toString();
  UpdateAgeController.text = studentToUpdate.age.toString();
  UpdateCityController.text = studentToUpdate.city.toString();
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Center(
              child: Text(
            'Update Student',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 20, color: Colors.blue),
          )),
          insetPadding: EdgeInsets.symmetric(horizontal: 50, vertical: 50),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 1, vertical: 12),
                child: TextField(
                  controller: UpdateNameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Name',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 1, vertical: 12),
                child: TextField(
                  controller: UpdateAgeController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Age',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 1, vertical: 12),
                child: TextField(
                  controller: UpdateCityController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'City',
                  ),
                ),
              ),
            ],
          ),
          actions: <Widget>[
            FlatButton(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
            FlatButton(
                child: Text('Update'),
                textColor: Colors.blue,
                onPressed: () async {
                  student.Student updatedStudent = new student.Student(
                      id: studentToUpdate.id,
                      name: UpdateNameController.text,
                      age: UpdateAgeController.text,
                      city: UpdateCityController.text);
                  await updateStudent(updatedStudent);
                  refresh();
                  Navigator.pop(context, false);
                })
          ],
        );
      });
}
// }
