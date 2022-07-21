import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sense_task/main.dart';
import 'package:sense_task/mangodb.dart';
import 'AssignTask_Admin.dart';
import 'package:rounded_expansion_tile/rounded_expansion_tile.dart';

import 'LoginPage.dart';

class taskpage_a extends StatefulWidget {
  const taskpage_a({Key? key}) : super(key: key);

  @override
  State<taskpage_a> createState() => _taskpage_aState();
}

/*class _taskpage_aState extends State<taskpage_a> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
            shrinkWrap: true,
            itemCount: allTasks.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
                child: Column(
                  children: [
                    ///todo : add date pick,weekly or 3day picker and faculty querry with ternary for admin n staff
                    allTasks[index],
                  ],
                ),
              );
            }),
        floatingActionButton: _floating(context));
  }
}*/
class _taskpage_aState extends State<taskpage_a> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: FutureBuilder(
            future: TaskMangoDB.getTask(),
            builder: (context,AsyncSnapshot snapshot){
                if(snapshot.connectionState == ConnectionState.waiting){
                  print('connection waiting');
                 return Center(
                    child: CircularProgressIndicator(),
                  );}
                  else {
                    if(snapshot.hasData){
                      var taskdata = snapshot.data.length;
                      print('TOTAL TASK : ' + taskdata.toString());
                      return Text('Data Found');
                    }else{
                      return Center(
                        child: Text(
                          'NO data Available'
                        ),
                      );
                    }
                }
              }
          ),
        )
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
        trailing: Icon(
          Icons.arrow_drop_down_outlined,
          color: Colors.black,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            largetext(text: title),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                standardtext(text: category),
                (adminpage == 1)
                    ? largetext(text: faculty)
                    : SizedBox(height: 0)
              ],
            )
          ],
        ),
        subtitle: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              standardtext(text: 'Due Date: $duedate'),
              standardtext(text: 'Due Time: $duetime'),
            ],
          ),
        ),
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              largetext(text: 'Description:'),
              standardtext(text: description),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  standardtext(text: 'Event start Date: $startdate'),
                  standardtext(text: 'Event end Date: $enddate'),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.025),
              (adminpage == 1)
                  ? Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    elevation: 5.0,
                                    shape: StadiumBorder(),
                                    primary: Colors.black),
                                onPressed: () {},

                                ///add edit onpressed
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(
                                      MediaQuery.of(context).size.height * 0.04,
                                      12,
                                      MediaQuery.of(context).size.height * 0.04,
                                      12),
                                  child: Text(
                                    'Edit',
                                    style: GoogleFonts.lato(
                                        color: Colors.white,
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                0.02),
                                  ),
                                )),
                          ),
                        ],
                      ),
                    )
                  : Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  elevation: 5.0,
                                  shape: StadiumBorder(),
                                  primary: Colors.black),
                              onPressed: () {},

                              ///add accept onpressed
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(
                                    MediaQuery.of(context).size.height * 0.04,
                                    12,
                                    MediaQuery.of(context).size.height * 0.04,
                                    12),
                                child: Text(
                                  'Accept',
                                  style: GoogleFonts.lato(
                                      color: Colors.white,
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              0.02),
                                ),
                              )),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  elevation: 5.0,
                                  shape: StadiumBorder(),
                                  primary: Colors.black),
                              onPressed: () {},

                              ///add reject onpressed
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(
                                    MediaQuery.of(context).size.height * 0.048,
                                    12,
                                    MediaQuery.of(context).size.height * 0.048,
                                    12),
                                child: Text(
                                  'Reject',
                                  style: GoogleFonts.lato(
                                      color: Colors.white,
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              0.02),
                                ),
                              )),
                        ),
                      ],
                    )
            ],
          )
        ],
      ),
    ));
  }
}

class largetext extends StatelessWidget {
  String text;

  largetext({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        textAlign: TextAlign.left,
        style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: MediaQuery.of(context).size.width * 0.045),
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
        style: GoogleFonts.poppins(
            color: Colors.black,
            fontSize: MediaQuery.of(context).size.width * 0.035),
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
        style: GoogleFonts.poppins(
            color: Colors.black,
            fontSize: MediaQuery.of(context).size.width * 0.03),
      ),
    );
  }
}

Widget _floating(BuildContext context) {
  if (adminpage == 1) {
    return FloatingActionButton(
      backgroundColor: Colors.black,
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => taskassign_a()));
      },
      child: const Icon(Icons.add),
    );
  } else {
    return Container(
      child: Text('userrrrrrrrrr'),
    );
  }
}
