import 'package:flutter/material.dart';
import 'package:sense_task/assigntask_a.dart';
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => taskassign_a()),
          );
        },///
        child: const Icon(Icons.add),
      ),
    );
  }
}
