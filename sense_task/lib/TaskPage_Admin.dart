import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sense_task/main.dart';
import 'AssignTask_Admin.dart';
import 'package:rounded_expansion_tile/rounded_expansion_tile.dart';

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
        child: Card(
          elevation: 0,
          color: Colors.white,
          child: RoundedExpansionTile(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4)),
            title: Text(category),
            children: [
              for (var i = 0; i < 5; i++)
                ListTile(
                  title: Text('Child $i'),
                )
            ],
          ),
        ));
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
/*            smalltext(text: 'Task Category'),
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
            standardtext(text: faculty),*/

/* Widget _buildList(Menu list) {
    if (list.subMenu.isEmpty)
      return Builder(
        builder: (context) {
          return ListTile(
              onTap:() => Navigator.push(context, MaterialPageRoute(builder: (context) => SubCategory(list.name))),
              leading: SizedBox(),
              title: Text(list.name)
          );
        }
      );
    return ExpansionTile(
      leading: Icon(list.icon),
      title: Text(
        list.name,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      children: list.subMenu.map(_buildList).toList(),
    );
  }
}*/

/*  child:ExpansionTileCard(
          //baseColor:
            //expandedColor:
            key: cardA,
            title: Text(title),
            subtitle: Row(
              children: [
                standardtext(text: category),
                SizedBox(   width: MediaQuery.of(context).size.width * 0.025),
                standardtext(text: duedate),
                SizedBox(   width: MediaQuery.of(context).size.width * 0.025),
                standardtext(text: duetime),

              ],
            ),
            children: <Widget>[
              Divider(
                thickness: 1.0,
                height: 1.0,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  child: Text(
                    description
                  )
                ),
              ),
              ButtonBar(
                alignment: MainAxisAlignment.spaceAround,
                buttonHeight: 52.0,
                buttonMinWidth: 90.0,
                children: <Widget>[
                  ///implement edit view button and accept n reject button
                ],
              ),
            ],
          ),*/
