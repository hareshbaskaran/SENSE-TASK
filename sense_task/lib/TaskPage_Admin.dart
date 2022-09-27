import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sense_task/Models/TaskMango.dart';
import 'package:sense_task/main.dart';
import 'package:sense_task/mangodb.dart';
import 'AssignTask_Admin.dart';
import 'package:rounded_expansion_tile/rounded_expansion_tile.dart';
import 'mangodb.dart';
import 'LoginPage.dart';

Color bb = Color(0xFFADA4A5);
Color b = Color(0xFF817B7C);
int isEdit = 0;
TextEditingController taskreasoncontroller = new TextEditingController();
TextEditingController taskreasonblah = new TextEditingController();

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
              future: (pageview == 1)
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
                        }
                        );
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
    int hrleft =
        int.parse(task_data.duetimedb.split(":")[0]) - DateTime.now().hour;
    int minleft =
        int.parse(task_data.duetimedb.split(":")[1]) - DateTime.now().minute;
    if (int.parse(task_data.duedatedb.split("/")[0]) - DateTime.now().day <=
            0 &&
        (hrleft < 0 || minleft <= 0)) {
      task_data.statusdb = 2;
    }

    return Align(
        child: Stack(children: <Widget>[
      Card(
        elevation: 0,
        color: Colors.white,
        child: RoundedExpansionTile(
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Icon(
                Icons.arrow_drop_down_outlined,
                color: Colors.black,
              ),
            ],
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          title: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              largetext(text: "${task_data.titledb}"),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      standardtext(text: 'Date:  '),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          " ${task_data.startdatedb}",
                          textAlign: TextAlign.left,
                          style: GoogleFonts.poppins(
                              color: Colors.amber,
                              fontWeight: FontWeight.bold,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.04),
                        ),
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.15),
                      /*  standardtext(text: 'Due :  '),
                    Align(
                      alignment: Alignment.topRight,
                      child: Text(
                        " ${task_data.duedatedb}",
                        textAlign: TextAlign.left,
                        style: GoogleFonts.poppins(
                            color: Colors.redAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: MediaQuery.of(context).size.width * 0.04),
                      ),
                    )*/
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.width * 0.01),
                  (pageview == 1)
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            standardtext(text: 'Faculty     :  '),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                " ${task_data.facultydb}",
                                textAlign: TextAlign.left,
                                style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.04),
                              ),
                            )
                            /*  standardtext(text: " ${task_data.facultydb}"),*/
                          ],
                        )
                      : Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            '${task_data.duedatedb}  ,   ${task_data.duetimedb}',
                            style: GoogleFonts.poppins(
                                color: Colors.red,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.03),
                          ),
                        ),
                ],
              )
            ],
          ),
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ///todo: category have to replaced in the heading or is it same update i  next commit
                    standardtext(text: 'Category :  '),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        " ${task_data.categorydb} ",
                        textAlign: TextAlign.left,
                        style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: MediaQuery.of(context).size.width * 0.04),
                      ),
                    )
                    /*  standardtext(text: " ${task_data.facultydb}"),*/
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                standardtext(text: 'Event Description:'),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    "${task_data.descriptiondb}",
                    textAlign: TextAlign.left,
                    style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: MediaQuery.of(context).size.width * 0.04),
                  ),
                ),
                Row(
                  children: [
                    standardtext(text: 'Due :  '),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        " ${task_data.duedatedb}",
                        textAlign: TextAlign.left,
                        style: GoogleFonts.poppins(
                            color: Colors.redAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: MediaQuery.of(context).size.width * 0.04),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    standardtext(text: 'Time left:  '),
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: (int.parse(task_data.duedatedb.split("/")[0]) -
                                    DateTime.now().day !=
                                0)
                            ? Text(
                                "${int.parse(task_data.duedatedb.split("/")[0]) - DateTime.now().day} days , ${task_data.duetimedb.split(":")[0]} hours ${task_data.duetimedb.split(":")[1]} mins  ",
                                textAlign: TextAlign.left,
                                style: GoogleFonts.poppins(
                                    color: Colors.redAccent,
                                    fontWeight: FontWeight.bold,
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.04),
                              )
                            : Text(
                                " ${hrleft} hours ${minleft} mins  ",
                                textAlign: TextAlign.left,
                                style: GoogleFonts.poppins(
                                    color: Colors.redAccent,
                                    fontWeight: FontWeight.bold,
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.04),
                              )),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.width * 0.008),
                (pageview == 1)
                    ? Column(
                        children: [
                          standardtext(text: "${task_data.reasondb}"),
                        ],
                      )
                    : SizedBox(
                        height: 0,
                      ),
                (pageview == 1)
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
                                                builder:
                                                    (BuildContext context) {
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
                                        MediaQuery.of(context).size.height *
                                            0.04,
                                        12,
                                        MediaQuery.of(context).size.height *
                                            0.04,
                                        12),
                                    child: Text(
                                      'Edit',
                                      style: GoogleFonts.lato(
                                          color: Colors.white,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height *
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
                                        MediaQuery.of(context).size.height *
                                            0.04,
                                        12,
                                        MediaQuery.of(context).size.height *
                                            0.04,
                                        12),
                                    child: Text(
                                      'Delete',
                                      style: GoogleFonts.lato(
                                          color: Colors.white,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height *
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
                                                    onPressed: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  TabsScreen()));
                                                    },
                                                    child: Text('No')),
                                                ElevatedButton(
                                                    onPressed: () async {
                                                      status = 1;
                                                      await _updateTask(
                                                          task_data!.id_t,
                                                          task_data.categorydb,
                                                          task_data.titledb,
                                                          task_data
                                                              .descriptiondb,
                                                          task_data.startdatedb,
                                                          task_data.enddatedb,
                                                          task_data.duedatedb,
                                                          task_data.duetimedb,
                                                          task_data.facultydb,
                                                          status,
                                                          taskreasoncontroller
                                                              .text);
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  TabsScreen()));
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
                                                              widget.grey =
                                                                  false;
                                                            else
                                                              widget.grey =
                                                                  true;
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
                                                              TextInputType
                                                                  .text,
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
                                                                task_data
                                                                    .titledb,
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
                                                          Navigator.pop(
                                                              context);
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
                                      MediaQuery.of(context).size.height *
                                          0.048,
                                      12,
                                      MediaQuery.of(context).size.height *
                                          0.048,
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
      ),
      (task_data.statusdb == 0)
          ? Container(
              padding: const EdgeInsets.only(right: 20),
              alignment: Alignment.topRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Icon(
                    Icons.circle_rounded,
                    color: Colors.black,
                    size: 18,
                  ),
                  Text(
                    'Assigned',
                    style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: MediaQuery.of(context).size.width * 0.03),
                  ),
                ],
              ),
            )
          : (task_data.statusdb == 1)
              ? Container(
                  padding: const EdgeInsets.only(right: 20),
                  alignment: Alignment.topRight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Icon(
                        Icons.circle_rounded,
                        color: Colors.green,
                        size: 18,
                      ),
                      Text(
                        'Completed',
                        style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: MediaQuery.of(context).size.width * 0.03),
                      ),
                    ],
                  ),
                )
              : (task_data.statusdb == -1)
                  ? Container(
                      padding: const EdgeInsets.only(right: 20),
                      alignment: Alignment.topRight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Icon(
                            Icons.circle_rounded,
                            color: Colors.red,
                            size: 18,
                          ),
                          Text(
                            'Rejected',
                            style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.03),
                          ),
                        ],
                      ),
                    )
                  : (task_data.statusdb == 2)
                      ? Container(
                          padding: const EdgeInsets.only(right: 20),
                          alignment: Alignment.topRight,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Icon(
                                Icons.circle_rounded,
                                color: Colors.red,
                                size: 18,
                              ),
                              Text(
                                'Overdue',
                                style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.03),
                              ),
                            ],
                          ),
                        )
                      : SizedBox()
    ]));
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
/*    if ((int.parse(task_data!.duedatedb.split("/")[0]) -
        DateTime.now().minute == -1)){
      setState(() {
        status == 2;
      });
    }*/
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
      padding: const EdgeInsets.all(10.0),
      child: Text(
        text,
        textAlign: TextAlign.left,
        style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: b,
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
    return Align(
      alignment: Alignment.topLeft,
      child: Text(
        text,
        textAlign: TextAlign.left,
        style: GoogleFonts.poppins(
            color: bb,
            fontWeight: FontWeight.w600,
            fontSize: MediaQuery.of(context).size.width * 0.04),
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
      padding: const EdgeInsets.all(10.0),
      child: Text(
        textAlign: TextAlign.center,
        text,
        style: GoogleFonts.poppins(
            color: bb, fontSize: MediaQuery.of(context).size.width * 0.02),
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
