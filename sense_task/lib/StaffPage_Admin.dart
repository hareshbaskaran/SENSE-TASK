import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rounded_expansion_tile/rounded_expansion_tile.dart';
import 'AdminMongo.dart';
import 'AssignTask_Admin.dart';
import 'LoginPage.dart';
import 'TaskMango.dart';
import 'TaskPage_Admin.dart';
import 'UserMango.dart';
import 'mangodb.dart';

class staffpage_a extends StatefulWidget {
  bool grey = true;

  @override
  State<staffpage_a> createState() => _staffpage_aState();
}

class _staffpage_aState extends State<staffpage_a> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
            future: MongoDbModel.getQuerryTaskStatus(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                print('connection waiting');
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                if (snapshot.hasData) {
                  var Statuslength = snapshot.data.length;

                  ///todo: this is where querry check happen if task length = 0
                  print('Task has Data');
                  return ListView.builder(
                      reverse: true,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: Statuslength,
                      itemBuilder: (BuildContext context, int index) {
                        return Center(
                            child: StatusCard(
                                TaskMongo.fromJson(snapshot.data[index])));
                      });
                } else {
                  return Center(
                    child: Text('NO data Available'),
                  );
                }
              }
            }),
      ),
    );
  }

  Widget StatusCard(TaskMongo task_data) {
    return Center(
        child: Stack(children: <Widget>[
          Card(
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
                  largetext(text: "${task_data.titledb} "),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      standardtext(text: "${task_data.categorydb}"),
                      (pageview == 1)
                          ? Column(
                        children: [
                          standardtext(text: "${task_data.reasondb}"),
                          largetext(text: "${task_data.facultydb}")
                        ],
                      )
                          : SizedBox(
                        height: 0,
                      )
                    ],
                  )
                ],
              ),
              subtitle: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${task_data.duedatedb} , ${task_data.duetimedb}',
                style: GoogleFonts.poppins(
                color: Colors.red,
                fontSize: MediaQuery.of(context).size.width * 0.03),
                    ),
                  ],
                ),
              ),
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    largetext(text: 'Description:'),
                    standardtext(text: "${task_data.descriptiondb}"),
                      (status==-1)?
                    standardtext(
                        text: 'Reason : \n '
                            '${task_data.reasondb}') :
                            SizedBox(),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        standardtext(
                            text: 'Event start Date: ${task_data.startdatedb}'),
                        standardtext(
                            text: 'Event end Date: ${task_data.enddatedb}'),
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.025),
                  ],
                )
              ],
            ),
          ),
          (status == 0)
              ? Container(
            padding: const EdgeInsets.only(right: 20),
            alignment: Alignment.topRight,
            child: Icon(
              Icons.circle_rounded,
              color: Colors.black,
            ),
          )
              : (status == 1)?
          Container(
            padding: const EdgeInsets.only(right: 20),
            alignment: Alignment.topRight,
            child: Icon(
              Icons.circle_rounded,
              color: Colors.green,
            ),
          ):(status == -1)?
          Container(
            padding: const EdgeInsets.only(right: 20),
            alignment: Alignment.topRight,
            child: Icon(
              Icons.circle_rounded,
              color: Colors.red,
            ),
          ):
          SizedBox()
        ]
        )
    );
  }
}

Future<void> _updateTask(
    var id,
    String category_update,
    String title_update,
    String description_update,
    String startdate_update,
    String enddate_update,
    String duedate_update,
    String duetime_update,
    String faculty_update,
    int status_update,
    String reason_update) async {
  final updatetask = TaskMongo(
      id_t: id,
      categorydb: category_update,
      titledb: title_update,
      descriptiondb: description_update,
      startdatedb: startdate_update,
      enddatedb: enddate_update,
      duedatedb: duedate_update,
      duetimedb: duetime_update,
      facultydb: faculty_update,
      statusdb: status_update,
      reasondb: reason_update);
  print('in update task function');
  print(categoryvalue);
  print(tasktitlecontroller.text);

  print(taskdescriptioncontroller.text);
  print(startDate);
  print(startDateInString);
  print(endDate);
  print(endDateInString);
  print(dueDate);
  print(dueDateInString);
  print(duetime);
  print(facultyvalue);
  BuildContext context;
  await MongoDbModel.update_task(updatetask);
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
  if (pageview == 1) {
    return FloatingActionButton(
      backgroundColor: Colors.black,
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => taskassign_a()));
      },
      child: const Icon(Icons.add),
    );
  } else {
    return Container();
  }
}