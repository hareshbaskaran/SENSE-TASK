import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sense_task/main.dart';
import 'AssignTask_Admin.dart';

class taskpage_a extends StatefulWidget {
  const taskpage_a({Key? key}) : super(key: key);

  @override
  State<taskpage_a> createState() => _taskpage_aState();
}

class _taskpage_aState extends State<taskpage_a> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          shrinkWrap: true,
          itemCount: allTasks.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
              child: allTasks[index],
            );
          }),
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

class Taskbox extends StatelessWidget {
  Taskbox({
    required this.category,
    required this.title,
    required this.description,
    required this.startdate,
    required this.enddate,
    required this.duedate,
    required this.duetime,
    required this.faculty,
  });

  String category;
  String title;
  String description;
  String startdate;
  String enddate;
  String duedate;
  String duetime;
  String faculty;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: new BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          border: Border.all(width: 2.0),
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            smalltext(text: 'Task Category'),
            standardtext(text: category),
            smalltext(text: 'Task Title'),
            standardtext(text: title),
            smalltext(text: 'Task Description'),
            standardtext(text: description),
            smalltext(text: 'Start date'),
            standardtext(text: startdate),
            smalltext(text: 'End date'),
            standardtext(text: enddate),
            smalltext(text: 'Due date'),
            standardtext(text: duedate),
            smalltext(text: 'Due time'),
            standardtext(text: duetime),
            smalltext(text: 'Faculty'),
            standardtext(text: faculty),
          ],
        ),
      ),
    );
  }
}

class standardtext extends StatelessWidget {
  String text;
  standardtext({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        textAlign: TextAlign.left,
        style: GoogleFonts.lato(
            color: Colors.black,
            fontSize: MediaQuery.of(context).size.width * 0.05),
      ),
    );
  }
}

class smalltext extends StatelessWidget {
  String text;
  smalltext({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        textAlign: TextAlign.center,
        text,
        style: GoogleFonts.lato(
            color: Colors.black,
            fontSize: MediaQuery.of(context).size.width * 0.03),
      ),
    );
  }
}
