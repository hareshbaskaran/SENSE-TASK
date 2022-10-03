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
import 'adminview/adminpage.dart';
import 'main.dart';
import 'mangodb.dart';

String filterDateInString = '';
DateTime filterDate = DateTime.now();
bool isDateSelectedforfilter = false;

var filterlist = [
  'Tasks for Today',
  'Assigned Tasks',
  'Completed Tasks',
  'Rejected Tasks',
  'Overdued Tasks',
  'Select Date'
];

Color bb = Color(0xFFADA4A5);
Color b = Color(0xFF817B7C);
TextEditingController taskreasoncontroller = new TextEditingController();
TextEditingController taskreasonblah = new TextEditingController();
int _selectedIndex = 0;

class second extends StatefulWidget {
  late bool grey;
  @override
  secondState createState() => secondState();
}

class secondState extends State<second> {
  secondState();
  int tasklength = 0;
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
            child: Container(
          constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(
            image: DecorationImage(
              alignment: Alignment.topCenter,
              image:
                  AssetImage('assets/images/bgnd.png'), // color: Colors.amber,
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
                      IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
                      Text(
                        'Hello, ',
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: MediaQuery.of(context).size.width * 0.06),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          'Admin !',
                          style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.052),
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
                    '${tasklength} tasks waiting for you ...',
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: MediaQuery.of(context).size.width * 0.04),
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
                      'All Tasks',
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: MediaQuery.of(context).size.width * 0.045),
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
                    stream: FirebaseFirestore.instance
                        .collection('Tasks')
                        .snapshots(),
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
                      return ListView(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        children: snapshot.data!.docs.map((document) {
                          int hrleft =
                              int.parse(document['duetime'].split(":")[0]) -
                                  DateTime.now().hour;
                          int minleft =
                              int.parse(document['duetime'].split(":")[1]) -
                                  DateTime.now().minute;
                          if (int.parse(document['duedate'].split("/")[0]) -
                                      DateTime.now().day <=
                                  0 &&
                              (hrleft < 0 || minleft <= 0)) {
                            ///todo:status check
                            setState(() {
                              status = 2;
                            });
                          }
                          return Dismissible(
                            key: UniqueKey(),
                            background: Container(
                              color: Theme.of(context).errorColor,
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
                              color: Colors.green,
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
                              if (direction == DismissDirection.endToStart) {
                                setState(() {
                                  checkInserttask = "Update";
                                });
                                Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) {
                                              return taskassign_a();
                                            },
                                            settings: RouteSettings(
                                                arguments: document)))
                                    .then((value) {
                                  setState(() {});
                                });

                                print('Updating UI');
                                categoryvalue = document['category'];
                                tasktitlecontroller.text = document['title'];
                                taskdescriptioncontroller.text =
                                    document['description'];
                                startDateInString = document['startdate'];
                                endDateInString = document['endate'];
                                dueDateInString = document['duedate'];
                                duetime = document['duetime'];
                                facultyvalue = document['faculty'];
                                checkInserttask = "Update";
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
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0)),
                                ),
                                child: Card(
                                  elevation: 0,
                                  color: Colors.white,
                                  child: RoundedExpansionTile(
                                    rotateTrailing: false,
                                    trailing: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Icon(
                                          Icons.arrow_drop_down_outlined,
                                          color: Colors.black,
                                        ),
                                      ],
                                    ),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4)),
                                    title: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        largetext(text: document['title']),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.01),
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
                                                standardtext(text: 'Date:  '),
                                                Align(
                                                  alignment: Alignment.topLeft,
                                                  child: Text(
                                                    document['startdate'],
                                                    textAlign: TextAlign.left,
                                                    style: GoogleFonts.poppins(
                                                        color: Colors.amber,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.04),
                                                  ),
                                                ),
                                                SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.15),
                                              ],
                                            ),
                                            SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.01),
                                            (pageview == 1)
                                                ? Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      standardtext(
                                                          text:
                                                              'Faculty     :  '),
                                                      Align(
                                                        alignment:
                                                            Alignment.topLeft,
                                                        child: Text(
                                                          document['faculty'],
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
                                                      )
                                                      /*  standardtext(text: " ${task_data.facultydb}"),*/
                                                    ],
                                                  )
                                                : Align(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: Text(
                                                      document['duedate'] +
                                                          " " +
                                                          document['duetime'],
                                                      style: GoogleFonts.poppins(
                                                          color: Colors.red,
                                                          fontSize: MediaQuery.of(
                                                                      context)
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
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              ///todo: category have to replaced in the heading or is it same update i  next commit
                                              standardtext(
                                                  text: 'Category :  '),
                                              Align(
                                                alignment: Alignment.topLeft,
                                                child: Text(
                                                  document['category'],
                                                  textAlign: TextAlign.left,
                                                  style: GoogleFonts.poppins(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.04),
                                                ),
                                              )
                                              /*  standardtext(text: " ${task_data.facultydb}"),*/
                                            ],
                                          ),
                                          SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.01),
                                          standardtext(
                                              text: 'Event Description:'),
                                          Padding(
                                            padding: const EdgeInsets.all(20.0),
                                            child: Text(
                                              document['description'],
                                              textAlign: TextAlign.left,
                                              style: GoogleFonts.poppins(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.04),
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              standardtext(text: 'Due :  '),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  document['duedate'],
                                                  textAlign: TextAlign.left,
                                                  style: GoogleFonts.poppins(
                                                      color: Colors.redAccent,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize:
                                                          MediaQuery.of(context)
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
                                                  text: 'Time left:  '),
                                              //               Padding(
                                              //                   padding: const EdgeInsets.all(8.0),
                                              //                   child: (int.parse(task_data.duedatedb.split("/")[0]) -
                                              //                       DateTime.now().day !=
                                              //                       0)
                                              //                       ? Text(
                                              //                     "${int.parse(task_data.duedatedb.split("/")[0]) - DateTime.now().day} days , ${task_data.duetimedb.split(":")[0]} hours ${task_data.duetimedb.split(":")[1]} mins  ",
                                              //                     textAlign: TextAlign.left,
                                              //                     style: GoogleFonts.poppins(
                                              //                         color: Colors.redAccent,
                                              //                         fontWeight: FontWeight.bold,
                                              //                         fontSize:
                                              //                         MediaQuery.of(context).size.width *
                                              //                             0.04),
                                              //                   )
                                              //                       : Text(
                                              //                     " ${hrleft} hours ${minleft} mins  ",
                                              //                     textAlign: TextAlign.left,
                                              //                     style: GoogleFonts.poppins(
                                              //                         color: Colors.redAccent,
                                              //                         fontWeight: FontWeight.bold,
                                              //                         fontSize:
                                              //                         MediaQuery.of(context).size.width *
                                              //                             0.04),: Text(
                                              //                   " ${hrleft} hours ${minleft} mins  ",
                                              //                   textAlign: TextAlign.left,
                                              //                       style: GoogleFonts.poppins(
                                              //                       color: Colors.redAccent,
                                              //                   fontWeight: FontWeight.bold,
                                              //                   fontSize: MediaQuery.of(context)
                                              //                       .size
                                              //                       .width *
                                              //                       0.04),
                                              // )
                                              //                   )
                                              //               ),
                                            ],
                                          ),
                                          SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.008),
                                          (pageview == 1)
                                              ? Column(
                                                  children: [
                                                    standardtext(
                                                        text:
                                                            document['reason']),
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
                                  ? Container(
                                      padding: const EdgeInsets.only(right: 20),
                                      alignment: Alignment.topRight,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
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
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.03),
                                          ),
                                        ],
                                      ),
                                    )
                                  : (document['status'] == 1)
                                      ? Container(
                                          padding:
                                              const EdgeInsets.only(right: 20),
                                          alignment: Alignment.topRight,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
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
                                                    fontSize:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.03),
                                              ),
                                            ],
                                          ),
                                        )
                                      : (document['status'] == -1)
                                          ? Container(
                                              padding: const EdgeInsets.only(
                                                  right: 20),
                                              alignment: Alignment.topRight,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
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
                                                        fontSize: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.03),
                                                  ),
                                                ],
                                              ),
                                            )
                                          : (document['status'] == 2)
                                              ? Container(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 20),
                                                  alignment: Alignment.topRight,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
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
                                                            fontSize: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.03),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              : SizedBox()
                            ])),
                          );
                        }).toList(),
                      );
                    }),
              ),
            ],
          ),
        )));
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
    return Center(
      child: Material(
        color: Colors.transparent,
        child: ScaleTransition(
          scale: scaleAnimation,
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
                          'Filter by',
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.045),
                        ),
                      ),
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: filterlist.length,
                        itemBuilder: (BuildContext context, int index) {
                          return (filterlist[index]) != 'Select Date'
                              ? Container(
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                  ),
                                  child: MaterialButton(
                                    color: Colors.black,
                                    onPressed: () {},
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
                        }),
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
