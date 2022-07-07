import 'package:flutter/material.dart';
import 'package:sense_task/assigntask_a.dart';
import 'package:sense_task/taskpage_a.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '',
      theme: ThemeData(
        primaryColor: Colors.black,
      ),
      home: taskpage_a(),
    );
  }
}



