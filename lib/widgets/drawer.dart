// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import './add_student.dart';

class MyDrawer extends StatelessWidget {
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
        body: const AddStudent());
  }
}
