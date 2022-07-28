import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sense_task/TaskMango.dart';
import 'package:sense_task/mangodb.dart';
import 'AssignTask_Admin.dart';
import 'package:rounded_expansion_tile/rounded_expansion_tile.dart';
import 'mangodb.dart';
import 'LoginPage.dart';

int isEdit = 0;
TextEditingController taskreasoncontroller = new TextEditingController();

class taskpage_a extends StatefulWidget {
  bool grey = true;

  @override
  State<taskpage_a> createState() => _taskpage_aState();
}

class _taskpage_aState extends State<taskpage_a> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: FutureBuilder(
              future: (adminpage == 1)
                  ? MongoDbModel.getTask()
                  : MongoDbModel.getQuerryTask(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  print('connection waiting');
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  if (snapshot.hasData) {
                    var tasklength = snapshot.data.length;
                    //print(tasklength);///todo: this is where querry check happen if task length = 0
                    print('Task has Data');
                    return ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: tasklength,
                        itemBuilder: (BuildContext context, int index) {
                          return Center(
                              child: TaskCard(TaskMongo.fromJson(
                                  snapshot.data[tasklength - index - 1])));
                        });
                  } else {
                    return Center(
                      child: Text('NO data Available'),
                    );
                  }
                }
              }),
        ),
        floatingActionButton: _floating(context));
  }

  Widget TaskCard(TaskMongo task_data) {
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
            largetext(text: "${task_data.titledb} "),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                standardtext(text: "${task_data.categorydb}"),
                (adminpage == 1)
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
              standardtext(text: 'Due Date: ${task_data.duedatedb}'),
              standardtext(text: 'Due Time: ${task_data.duetimedb}'),
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
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  standardtext(
                      text: 'Event start Date: ${task_data.startdatedb}'),
                  standardtext(text: 'Event end Date: ${task_data.enddatedb}'),
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
                                onPressed: () {
                                  setState(() => isEdit = 1);
                                  if (task_data != null) {
                                    print('Updating UI');
                                    categoryvalue = task_data.categorydb;
                                    tasktitlecontroller.text =
                                        task_data.titledb;
                                    taskdescriptioncontroller.text =
                                        task_data.descriptiondb;
                                    startDateInString = task_data.startdatedb;
                                    endDateInString = task_data.enddatedb;
                                    dueDateInString = task_data.duedatedb;
                                    duetime = task_data.duetimedb;
                                    facultyvalue = task_data.facultydb;
                                    checkInserttask = "update";
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
                                  }
                                  ;
                                  Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (BuildContext context) {
                                                return taskassign_a();
                                              },
                                              settings: RouteSettings(
                                                  arguments: task_data)))
                                      .then((value) {
                                    setState(() {});
                                  });
                                },
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
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    elevation: 5.0,
                                    shape: StadiumBorder(),
                                    primary: Colors.black),
                                onPressed: () async {
                                  print(task_data.id_t);
                                  await MongoDbModel.delete_task(task_data);
                                  setState(() {});
                                },
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(
                                      MediaQuery.of(context).size.height * 0.04,
                                      12,
                                      MediaQuery.of(context).size.height * 0.04,
                                      12),
                                  child: Text(
                                    'Delete',
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
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (_) => AlertDialog(
                                            title: Text(
                                                'Do you wish to Accept the Task ?'),
                                            actions: [
                                              ElevatedButton(
                                                  onPressed: () {},
                                                  child: Text('No')),
                                              ElevatedButton(
                                                  onPressed: () async {
                                                    status = 1;
                                                    await _updateTask(
                                                        task_data!.id_t,
                                                        task_data.categorydb,
                                                        task_data.titledb,
                                                        task_data.descriptiondb,
                                                        task_data.startdatedb,
                                                        task_data.enddatedb,
                                                        task_data.duedatedb,
                                                        task_data.duetimedb,
                                                        task_data.facultydb,
                                                        status,
                                                        taskreasoncontroller
                                                            .text);
                                                  },
                                                  child: Text("Yes"))
                                            ]),
                                    barrierDismissible: false);
                              },

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
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (_) => AlertDialog(
                                            title: Text(
                                                'Do you wish to Decline the Task ?'),
                                            actionsAlignment:
                                                MainAxisAlignment.center,
                                            actions: [
                                              Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Container(
                                                      height: 60,
                                                      child: TextField(
                                                        onChanged: (_) {
                                                          if (_.length > 0)
                                                            widget.grey = false;
                                                          else
                                                            widget.grey = true;
                                                          setState(() {});
                                                        },
                                                        decoration:
                                                            InputDecoration(
                                                                fillColor:
                                                                    Colors
                                                                        .black,
                                                                hintText:
                                                                    'Type the reason to decline...',
                                                                hintStyle:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                )),
                                                        keyboardType:
                                                            TextInputType.text,
                                                        maxLines: 2,
                                                        cursorColor:
                                                            Colors.black,
                                                        controller:
                                                            taskreasoncontroller,
                                                        onSubmitted:
                                                            (helo) async {
                                                          status = -1;
                                                          await _updateTask(
                                                              task_data!.id_t,
                                                              task_data
                                                                  .categorydb,
                                                              task_data.titledb,
                                                              task_data
                                                                  .descriptiondb,
                                                              task_data
                                                                  .startdatedb,
                                                              task_data
                                                                  .enddatedb,
                                                              task_data
                                                                  .duedatedb,
                                                              task_data
                                                                  .duetimedb,
                                                              task_data
                                                                  .facultydb,
                                                              status,
                                                              taskreasoncontroller
                                                                  .text);
                                                        },

                                                        ///enter title
                                                      ),
                                                    ),
                                                  ),
                                                  ElevatedButton(
                                                      onPressed: () {
                                                        taskreasoncontroller
                                                            .clear();
                                                        Navigator.pop(context);
                                                      },
                                                      child: Text('Close')),
                                                ],
                                              ),
                                            ]),
                                    barrierDismissible: false);
                              },

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
    await MongoDbModel.update_task(updatetask).whenComplete(
      () => Navigator.pop(context),
    );
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
    return Container();
  }
}
