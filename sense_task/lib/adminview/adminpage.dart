import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
<<<<<<< HEAD
=======
import 'package:hive/hive.dart';
>>>>>>> parent of ee35c8f (deleted_sense)
import 'package:rounded_expansion_tile/rounded_expansion_tile.dart';
import 'package:sense_task/Servicesandresponse/firebase_crud.dart';
import 'package:sense_task/LoginandSignoutPage//UserInfo.dart';
import 'package:sense_task/AdminView/AssignTask_Admin.dart';
import 'package:sense_task/LoginandSignoutPage//LoginPage.dart';
import 'package:sense_task/AdminView/admin_facultypage.dart';

String querydateinstring = '';
DateTime querydate = DateTime.now();
int adminquery = 5;
String filterDateInString = '';
DateTime filterDate = DateTime.now();
bool isDateSelectedforfilter = false;
String queryfaculty = faculty_list.first;
Color bb = Color(0xFFADA4A5);
Color b = Color(0xFF817B7C);

TextEditingController reasonpop = new TextEditingController();
int _selectedIndex = 0;
Future<int>? tasklength;
int todaytasks = 0;
int ct = 0;

class adminpage extends StatefulWidget {
<<<<<<< HEAD
=======
  late final Box<dynamic> box;
  adminpage(this.box);
>>>>>>> parent of ee35c8f (deleted_sense)
  late bool grey;
  @override
  adminpageState createState() => adminpageState();
}

class adminpageState extends State<adminpage> {
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
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => taskassign_a()));
          },
          child: const Icon(Icons.add),
        ),
        bottomNavigationBar: Container(
          height: 65,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(40), topLeft: Radius.circular(40)),
            boxShadow: [
              BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            ),
            child: BottomNavigationBar(
                elevation: 3.0,
                type: BottomNavigationBarType.fixed,
                backgroundColor: Colors.black,
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
          ),
        ),
        body: RefreshIndicator(
          color: Colors.black,
          onRefresh: () async {
            await Future.delayed(Duration(seconds: 1));
            setState(() {
              ct += 1;
            });
          },
          child: SafeArea(
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
                                      onPressed: () async {
                                        User? user = await signInWithGoogle(
                                            context: context);
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              settings: RouteSettings(
                                                  arguments: user),
                                              builder: (context) =>
                                                  UserInfoScreen(user: user!)),
                                        );
                                      },
                                      icon: Icon(Icons.menu)),
                                  Text(
                                    'Hello, ',
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.06),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 4.0),
                                    child: Text(
                                      'Admin !',
                                      style: GoogleFonts.poppins(
                                          color: Colors.black,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.052),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          if (todaytasks != 0)
                            Column(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(15, 0, 15, 10),
                                  child: Row(
                                    children: [
                                      Text(
                                        'Today  Tasks',
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.045),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.5,
                                    decoration: new BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.rectangle,
                                      border: Border.all(width: 1.0),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15.0)),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: StreamBuilder(
                                          stream: AdminQuery.TodayTasks(),
                                          builder: (BuildContext context,
                                              AsyncSnapshot<QuerySnapshot>
                                                  snapshot) {
                                            if (!snapshot.hasData) {
                                              return Center(
                                                child:
                                                    CircularProgressIndicator(
                                                  color:
                                                      Colors.deepPurpleAccent,
                                                ),
                                              );
                                            }
                                            todaytasks =
                                                snapshot.data!.docs.length;
                                            return ListView(
                                              shrinkWrap: true,
                                              children: snapshot.data!.docs
                                                  .map((document) {
                                                return Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      6, 0, 6, 8),
                                                  child: Dismissible(
                                                    key: UniqueKey(),
                                                    background: Icon(
                                                      Icons.delete,
                                                      color: Colors.white,
                                                      size: 35,
                                                    ),
                                                    secondaryBackground:
                                                        Container(
                                                      decoration:
                                                          new BoxDecoration(
                                                        color: Colors.green,
                                                        shape:
                                                            BoxShape.rectangle,
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    15.0)),
                                                      ),
                                                      child: Icon(
                                                        Icons.edit,
                                                        color: Colors.white,
                                                        size: 35,
                                                      ),
                                                      alignment:
                                                          Alignment.centerRight,
                                                      padding: EdgeInsets.only(
                                                          right: 20),
                                                      margin:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 15,
                                                              vertical: 8),
                                                    ),
                                                    onDismissed:
                                                        (direction) async {
                                                      if (direction ==
                                                          DismissDirection
                                                              .endToStart) {
                                                        setState(() {
                                                          checkInserttask =
                                                              "Update";
                                                        });
                                                        print('Updating UI');
                                                        adminreasoncontroller
                                                                .text =
                                                            document['admin'];
                                                        categoryvalue =
                                                            document[
                                                                'category'];
                                                        tasktitlecontroller
                                                                .text =
                                                            document['title'];
                                                        taskdescriptioncontroller
                                                                .text =
                                                            document[
                                                                'description'];
                                                        startDateInString =
                                                            document[
                                                                'startdate'];
                                                        endDateInString =
                                                            document['enddate'];
                                                        dueDateInString =
                                                            document['duedate'];
                                                        duetime =
                                                            document['duetime'];
                                                        facultyvalue =
                                                            document['faculty'];
                                                        checkInserttask =
                                                            "Update";

                                                        Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (BuildContext
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

                                                        await FirebaseTask
                                                            .deleteTask(
                                                                docId: document
                                                                    .id);
                                                        setState(() {});
                                                      }
                                                    },
                                                    child: Align(
                                                        child: Stack(
                                                            children: <Widget>[
                                                          Container(
                                                            decoration:
                                                                new BoxDecoration(
                                                              color:
                                                                  Colors.white,
                                                              shape: BoxShape
                                                                  .rectangle,
                                                              border:
                                                                  Border.all(
                                                                      width:
                                                                          2.0),
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          15.0)),
                                                            ),
                                                            child: Card(
                                                              elevation: 0,
                                                              color:
                                                                  Colors.white,
                                                              child:
                                                                  RoundedExpansionTile(
                                                                rotateTrailing:
                                                                    false,
                                                                trailing:
                                                                    Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .end,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .end,
                                                                  children: [
                                                                    Icon(
                                                                      Icons
                                                                          .arrow_drop_down_outlined,
                                                                      color: Colors
                                                                          .black,
                                                                    ),
                                                                  ],
                                                                ),
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            4)),
                                                                title: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    largetext(
                                                                        text: document[
                                                                            'title']),
                                                                    standardtext(
                                                                      text:
                                                                          "${document['faculty']}",
                                                                      c: Colors
                                                                          .deepPurpleAccent,
                                                                    ),
                                                                    standardtext(
                                                                      text:
                                                                          "${document['startdate']} - ${document['enddate']}",
                                                                      c: Color(
                                                                          0xff555556),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          left:
                                                                              10.0),
                                                                      child:
                                                                          Column(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.start,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.start,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.center,
                                                                            children: [
                                                                              SizedBox(width: MediaQuery.of(context).size.width * 0.15),
                                                                            ],
                                                                          ),
                                                                          SizedBox(
                                                                              height: MediaQuery.of(context).size.width * 0.01),
                                                                        ],
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                                children: [
                                                                  Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      SizedBox(
                                                                          height:
                                                                              20),
                                                                      Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.start,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          standardtext(
                                                                              text: 'Category :  ',
                                                                              c: bb),
                                                                          standardtext(
                                                                              text: '${document['category']}',
                                                                              c: Colors.deepPurpleAccent)
                                                                        ],
                                                                      ),
                                                                      SizedBox(
                                                                          height:
                                                                              MediaQuery.of(context).size.height * 0.01),
                                                                      standardtext(
                                                                          text:
                                                                              'Event Description:',
                                                                          c: bb),
                                                                      Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(10.0),
                                                                        child:
                                                                            Text(
                                                                          document[
                                                                              'description'],
                                                                          textAlign:
                                                                              TextAlign.left,
                                                                          style: GoogleFonts.poppins(
                                                                              color: Colors.black,
                                                                              fontWeight: FontWeight.bold,
                                                                              fontSize: MediaQuery.of(context).size.width * 0.04),
                                                                        ),
                                                                      ),
                                                                      (pageview ==
                                                                              1)
                                                                          ? Column(
                                                                              children: [
                                                                                standardtext(text: document['reason'], c: Colors.red),
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
                                                          (document['status'] ==
                                                                  0)
                                                              ? StatusTag(
                                                                  Colors.black,
                                                                  'Assigned')
                                                              : (document['status'] ==
                                                                      1)
                                                                  ? StatusTag(
                                                                      Colors
                                                                          .green,
                                                                      'Accepted')
                                                                  : (document['status'] ==
                                                                          2)
                                                                      ? StatusTag(
                                                                          Colors
                                                                              .redAccent,
                                                                          'Rejected')
                                                                      : (document['status'] ==
                                                                              3)
                                                                          ? StatusTag(
                                                                              Colors.deepOrangeAccent,
                                                                              'Overdue')
                                                                          : SizedBox(),
                                                          (document['admin'] ==
                                                                  "")
                                                              ? Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .bottomRight,
                                                                  child:
                                                                      Padding(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        top:
                                                                            80.0,
                                                                        right:
                                                                            10),
                                                                    child:
                                                                        InkWell(
                                                                      onTap:
                                                                          () {
                                                                        setState(
                                                                            () {
                                                                          showDialog(
                                                                            routeSettings:
                                                                                RouteSettings(arguments: document),
                                                                            context:
                                                                                context,
                                                                            builder: (_) =>
                                                                                FunkyOverlayAdminReject(),
                                                                          );
                                                                        });
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        child:
                                                                            Icon(
                                                                          Icons
                                                                              .recommend_rounded,
                                                                          color:
                                                                              Colors.red,
                                                                          size: MediaQuery.of(context).size.width *
                                                                              0.1,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                )
                                                              : SizedBox()
                                                        ])),
                                                  ),
                                                );
                                              }).toList(),
                                            );
                                          }),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 30),
                              ],
                            ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
                            child: Row(
                              children: [
                                Text(
                                  (adminquery == 5)
                                      ? 'All Tasks'
                                      : (adminquery == 0)
                                          ? 'Assigned Tasks '
                                          : (adminquery == 3)
                                              ? 'Overdue Tasks'
                                              : (adminquery == 1)
                                                  ? 'Accepted Tasks'
                                                  : (adminquery == 6)
                                                      ? "Select Date"
                                                      : (adminquery == 4)
                                                          ? "Select faculty"
                                                          : (adminquery == 2)
                                                              ? 'Rejected Tasks'
                                                              : "",
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.045),
                                ),
                                SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.1),
                                (adminquery == 6)
                                    ? Center(
                                        child: GestureDetector(
                                          onTap: () async {
                                            final datePick =
                                                await showDatePicker(
                                              context: context,
                                              initialDate: new DateTime.now(),
                                              firstDate: new DateTime.now(),
                                              lastDate: new DateTime.now()
                                                  .add(Duration(days: 365)),
                                              builder: (context, child) {
                                                return Theme(
                                                  data: Theme.of(context)
                                                      .copyWith(
                                                    colorScheme:
                                                        ColorScheme.light(
                                                      primary: Colors
                                                          .black, // header background color
                                                      onPrimary: Colors
                                                          .white, // header text color
                                                      onSurface: Colors
                                                          .black, // body text color
                                                    ),
                                                    textButtonTheme:
                                                        TextButtonThemeData(
                                                      style:
                                                          TextButton.styleFrom(
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
                                                datePick != startDate) {
                                              setState(() {
                                                querydate = datePick;
                                                isDateSelected = true;

                                                // put it here
                                                querydateinstring =
                                                    "${querydate.day}/${querydate.month}/${querydate.year}";
                                                print(
                                                    startDateInString); // 08/14/2019
                                              });
                                            }
                                            setState(() {});
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.07,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.4,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Container(
                                                child: Row(
                                                  children: [
                                                    SizedBox(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.075),
                                                    (querydateinstring != '')
                                                        ? Text(
                                                            querydateinstring,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black),
                                                          )
                                                        : Text(
                                                            "Input Date",
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 15,
                                                            ),
                                                          ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    : (adminquery == 4)
                                        ? Center(
                                            child: Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.07,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.3,
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Row(
                                                    children: [
                                                      SizedBox(width: 20),
                                                      new DropdownButtonHideUnderline(
                                                        child: DropdownButton(
                                                          icon: Icon(
                                                            Icons
                                                                .arrow_drop_down,
                                                            color: Colors.black,
                                                            size: 20.09,
                                                          ),
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          dropdownColor:
                                                              Colors.white,
                                                          value: queryfaculty,
                                                          items: faculty_list
                                                              .map((String
                                                                  faculty) {
                                                            return DropdownMenuItem(
                                                              value: faculty,
                                                              child:
                                                                  Text(faculty),
                                                            );
                                                          }).toList(),
                                                          onChanged: (String?
                                                              newValue) {
                                                            setState(() {
                                                              queryfaculty =
                                                                  newValue!;
                                                            });
                                                          },
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            color: Colors.black,
                                                            fontSize: 15,
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        : SizedBox(),
                                Spacer(),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: IconButton(
                                      onPressed: () {
                                        showDialog(
                                          routeSettings: RouteSettings(
                                              arguments: adminquery),
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
                                stream: (adminquery == 4)
                                    ? AdminQuery.FacultyQuery()
                                    : (adminquery == 0 ||
                                            adminquery == 1 ||
                                            adminquery == 2 ||
                                            adminquery == 3)
                                        ? AdminQuery.AdminStatus()
                                        : (adminquery == 6)
                                            ? AdminQuery.DateQuery()
                                            : FirebaseTask.readTask(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (!snapshot.hasData) {
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
                                  if (snapshot.hasData) {
                                    tasklength = FirebaseTask.readTask().length;
                                  }
                                  return ListView(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    children:
                                        snapshot.data!.docs.map((document) {
                                      return Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(6, 0, 6, 8),
                                        child: Dismissible(
                                          key: UniqueKey(),
                                          background: Container(
                                            decoration: new BoxDecoration(
                                              color:
                                                  Theme.of(context).errorColor,
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
                                              adminreasoncontroller.text =
                                                  document['admin'];
                                              categoryvalue =
                                                  document['category'];
                                              tasktitlecontroller.text =
                                                  document['title'];
                                              taskdescriptioncontroller.text =
                                                  document['description'];
                                              startDateInString =
                                                  document['startdate'];
                                              endDateInString =
                                                  document['enddate'];
                                              dueDateInString =
                                                  document['duedate'];
                                              duetime = document['duetime'];
                                              facultyvalue =
                                                  document['faculty'];
                                              checkInserttask = "Update";

                                              Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (BuildContext
                                                              context) {
                                                            return taskassign_a();
                                                          },
                                                          settings:
                                                              RouteSettings(
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
                                                border: Border.all(width: 2.0),
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
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      largetext(
                                                          text: document[
                                                              'title']),
                                                      standardtext(
                                                        text:
                                                            "${document['faculty']}",
                                                        c: Colors
                                                            .deepPurpleAccent,
                                                      ),
                                                      standardtext(
                                                        text:
                                                            "${document['startdate']} - ${document['enddate']}",
                                                        c: Color(0xff555556),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 10.0),
                                                        child: Column(
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
                                                                SizedBox(
                                                                    width: MediaQuery.of(context)
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
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  children: [
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        SizedBox(height: 20),
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
                                                                    'Category :  ',
                                                                c: bb),
                                                            standardtext(
                                                                text:
                                                                    '${document['category']}',
                                                                c: Colors
                                                                    .deepPurpleAccent)
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
                                                                'Event Description:',
                                                            c: bb),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(10.0),
                                                          child: Text(
                                                            document[
                                                                'description'],
                                                            textAlign:
                                                                TextAlign.left,
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
                                                        ),
                                                        (pageview == 1)
                                                            ? Column(
                                                                children: [
                                                                  standardtext(
                                                                      text: document[
                                                                          'reason'],
                                                                      c: Colors
                                                                          .red),
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
                                                ? StatusTag(
                                                    Colors.black, 'Assigned')
                                                : (document['status'] == 1)
                                                    ? StatusTag(Colors.green,
                                                        'Accepted')
                                                    : (document['status'] == 2)
                                                        ? StatusTag(
                                                            Colors.redAccent,
                                                            'Rejected')
                                                        : (document['status'] ==
                                                                3)
                                                            ? StatusTag(
                                                                Colors
                                                                    .deepOrangeAccent,
                                                                'Overdue')
                                                            : SizedBox(),
                                            (document['admin'] == "")
                                                ? Align(
                                                    alignment:
                                                        Alignment.bottomRight,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 80.0,
                                                              right: 10),
                                                      child: InkWell(
                                                        onTap: () {
                                                          setState(() {
                                                            showDialog(
                                                              routeSettings:
                                                                  RouteSettings(
                                                                      arguments:
                                                                          document),
                                                              context: context,
                                                              builder: (_) =>
                                                                  FunkyOverlayAdminReject(),
                                                            );
                                                          });
                                                        },
                                                        child: Icon(
                                                          Icons
                                                              .recommend_rounded,
                                                          color: Colors.red,
                                                          size: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.1,
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                : (document['admin'] != "")
                                                    ? Align(
                                                        alignment: Alignment
                                                            .bottomRight,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 80.0,
                                                                  right: 10),
                                                          child: InkWell(
                                                            onTap: () {},
                                                            child: Icon(
                                                              Icons
                                                                  .recommend_rounded,
                                                              color:
                                                                  Colors.green,
                                                              size: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.1,
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    : SizedBox()
                                          ])),
                                        ),
                                      );
                                    }).toList(),
                                  );
                                }),
                          ),
                          SizedBox(height: 60)
                        ],
                      ),
                    )
                  : facultystatus()),
        ));
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
                    borderRadius: BorderRadius.circular(15.0))),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Filter tasks by type ',
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.045),
                        ),
                      ),
                    ),
                    FilterBox('All Tasks', 5),
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 0.0025),
                    FilterBox('Assigned Tasks', 0),
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 0.0025),
                    FilterBox('Overdue Tasks', 3),
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 0.0025),
                    FilterBox('Accepted Tasks', 1),
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 0.0025),
                    FilterBox('Rejected Tasks', 2),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Filter tasks by Date',
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.045),
                        ),
                      ),
                    ),
                    FilterBox('Choose Date', 6),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Filter tasks by Faculty',
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.045),
                        ),
                      ),
                    ),
                    FilterBox('Choose Faculty', 4),
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
      padding: EdgeInsets.fromLTRB(0, 10, 10, 10),
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
  Color c;

  standardtext({required this.text, required this.c});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: Text(
        text,
        textAlign: TextAlign.left,
        style: GoogleFonts.poppins(
            color: c,
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
  String text;
  int query;
  FilterBox(this.text, this.query);
  @override
  State<FilterBox> createState() => _FilterBoxState();
}

class _FilterBoxState extends State<FilterBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0))),
      child: MaterialButton(
        elevation: 5,
        splashColor: Colors.deepPurpleAccent,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        color: Colors.black,
        onPressed: () async {
          setState(() {
            adminquery = widget.query;
            adminquery = adminquery;
          });
          print(adminquery);
          Navigator.push(
            context,
<<<<<<< HEAD
            MaterialPageRoute(builder: (context) => adminpage()),
=======
            MaterialPageRoute(builder: (context) => adminpage(Hive_box)),
>>>>>>> parent of ee35c8f (deleted_sense)
          );
        },
        child: Text(
            style: TextStyle(
              color: Colors.white,
            ),
            widget.text),
      ),
    );
  }
}

class StatusTag extends StatefulWidget {
  Color status;
  String text;
  StatusTag(this.status, this.text);

  @override
  State<StatusTag> createState() => _StatusTagState();
}

class _StatusTagState extends State<StatusTag> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 20, top: 20),
      alignment: Alignment.topRight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
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
            padding: EdgeInsets.only(left: 8),
            child: Text(
              widget.text,
              style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: MediaQuery.of(context).size.width * 0.035),
            ),
          ),
        ],
      ),
    );
  }
}

class FunkyOverlayAdminReject extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => FunkyOverlayAdminRejectState();
}

class FunkyOverlayAdminRejectState extends State<FunkyOverlayAdminReject>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.elasticInOut);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    QueryDocumentSnapshot? document =
        ModalRoute.of(context)!.settings.arguments as QueryDocumentSnapshot?;
    return Center(
      child: Material(
        color: Colors.transparent,
        child: ScaleTransition(
          scale: scaleAnimation,
          child: Container(
            decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0))),
            child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                    height: MediaQuery.of(context).size.height * 0.24,
                    width: MediaQuery.of(context).size.width * 0.88,
                    decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0))),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            " Why did you Assign this Task ? ",
                            style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.040),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 40,
                            child: TextField(
                              decoration: InputDecoration(
                                fillColor: Colors.black,
                                hintText: 'Type here',
                                hintStyle: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w200,
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.032),
                              ),
                              keyboardType: TextInputType.text,
                              maxLines: 2,
                              cursorColor: Colors.black,
                              controller: adminreasoncontroller,
                            ),
                          ),
                        ),
                        Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      elevation: 5.0,
                                      shape: StadiumBorder(),
                                      primary: Colors.black),
                                  onPressed: () {
                                    adminreasoncontroller.clear();
                                    Navigator.pop(context);
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
                                      'Close',
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
                                    if (document != null)
                                      await FirebaseTask.updateTask(
                                              admindb: document['admin'],
                                              categorydb: document['category'],
                                              titledb: document['title'],
                                              descriptiondb:
                                                  document['description'],
                                              startdatedb:
                                                  document['startdate'],
                                              enddatedb: document['enddate'],
                                              duedatedb: document['duedate'],
                                              duetimedb: document['duetime'],
                                              facultydb: document['faculty'],
                                              statusdb: status,
                                              reasondb: '',
                                              docId: document.id)
                                          .whenComplete(
                                        () => Navigator.pop(context),
                                      );

                                    adminreasoncontroller.clear();
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
                                      'Done',
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
                      ],
                    ))),
          ),
        ),
      ),
    );
  }
}
