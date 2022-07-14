import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sense_task/Admin/assigntask_a.dart';
import 'package:sense_task/main.dart';

class taskpage_a extends StatefulWidget {
  const taskpage_a({Key? key}) : super(key: key);

  @override
  State<taskpage_a> createState() => _taskpage_aState();
}

class _taskpage_aState extends State<taskpage_a> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 500,
          width: 300,
          color: Colors.amber,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(categoryvalue),
              Text(startDateInString),
              Text(endDateInString),
              Text(dueDateInString),
              Text(tasktitle.text),
              Text(taskdescription.text),
              Text(facultyvalue)
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => taskassign_a()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
