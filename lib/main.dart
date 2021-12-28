// ignore_for_file: prefer_const_constructors, unnecessary_new, unused_import

import 'package:flutter/material.dart';
import 'services/apis.dart';
import 'package:http/http.dart' as http;
import 'models/student.dart' as student;
import './widgets/update_dialog.dart';
import 'dart:convert';
import '../models/post_student.dart' as post_student;
import './widgets/all_students.dart';
import './widgets/drawer.dart';

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
        //Passing value to class/widget using constructor
        home: MyDrawer(
          testVar: "testVar passed from MyDrawer",
        ));
  }
}
