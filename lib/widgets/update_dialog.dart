import 'package:flutter/material.dart';
import '../models/student.dart' as student;
import 'dart:convert';
import '../services/apis.dart';

void updateStudentDialog(
    BuildContext context, student.Student studentToUpdate) async {
  final UpdateNameController = TextEditingController();
  final UpdateAgeController = TextEditingController();
  final UpdateCityController = TextEditingController();
  late Future<student.Student> _updateStudent;

  UpdateNameController.text = studentToUpdate.name.toString();
  UpdateAgeController.text = studentToUpdate.age.toString();
  UpdateCityController.text = studentToUpdate.city.toString();
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Update Student'),
          content: Column(
            children: <Widget>[
              TextField(
                controller: UpdateNameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Name',
                ),
              ),
              TextField(
                controller: UpdateAgeController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Age',
                ),
              ),
              TextField(
                controller: UpdateCityController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'City',
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    student.Student updatedStudent = new student.Student(
                        id: studentToUpdate.id,
                        name: UpdateNameController.text,
                        age: UpdateAgeController.text,
                        city: UpdateCityController.text);
                    // String body = json.encode(updatedStudent);
                    _updateStudent = updateStudent(updatedStudent);
                  },
                  child: Text("Update"))
            ],
          ),
        );
      });
}
