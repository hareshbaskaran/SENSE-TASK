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
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Assign Task')
            ///TODO: Add task assigning datas with setting parameters
            ///try ov-ai profile page and try to implement according to ui design 
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TabsScreen()),
          );
        },
        child: const Icon(Icons.done),
      ),
    );
  }
}
