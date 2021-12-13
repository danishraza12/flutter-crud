import '../models/student.dart' as student;
import '../models/post_student.dart' as post_student;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';

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
          content: Text('Successfully saved the data'),
        );
      },
    );
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
