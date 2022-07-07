import 'package:flutter/material.dart';
import 'package:sense_task/main.dart';
import 'package:sense_task/taskpage_a.dart';
class taskassign_a extends StatefulWidget {
  const taskassign_a({Key? key}) : super(key: key);

  @override
  State<taskassign_a> createState() => _taskassign_aState();
}

class _taskassign_aState extends State<taskassign_a> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Center(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('data'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => taskpage_a()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
