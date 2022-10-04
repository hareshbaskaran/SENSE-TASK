import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rounded_expansion_tile/rounded_expansion_tile.dart';
import 'package:sense_task/Services/firebase_crud.dart';
import 'package:sense_task/UserInfo.dart';
import 'package:sense_task/AdminMongo.dart';
import 'package:sense_task/AssignTask_Admin.dart';
import 'package:sense_task/LoginPage.dart';
import 'package:sense_task/Models/TaskMango.dart';
import 'package:sense_task/TaskPage_Admin.dart';
import 'package:sense_task/Models/UserMango.dart';
import 'package:sense_task/adminview/admin_facultypage.dart';
import 'package:sense_task/adminview/adminpage.dart';
import 'package:sense_task/main.dart';

import '../userview/userpage.dart';
int adminquery=5;
String filterDateInString = '';
DateTime filterDate = DateTime.now();
bool isDateSelectedforfilter = false;

Color bb = Color(0xFFADA4A5);
Color b = Color(0xFF817B7C);
TextEditingController taskreasoncontroller = new TextEditingController();
TextEditingController taskreasonblah = new TextEditingController();
int _selectedIndex = 0;

Future<int>? tasklength;

class adminpage extends StatefulWidget {
  late bool grey;
  @override
  adminpageState createState() => adminpageState();
}

class adminpageState extends State<adminpage> {
  adminpageState();

  Widget build(BuildContext context) {
    void _onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
        print('index is ');
        print(_selectedIndex);
      });
    }

    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: _floating(context),
        bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.black87,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white.withOpacity(.60),
            selectedFontSize: 14,
            unselectedFontSize: 14,
            currentIndex: _selectedIndex, //New
            onTap: _onItemTapped, //New
            items: [
              BottomNavigationBarItem(
                label: 'Home',
                icon: Icon(Icons.home_rounded),
              ),
              BottomNavigationBarItem(
                label: 'Faculty',
                icon: Icon(Icons.person_outline_rounded),
              )
            ]),
        body: SafeArea(
            child: (_selectedIndex == 0)
                ? Container(
                    constraints: BoxConstraints.expand(),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        alignment: Alignment.topCenter,
                        image: AssetImage(
                            'assets/images/bgnd.png'), // color: Colors.amber,
                      ),
                    ),
                    child: ListView(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: Row(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      Navigator.push(context, MaterialPageRoute(
                                        builder: (BuildContext context) {
                                          return UserInfoScreen(user: user!);
                                        },
                                      )).then((value) {
                                        setState(() {});
                                      });
                                    },
                                    icon: Icon(Icons
                                        .menu)), // TODO : Implement left drawer for profile page (null error)
                                Text(
                                  'Hello, ',
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.06),
                                ),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Text(
                                    'Admin !',
                                    style: GoogleFonts.poppins(
                                        color: Colors.black,
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.052),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(20, 0, 8, 0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              '${tasklength.toString()} tasks waiting for you ...',
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.04),
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: Divider(
                            color: Colors.transparent,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
                          child: Row(
                            children: [
                              Text(
                                (adminquery==5)? 'All Tasks':
                          (adminquery==0)? 'Assigned Tasks ':
                          (adminquery==3)? 'Overdue Tasks':
                          (adminquery==1)? 'Accepted Tasks':
                          (adminquery==2)? 'Rejected Tasks':"",
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.045),
                              ),
                              Spacer(),
                              Align(
                                alignment: Alignment.centerRight,
                                child: IconButton(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (_) => FunkyOverlay(),
                                      );
                                    },
                                    icon: Icon(Icons.filter_alt_sharp)),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: StreamBuilder(
                              stream: (adminquery==5)?
                                  FirebaseTask.readTask():
                              AdminQuery.AdminStatus(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (!snapshot.hasData) {
                                  tasklength = FirebaseFirestore.instance
                                      .collection('Tasks')
                                      .snapshots()
                                      .length;
                                  print(FirebaseFirestore.instance
                                      .collection('Tasks')
                                      .snapshots()
                                      .toString());
                                  print(FirebaseFirestore.instance
                                      .collection('Tasks')
                                      .snapshots()
                                      .length);

                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }

                                return ListView(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  children: snapshot.data!.docs.map((document) {
                                    return Padding(
                                      padding: EdgeInsets.fromLTRB(6, 0, 6, 8),
                                      child: Dismissible(
                                        key: UniqueKey(),
                                        background: Container(
                                          decoration: new BoxDecoration(
                                            color: Theme.of(context).errorColor,
                                            shape: BoxShape.rectangle,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15.0)),
                                          ),
                                          child: Icon(
                                            Icons.delete,
                                            color: Colors.white,
                                            size: 35,
                                          ),
                                          alignment: Alignment.centerLeft,
                                          padding: EdgeInsets.only(left: 20),
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 15, vertical: 8),
                                        ),
                                        secondaryBackground: Container(
                                          decoration: new BoxDecoration(
                                            color: Colors.green,
                                            shape: BoxShape.rectangle,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15.0)),
                                          ),
                                          child: Icon(
                                            Icons.edit,
                                            color: Colors.white,
                                            size: 35,
                                          ),
                                          alignment: Alignment.centerRight,
                                          padding: EdgeInsets.only(right: 20),
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 15, vertical: 8),
                                        ),
                                        onDismissed: (direction) async {
                                          if (direction ==
                                              DismissDirection.endToStart) {
                                            setState(() {
                                              checkInserttask = "Update";
                                            });
                                            print('Updating UI');
                                            categoryvalue = document['category'];
                                            tasktitlecontroller.text = document['title'];
                                            taskdescriptioncontroller.text = document['description'];
                                            startDateInString = document['startdate'];
                                            endDateInString = document['enddate'];
                                            dueDateInString = document['duedate'];
                                            duetime = document['duetime'];
                                            facultyvalue = document['faculty'];
                                            checkInserttask = "Update";

                                            Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (BuildContext
                                                            context) {
                                                          return taskassign_a();
                                                        },
                                                        settings: RouteSettings(
                                                            arguments:
                                                                document)))
                                                .then((value) {
                                              setState(() {});
                                            });
                                          } else {
                                            print(document.id);

                                            await FirebaseTask.deleteTask(
                                                docId: document.id);
                                            setState(() {});
                                          }
                                        },
                                        child: Align(
                                            child: Stack(children: <Widget>[
                                          Container(
                                            decoration: new BoxDecoration(
                                              color: Colors.white,
                                              shape: BoxShape.rectangle,
                                              border: Border.all(width: 1.0),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(15.0)),
                                            ),
                                            child: Card(
                                              elevation: 0,
                                              color: Colors.white,
                                              child: RoundedExpansionTile(
                                                rotateTrailing: false,
                                                trailing: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    Icon(
                                                      Icons
                                                          .arrow_drop_down_outlined,
                                                      color: Colors.black,
                                                    ),
                                                  ],
                                                ),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4)),
                                                title: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    largetext(
                                                        text:
                                                            document['title']),
                                                    SizedBox(
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            0.01),
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            standardtext(
                                                                text:
                                                                    'Start Date:  '),
                                                            Align(
                                                              alignment:
                                                                  Alignment
                                                                      .topLeft,
                                                              child: Text(
                                                                document[
                                                                    'startdate'],
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style: GoogleFonts.poppins(
                                                                    color: Colors
                                                                        .amber,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize: MediaQuery.of(context)
                                                                            .size
                                                                            .width *
                                                                        0.04),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    0.15),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                            height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.01),
                                                        (pageview == 1)
                                                            ? Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  standardtext(
                                                                      text:
                                                                          'Faculty     :  '),
                                                                  Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .topLeft,
                                                                    child: Text(
                                                                      document[
                                                                          'faculty'],
                                                                      textAlign:
                                                                          TextAlign
                                                                              .left,
                                                                      style: GoogleFonts.poppins(
                                                                          color: Colors
                                                                              .black,
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize:
                                                                              MediaQuery.of(context).size.width * 0.04),
                                                                    ),
                                                                  )
                                                                  /*  standardtext(text: " ${task_data.facultydb}"),*/
                                                                ],
                                                              )
                                                            : Align(
                                                                alignment: Alignment
                                                                    .centerRight,
                                                                child: Text(
                                                                  document[
                                                                          'duedate'] +
                                                                      " " +
                                                                      document[
                                                                          'duetime'],
                                                                  style: GoogleFonts.poppins(
                                                                      color: Colors
                                                                          .red,
                                                                      fontSize: MediaQuery.of(context)
                                                                              .size
                                                                              .width *
                                                                          0.03),
                                                                ),
                                                              ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                                children: [
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          standardtext(
                                                              text:
                                                                  'Category :  '),
                                                          Align(
                                                            alignment: Alignment
                                                                .topLeft,
                                                            child: Text(
                                                              document[
                                                                  'category'],
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              style: GoogleFonts.poppins(
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      0.04),
                                                            ),
                                                          )
                                                          /*  standardtext(text: " ${task_data.facultydb}"),*/
                                                        ],
                                                      ),
                                                      SizedBox(
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              0.01),
                                                      standardtext(
                                                          text:
                                                              'Event Description:'),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(20.0),
                                                        child: Text(
                                                          document[
                                                              'description'],
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: GoogleFonts.poppins(
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.04),
                                                        ),
                                                      ),
                                                      Row(
                                                        children: [
                                                          standardtext(
                                                              text: 'Due :  '),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Text(
                                                              document[
                                                                  'duedate'],
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              style: GoogleFonts.poppins(
                                                                  color: Colors
                                                                      .redAccent,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      0.04),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          standardtext(
                                                              text:
                                                                  'Time left:  '),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.008),
                                                      (pageview == 1)
                                                          ? Column(
                                                              children: [
                                                                standardtext(
                                                                    text: document[
                                                                        'reason']),
                                                              ],
                                                            )
                                                          : SizedBox(
                                                              height: 0,
                                                            ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          (document['status'] == 0)
                                              ? StatusTag(Colors.black,'Assigned')
                                              : (document['status'] == 1)
                                                  ? StatusTag(Colors.green,'Accepted')
                                                  : (document['status'] == 2)
                                                      ? StatusTag(Colors.redAccent,'Rejected')
                                                      : (document['status'] == 3)
                                                          ? StatusTag(Colors.deepOrangeAccent,'Overdue')
                                                          : SizedBox()
                                        ]
                                            )
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                );
                              }),
                        ),
                      ],
                    ),
                  )
                : facultystatus()));
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
            reasondb: reason_update)
        .whenComplete(
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

class FunkyOverlay extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => FunkyOverlayState();
}

class FunkyOverlayState extends State<FunkyOverlay>
    with SingleTickerProviderStateMixin {
  AnimationController? controller;
  Animation<double>? scaleAnimation;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 700));
    scaleAnimation =
        CurvedAnimation(parent: controller!, curve: Curves.elasticInOut);

    controller!.addListener(() {
      setState(() {});
    });

    controller!.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: ScaleTransition(
          scale: scaleAnimation!,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.6,
            width: MediaQuery.of(context).size.width * 0.7,
            decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0))
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Filter by',
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.045),
                        ),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height*0.02),
                    FilterBox('All Tasks', 5),
                    SizedBox(height: MediaQuery.of(context).size.height*0.0025),
                    FilterBox('Assigned Tasks', 0),
                    SizedBox(height: MediaQuery.of(context).size.height*0.0025),
                    FilterBox('Overdue Tasks', 3),
                    SizedBox(height: MediaQuery.of(context).size.height*0.0025),
                    FilterBox('Accepted Tasks', 1),
                    SizedBox(height: MediaQuery.of(context).size.height*0.0025),
                    FilterBox('Rejected Tasks', 2),
                  /*  ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: filterlist.length,
                        itemBuilder: (BuildContext context, int index) {
                          return (filterlist[index]) != 'Select Date'
                              ? Container(
                            decoration:ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0))
                            ),
                                  child: MaterialButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15.0)),
                                    color: Colors.black,
                                    onPressed: () {
                                      tasktype = filterlist[
                                          index]; //TODO : Implement tasktype displaying when query is selected in filter list
                                    },
                                    child: Text(
                                      style: TextStyle(color: Colors.white),
                                      filterlist[index],
                                    ),
                                  ),
                                )
                              : Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () async {
                                        final datePick = await showDatePicker(
                                          context: context,
                                          initialDate: filterDate,
                                          firstDate: new DateTime(1900),
                                          lastDate: new DateTime.now(),
                                          builder: (context, child) {
                                            return Theme(
                                              data: Theme.of(context).copyWith(
                                                colorScheme: ColorScheme.light(
                                                  primary: Colors
                                                      .black, // header background color
                                                  onPrimary: Colors
                                                      .white, // header text color
                                                  onSurface: Colors
                                                      .black, // body text color
                                                ),
                                                textButtonTheme:
                                                    TextButtonThemeData(
                                                  style: TextButton.styleFrom(
                                                    primary: Colors
                                                        .black, // button text color
                                                  ),
                                                ),
                                              ),
                                              child: child!,
                                            );
                                          },
                                        );
                                        if (datePick != null &&
                                            datePick != filterDate) {
                                          setState(() {
                                            filterDate = datePick;
                                            isDateSelectedforfilter = true;

                                            // put it here
                                            filterDateInString =
                                                "${filterDate.day}/${filterDate.month}/${filterDate.year}";
                                            print(
                                                filterDateInString); // 08/14/2019
                                          });
                                        }
                                        setState(() {});
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15)),
                                        ),
                                        child: Text(
                                          "Select date",
                                          style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            color: Colors.black,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                        }),*/
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
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
class FilterBox extends StatefulWidget {
  String text;int query;
  FilterBox(this.text,this.query);
  @override
  State<FilterBox> createState() => _FilterBoxState();
}

class _FilterBoxState extends State<FilterBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width*0.5,
      decoration:ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0))
      ),
      child: MaterialButton(
        elevation: 5,
        splashColor: Colors.deepPurpleAccent,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0)),
        color: Colors.black,
        onPressed: () {
          setState(() {
            adminquery=widget.query;
          });
          print(adminquery);
          Navigator.pop(context);
          setState(() {
          });
        },
        child: Text(
            style: TextStyle(
              color: Colors.white,
            ),
            widget.text
        ),
      ),
    );
  }
}
class StatusTag extends StatefulWidget {
  Color status;String text;
  StatusTag(this.status,this.text);

  @override
  State<StatusTag> createState() => _StatusTagState();
}

class _StatusTagState extends State<StatusTag> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
      const EdgeInsets.only(
          right: 20, top: 20),
      alignment: Alignment.topRight,
      child: Row(
        mainAxisAlignment:
        MainAxisAlignment.end,
        crossAxisAlignment:
        CrossAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Icon(
              Icons.circle_rounded,
              color: widget.status,
              size: 14,
            ),
          ),
          Padding(
            padding:
            EdgeInsets.only(
                left: 8),
            child: Text(
              widget.text,
              style: GoogleFonts.poppins(
                  color:
                  Colors.black,
                  fontWeight:
                  FontWeight
                      .w500,
                  fontSize: MediaQuery.of(
                      context)
                      .size
                      .width *
                      0.035),
            ),
          ),
        ],
      ),
    );
  }
}


