import '../models/student.dart' as student;
import '../models/post_student.dart' as post_student;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';

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

//Function to CREATE new student
void postStudents(
    BuildContext context, String name, String age, String city) async {
  Map data = {'name': name, 'age': age, 'city': city};
  String body = json.encode(data);

  http.Response response = await http.post(
    Uri.parse('https://localhost:7175/api/CRUD'),
    headers: {"Content-Type": "application/json"},
    body: body,
  );

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
}

//Function to UPDATE student
Future<student.Student> updateStudent(
    String id, student.Student updateStudent) async {
  String url = 'https://localhost:7175/api/CRUD/$id';

  final response = await http.put(
    Uri.parse(url),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String?>{
      'name': updateStudent.name,
      'age': updateStudent.age,
      'city': updateStudent.city
    }),
  );

  if (response.statusCode == 200) {
    return student.Student.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to update student.');
  }
}

//Function to DELETE student
Future<post_student.PostStudent> deleteStudent(context, int id) async {
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

// dynamic postStudents(String name, String age, String city) async {
//   Map data = {'name': name, 'age': age, 'city': city};
//   String body = json.encode(data);

//   http.Response response = await http.post(
//     Uri.parse('https://localhost:7175/api/CRUD'),
//     headers: {"Content-Type": "application/json"},
//     body: body,
//   );


  // if (response.statusCode == 200) {
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return const AlertDialog(
  //         content: Text('Successfully saved the data'),
  //       );
  //     },
  //   );
  // }

  //   return response;
// }

// Future<post_student.PostStudent> createPost(String url,
//     {required Map body}) async {
//   return http.post(Uri.parse(url), body: body).then((http.Response response) {
//     final int statusCode = response.statusCode;

//     if (statusCode < 200 || statusCode > 400) {
//       throw Exception("Error while fetching data");
//     }
//     return post_student.PostStudent.fromJson(json.decode(response.body));
//   });
// }

// Future<post_student.PostStudent> createPost(String url,
//     {required Map body}) async {
//   http.Response response = await http.post(Uri.parse(url), body: body);
//   final int statusCode = response.statusCode;

//   if (statusCode < 200 || statusCode > 400) {
//     throw Exception("Error while fetching data");
//   }
//   return post_student.PostStudent.fromJson(json.decode(response.body));
// }
