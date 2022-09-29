

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rounded_expansion_tile/rounded_expansion_tile.dart';
import 'package:sense_task/Services/firebase_crud.dart';
import 'AdminMongo.dart';
import 'AssignTask_Admin.dart';
import 'LoginPage.dart';
import 'Models/TaskMango.dart';
import 'TaskPage_Admin.dart';
import 'Models/UserMango.dart';
import 'main.dart';
import 'mangodb.dart';

/*Text(e["category"]),
                                Text(e["description"]),
                                Text(e["startdate"]),
                                Text(e["enddate"]),
                                Text(e["duedate"]),
                                Text(e["faculty"]),
                                Text(e["status"]),
                                Text(e["reason"]),*/

/*class ItemList extends StatelessWidget {
  List<DocumentSnapshot> _task = [];
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseTask.readItems(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print(snapshot.toString());
          return Text('Something went wrong');
        } else if (snapshot.hasData || snapshot.data != null) {
          return ListView.separated(
            separatorBuilder: (context, index) => SizedBox(height: 16.0),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              Map<String, dynamic> data = _task[index].data()!
              as Map<String, dynamic>;
              return Ink(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => taskassign_a(
                      ),
                    ),
                  ),
                  title: Text(
                    data['title'],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                    data['category'],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              );
            },
          );
        }

        return Center(
          child: CircularProgressIndicator(
          ),
        );
      },
    );
  }
}*/
class second extends StatefulWidget {
  late bool grey;
  @override
  secondState createState() => secondState();
}

class secondState extends State<second> {
  secondState();

  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: _floating(context),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('Tasks').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              print(FirebaseFirestore.instance.collection('Tasks').snapshots().toString());
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView(
              children: snapshot.data!.docs.map((document) {
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
                              largetext(text: document['title']),
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
                                          document['startdate'],
                                          textAlign: TextAlign.left,
                                          style: GoogleFonts.poppins(
                                              color: Colors.amber,
                                              fontWeight: FontWeight.bold,
                                              fontSize:
                                              MediaQuery.of(context).size.width * 0.04),
                                        ),
                                      ),
                                      SizedBox(width: MediaQuery.of(context).size.width * 0.15),
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
                                          document['faculty'],
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
                                      document['duedate'] + " " +  document['duetime'],
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
                                        document['category'],
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
                                    document['description'],
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
                                        document['duedate'],
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
                                    // Padding(
                                    //     padding: const EdgeInsets.all(8.0),
                                    //     child: (int.parse(task_data.duedatedb.split("/")[0]) -
                                    //         DateTime.now().day !=
                                    //         0)
                                    //         ? Text(
                                    //       "${int.parse(task_data.duedatedb.split("/")[0]) - DateTime.now().day} days , ${task_data.duetimedb.split(":")[0]} hours ${task_data.duetimedb.split(":")[1]} mins  ",
                                    //       textAlign: TextAlign.left,
                                    //       style: GoogleFonts.poppins(
                                    //           color: Colors.redAccent,
                                    //           fontWeight: FontWeight.bold,
                                    //           fontSize:
                                    //           MediaQuery.of(context).size.width *
                                    //               0.04),
                                    //     )
                                    //         : Text(
                                    //       " ${hrleft} hours ${minleft} mins  ",
                                    //       textAlign: TextAlign.left,
                                    //       style: GoogleFonts.poppins(
                                    //           color: Colors.redAccent,
                                    //           fontWeight: FontWeight.bold,
                                    //           fontSize:
                                    //           MediaQuery.of(context).size.width *
                                    //               0.04),
                                    //     )
                                    // ),
                                  ],
                                ),
                                SizedBox(height: MediaQuery.of(context).size.width * 0.008),
                                (pageview == 1)
                                    ? Column(
                                  children: [
                                    standardtext(text: document['reason']),
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
                                                categoryvalue = document['category'];
                                                tasktitlecontroller.text = document['title'];
                                                taskdescriptioncontroller.text = document['description'];
                                                startDateInString = document['startdate'];
                                                endDateInString = document['enddate'];
                                                dueDateInString = document['duedate'];
                                                duetime = document['duetime'];
                                                facultyvalue = document['faculty'];
                                                checkInserttask = "update";
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
                                              ///todo:delete function
                                              FirebaseTask.deleteTask(docId: document.id);
                                             // await MongoDbModel.delete_task(task_data);
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
                                                                document.id,
                                                                document['category'],
                                                                document['title'],
                                                                document['description'],
                                                                document['startdate'],
                                                                document['enddate'],
                                                                document['duedate'],
                                                                document['duetime'],
                                                                document['faculty'],
                                                                status,
                                                                taskreasoncontroller
                                                                    .text
                                                            );
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
                                                                            document.id,
                                                                      document['category'],
                                                                      document['title'],
                                                                      document['description'],
                                                                      document['startdate'],
                                                                      document['enddate'],
                                                                      document['duedate'],
                                                                      document['duetime'],
                                                                      document['faculty'],
                                                                            status,
                                                                            taskreasoncontroller.text
                                                                  );
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
                      (document['status'] == 0)
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
                          : (document['status'] == 1)
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
                          : (document['status'] == -1)
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
                          : (document['status'] == 2)
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
              }).toList(),

            );
          }),
    );
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
    await FirebaseTask.updateTask(
        docId: id,
        categorydb: category_update,
        titledb: title_update,
        descriptiondb: description_update,
        startdatedb: startdate_update,
        enddatedb: enddate_update,
        duedatedb: duedate_update,
        duetimedb: duetime_update,
        facultydb: faculty_update,
        statusdb: status_update,
        reasondb: reason_update
    ).whenComplete(
          () => Navigator.pop(context),
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