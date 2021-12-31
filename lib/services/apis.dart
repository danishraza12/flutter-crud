import '../models/student.dart' as student;
import '../models/post_student.dart' as post_student;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import '../models/countries.dart' as countries;
import '../models/cities.dart' as cities;

// Function to GET all students
Future<List<student.Student>> fetchStudents() async {
  final response = await http.get(Uri.parse('https://localhost:7175/api/CRUD'),
      headers: {
        "Accept": "application/json",
        "Access-Control_Allow_Origin": "*"
      });

  if (response.statusCode == 200) {
    //Extracting list from model
    List<student.Student> students = List<student.Student>.from(json
        .decode(response.body)
        .map((data) => student.Student.fromJson(data)));
    return students;
  } else {
    throw Exception('Failed to load students');
  }
}

// Function to GET students by ID
Future<student.Student> getStudentById(int id) async {
  String url = 'https://localhost:7175/api/CRUD/$id';
  final response = await http.get(Uri.parse(url), headers: {
    "Accept": "application/json",
    "Access-Control_Allow_Origin": "*"
  });

  student.Student getStudent =
      student.Student.fromJson(json.decode(response.body));

  if (response.statusCode == 200) {
    return getStudent;
  } else {
    throw Exception('Failed to update student.');
  }
}

//Function to CREATE new student
Future<post_student.PostStudent> postStudents(
    BuildContext context,
    String name,
    String age,
    String city,
    String batch,
    String address,
    String dateOfBirth,
    String fatherName,
    String gender,
    String rollNumber,
    String degreeStatus,
    Function refresh) async {
  Map data = {
    'name': name,
    'age': age,
    'city': city,
    'batch': batch,
    'address': address,
    'dateOfBirth': dateOfBirth,
    'fatherName': fatherName,
    'gender': gender,
    'rollNumber': rollNumber,
    'degreeStatus': degreeStatus
  };
  String body = json.encode(data);

  http.Response response = await http.post(
    Uri.parse('https://localhost:7175/api/CRUD'),
    headers: {"Content-Type": "application/json"},
    body: body,
  );

  post_student.PostStudent postStudent =
      post_student.PostStudent.fromJson(json.decode(response.body));

  refresh();
  if (response.statusCode == 200) {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          title: Text('Message!'),
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
          content: Text('Successfully saved the data'),
          contentTextStyle: TextStyle(
            color: Colors.green,
            fontSize: 15.0,
          ),
        );
      },
    );
  }
  return postStudent;
}

//Function to UPDATE student
Future<student.Student> updateStudent(student.Student updatedStudent) async {
  String url = 'https://localhost:7175/api/CRUD';
  Map data = {
    'id': updatedStudent.id,
    'name': updatedStudent.name,
    'age': updatedStudent.age,
    'city': updatedStudent.city,
    'batch': updatedStudent.batch,
    'address': updatedStudent.address,
    'dateOfBirth': updatedStudent.dateOfBirth,
    'fatherName': updatedStudent.fatherName,
    'gender': updatedStudent.gender,
    'rollNumber': updatedStudent.rollNumber,
    'degreeStatus': updatedStudent.degreeStatus
  };
  String body = json.encode(data);

  final response = await http.put(Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: body);

  if (response.statusCode == 200) {
    return student.Student.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to update student.');
  }
}

//Function to DELETE student
Future<post_student.PostStudent> deleteStudent(
    context, int id, Function refresh) async {
  String url = 'https://localhost:7175/api/CRUD/$id';

  final http.Response response = await http.delete(
    Uri.parse(url),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );

  post_student.PostStudent deleteResponse =
      post_student.PostStudent.fromJson(json.decode(response.body));
  if (deleteResponse.statusCode == "200") {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          title: Text('Message!'),
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
          content: Text('Successfully deleted data'),
          contentTextStyle: TextStyle(
            color: Colors.green,
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
          ),
        );
      },
    );
    refresh();
    return post_student.PostStudent.fromJson(jsonDecode(response.body));
  } else {
    if (deleteResponse.statusMessage!.isEmpty) {
      String msg = deleteResponse.statusMessage.toString();
    }
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          title: Text('Message!'),
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
          content: Text("Unable to delete"),
          contentTextStyle: TextStyle(
            color: Colors.orange,
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
          ),
        );
      },
    );
    return post_student.PostStudent.fromJson(jsonDecode(response.body));
  }
}

// Functions to GET all countries / Country list API
Future<List<String>?> getAllCountries() async {
  final response = await http
      .get(Uri.parse('https://localhost:7079/api/Country'), headers: {
    "Accept": "application/json",
    "Access-Control_Allow_Origin": "*"
  });

  if (response.statusCode == 200) {
    final parsed = json.decode(response.body);

    return countries.CountryModel.fromJson(parsed).countries;
  } else {
    throw Exception('Failed to load countries');
  }
}

// Functions to GET all Cities list API
Future<List<String>?> getCities(String? country) async {
  Map data = {'country': country};
  final response =
      await http.post(Uri.parse('https://localhost:7079/api/Country'),
          headers: {
            "Accept": "application/json",
            "Access-Control_Allow_Origin": "*",
            "Content-Type": "application/json"
          },
          body: json.encode(data));

  if (response.statusCode == 200) {
    final parsed = json.decode(response.body);

    return cities.CitiesModel.fromJson(parsed).cities;
  } else {
    throw Exception('Failed to load cities');
  }
}
