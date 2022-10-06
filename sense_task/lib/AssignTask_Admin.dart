import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sense_task/Services/firebase_crud.dart';
import 'package:sense_task/StaffPage_Admin.dart';
import 'package:sense_task/adminview/adminpage.dart';
import 'package:sense_task/Models/TaskMango.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:sense_task/main.dart';
import 'package:mongo_dart/mongo_dart.dart' as T;
import 'package:google_fonts/google_fonts.dart';

TextEditingController tasktitlecontroller = new TextEditingController();
TextEditingController adminreasoncontroller = new TextEditingController();
TextEditingController taskdescriptioncontroller = new TextEditingController();

var checkInserttask = "Assign";

// TaskMongo? task_data;

String startDateInString = '';
DateTime startDate = DateTime.now();

String endDateInString = '';
DateTime endDate = DateTime.now();

String dueDateInString = '';
DateTime dueDate = DateTime.now();

String categoryvalue = 'HR office duty';
var items = [
  'HR office duty',
  'CTS office duty',
  'SENSE office duty',
  'Hostel duty',
  'Placement office duty',
  'Admissions office duty',
  'SW office duty',
  'Venue Preparation for VITEEE',
  'Venue Preparation for TRB/TNPSC exams',
  'OTHERS'
];
String facultyvalue =facultylist.first;
var facultylist = [
  'Ishu',
  'Haresh',
  'Mami',
  'Shobi',
];

String duetime = '';

int status = 0;

String reason = 'No reason';

class taskassign_a extends StatefulWidget {
  bool grey = true;

  @override
  State<taskassign_a> createState() => _taskassign_aState();
}

bool isDateSelected = false;
bool isRegister = true;

class _taskassign_aState extends State<taskassign_a> {
  @override
  Widget build(BuildContext context) {
    QueryDocumentSnapshot? document =
        ModalRoute.of(context)!.settings.arguments as QueryDocumentSnapshot?;
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                'assets/images/Group 12.png',
              ),
              fit: BoxFit.cover)),
      child: SafeArea(
        child: Scaffold(
            backgroundColor: Colors.transparent,
            resizeToAvoidBottomInset: false,
            body: RefreshIndicator(
              color: Colors.black,
              onRefresh: () async {
                await Future.delayed(Duration(seconds: 1));
              },
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 30),
                  child: ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(children: [
                          InkWell(
                            onTap: () {
                              Navigator.pop(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => adminpage()),
                              );
                              _clearassignpage();
                            },
                            child: Icon(
                              Icons.arrow_back_rounded,
                              color: Colors.black,
                              size: MediaQuery.of(context).size.width * 0.085,
                            ),
                          ),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.175),
                          Center(
                            child: Container(
                              alignment: Alignment.topCenter,
                              child: Text(
                                checkInserttask + ' Task',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.065,
                                ),
                              ),
                            ),
                          ),
                        ]),
                      ),

                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          'Task Category',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: MediaQuery.of(context).size.width * 0.03,
                          ),
                        ),
                      ),
                      Center(
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.07,
                          width: MediaQuery.of(context).size.width * 0.9,
                          decoration: new BoxDecoration(
                            color: Colors.black,
                            shape: BoxShape.rectangle,
                            border: Border.all(width: 1.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                children: [
                                  SizedBox(width: 20),
                                  new DropdownButtonHideUnderline(
                                    child: DropdownButton(
                                      icon: Icon(
                                        Icons.arrow_drop_down,
                                        color: Colors.white,
                                        size: 20.09,
                                      ),
                                      alignment: Alignment.centerLeft,
                                      dropdownColor: Colors.black,
                                      value: categoryvalue,
                                      items: items.map((String item) {
                                        return DropdownMenuItem(
                                          value: item,
                                          child: Text(item),
                                        );
                                      }).toList(),
                                      // After selecting the desired option,it will
                                      // change button value to selected value
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          categoryvalue = newValue!;
                                        });
                                      },
                                      style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        color: Colors.white,
                                        fontSize: 15,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          'Choose Faculty',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: MediaQuery.of(context).size.width * 0.03,
                          ),
                        ),
                      ),
                      Center(
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.07,
                          width: MediaQuery.of(context).size.width * 0.9,
                          decoration: new BoxDecoration(
                            color: Colors.black,
                            shape: BoxShape.rectangle,
                            border: Border.all(width: 1.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                children: [
                                  SizedBox(width: 20),
                                  new DropdownButtonHideUnderline(
                                    child: DropdownButton(
                                      icon: Icon(
                                        Icons.arrow_drop_down,
                                        color: Colors.white,
                                        size: 20.09,
                                      ),
                                      alignment: Alignment.centerLeft,
                                      dropdownColor: Colors.black,
                                      value: facultyvalue,
                                      items: facultylist.map((String faculty) {
                                        return DropdownMenuItem(
                                          value: faculty,
                                          child: Text(faculty),
                                        );
                                      }).toList(),
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          facultyvalue = newValue!;
                                        });
                                      },
                                      style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        color: Colors.white,
                                        fontSize: 15,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.075,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          'Task Description',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: MediaQuery.of(context).size.width * 0.03,
                          ),
                        ),
                      ),

                      Center(
                        child: Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.9,
                              decoration: new BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.rectangle,
                                border: Border.all(width: 1.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15.0)),
                              ),
                              child: TextField(
                                onChanged: (_) {
                                  if (_.length > 0)
                                    widget.grey = false;
                                  else
                                    widget.grey = true;
                                  setState(() {});
                                },
                                decoration: InputDecoration(
                                    alignLabelWithHint: true,
                                    fillColor: Colors.black,
                                    border: InputBorder.none,
                                    hintText: '       Enter title',
                                    hintStyle: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    )),
                                keyboardType: TextInputType.text,
                                cursorColor: Colors.black,
                                controller: tasktitlecontroller,

                                ///enter title
                              ),
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.01),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.9,
                              decoration: new BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.rectangle,
                                border: Border.all(width: 1.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15.0)),
                              ),
                              constraints: BoxConstraints(minHeight: 60),
                              child: TextField(
                                maxLines: null,
                                onChanged: (_) {
                                  if (_.length > 0)
                                    widget.grey = false;
                                  else
                                    widget.grey = true;
                                  setState(() {});
                                },
                                decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    border: InputBorder.none,
                                    hintText: '     Enter Task description',
                                    hintStyle: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold)),
                                keyboardType: TextInputType.text,
                                // maxLines: 20,
                                cursorColor: Colors.black,
                                controller: taskdescriptioncontroller,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Text(
                                  'Start Date',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.03,
                                  ),
                                ),
                              ),
                              SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.35),
                              Text(
                                'End Date',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.03,
                                ),
                              ),
                            ]),
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Center(
                                child: GestureDetector(
                                  onTap: () async {
                                    final datePick = await showDatePicker(
                                      context: context,
                                      initialDate: new DateTime.now(),
                                      firstDate: new DateTime.now(),
                                      lastDate: new DateTime.now()
                                          .add(Duration(days: 365)),
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
                                        datePick != startDate) {
                                      setState(() {
                                        startDate = datePick;
                                        isDateSelected = true;

                                        // put it here
                                        startDateInString =
                                            "${startDate.day}/${startDate.month}/${startDate.year}";
                                        print(startDateInString); // 08/14/2019
                                      });
                                    }
                                    setState(() {});
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: MediaQuery.of(context).size.height *
                                        0.07,
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                    decoration: new BoxDecoration(
                                      color: Colors.black,
                                      shape: BoxShape.rectangle,
                                      border: Border.all(width: 1.0),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20.0)),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Container(
                                        child: Row(
                                          children: [
                                            SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.075),
                                            (startDateInString != '')
                                                ? Text(
                                                    startDateInString,
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  )
                                                : Text(
                                                    "Start date",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      color: Colors.white,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 0.075,
                              ),
                              Center(
                                child: GestureDetector(
                                  onTap: () async {
                                    final datePick = await showDatePicker(
                                      context: context,
                                      initialDate: startDate,
                                      firstDate: startDate,
                                      lastDate: new DateTime.now()
                                          .add(Duration(days: 365)),
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
                                        datePick != endDate) {
                                      setState(() {
                                        endDate = datePick;
                                        isDateSelected = true;

                                        // put it here
                                        endDateInString =
                                            "${endDate.day}/${endDate.month}/${endDate.year}";
                                        print(endDateInString); // 08/14/2019
                                      });
                                    }
                                    setState(() {});
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: MediaQuery.of(context).size.height *
                                        0.07,
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                    decoration: new BoxDecoration(
                                      color: Colors.black,
                                      shape: BoxShape.rectangle,
                                      border: Border.all(width: 1.0),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20.0)),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Container(
                                        child: Row(
                                          children: [
                                            SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.075),
                                            (endDateInString != '')
                                                ? Text(
                                                    endDateInString,
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  )
                                                : Text(
                                                    "End Date",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      color: Colors.white,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Text(
                                'Due Date',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.03,
                                ),
                              ),
                            ),
                            SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 0.35),
                            Text(
                              'Due Time',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.03,
                              ),
                            ),
                          ]),
                      Center(
                          child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Center(
                              child: GestureDetector(
                                onTap: () async {
                                  final datePick = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.now(),
                                    lastDate: startDate,
                                    builder: (context, child) {
                                      return Theme(
                                        data: Theme.of(context).copyWith(
                                          colorScheme: ColorScheme.light(
                                            primary: Colors
                                                .black, // header background color
                                            onPrimary: Colors
                                                .white, // header text color
                                            onSurface:
                                                Colors.black, // body text color
                                          ),
                                          textButtonTheme: TextButtonThemeData(
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
                                  if (datePick != null && datePick != dueDate) {
                                    setState(() {
                                      dueDate = datePick;
                                      isDateSelected = true;

                                      // put it here
                                      dueDateInString =
                                          "${dueDate.day}/${dueDate.month}/${dueDate.year}";
                                      print(dueDateInString); // 08/14/2019
                                    });
                                  }
                                  setState(() {});
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  height:
                                      MediaQuery.of(context).size.height * 0.07,
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  decoration: new BoxDecoration(
                                    color: Colors.black,
                                    shape: BoxShape.rectangle,
                                    border: Border.all(width: 1.0),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20.0)),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Container(
                                      child: Row(
                                        children: [
                                          SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.075),
                                          (dueDateInString != '')
                                              ? Text(
                                                  dueDateInString,
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                )
                                              : Text(
                                                  "Due Date",
                                                  style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: Colors.white,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.05,
                          ),
                          Container(
                              height: MediaQuery.of(context).size.height * 0.08,
                              width: MediaQuery.of(context).size.width * 0.35,
                              child: DateTimePicker(
                                type: DateTimePickerType.time,
                                textAlign: TextAlign.center,
                                timeHintText:
                                    (duetime != '') ? duetime : "Due Time",
                                cursorColor: Colors.black,
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                                timeFieldWidth: 0,
                                onChanged: (value) {
                                  duetime = value;
                                  print(duetime);
                                },
                              )),
                        ],
                      )),
                      SizedBox(
                          height:
                          MediaQuery.of(context).size.height * 0.01),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration: new BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.rectangle,
                          border: Border.all(width: 1.0),
                          borderRadius:
                          BorderRadius.all(Radius.circular(15.0)),
                        ),
                        constraints: BoxConstraints(minHeight: 60),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: TextField(
                            maxLines: null,
                            onChanged: (_) {
                              if (_.length > 0)
                                widget.grey = false;
                              else
                                widget.grey = true;
                              setState(() {});
                            },
                            decoration: InputDecoration(
                                fillColor: Colors.white,
                                border: InputBorder.none,
                                hintText: '     Enter Reason',
                                hintStyle: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                            keyboardType: TextInputType.text,
                            // maxLines: 20,
                            cursorColor: Colors.black,
                            controller: adminreasoncontroller,
                          ),
                        ),
                      ),
                      ///TODO: Add task assigning datas with setting parameters
                      ///try ov-ai profile page and try to implement according to ui design
                    ],
                  )),
            ),
            floatingActionButton: (checkInserttask == 'Update' &&
                    tasktitlecontroller.text.length > 0 &&
                    taskdescriptioncontroller.text.length > 0 &&
                    dueDateInString.length > 0 &&
                    duetime.length > 0)
                ? Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: MaterialButton(
                        onPressed: () async {
                          await FirebaseTask.updateTask(
                                  categorydb: categoryvalue,
                                  titledb: tasktitlecontroller.text,
                                  descriptiondb: taskdescriptioncontroller.text,
                                  startdatedb: startDateInString,
                                  enddatedb: endDateInString,
                                  duedatedb: dueDateInString,
                                  duetimedb: duetime,
                                  facultydb: facultyvalue,
                                  statusdb: status,
                                  reasondb: reason,
                                  admindb: adminreasoncontroller.text,
                                  docId: document!.id
                          )
                              .whenComplete(
                            () => Navigator.pop(context),
                          );
                          _clearassignpage();

                          print('updateeeeeeeeee');
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.05,
                          width: MediaQuery.of(context).size.width * 0.4,
                          decoration: new BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.rectangle,
                            border: Border.all(width: 2.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Center(
                              child: Text(
                                'Update',
                                style: GoogleFonts.lato(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.02),
                              ),
                            ),
                          ),
                        )),
                  )
                : (checkInserttask == 'Assign' &&
                        tasktitlecontroller.text.length > 0 &&
                        taskdescriptioncontroller.text.length > 0 &&
                        dueDateInString.length > 0 &&
                        duetime.length > 0)
                    ? Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: MaterialButton(
                            onPressed: () {
                              setState(() {});
                              FirebaseTask.addTask(
                                  categorydb: categoryvalue,
                                  titledb: tasktitlecontroller.text,
                                  descriptiondb: taskdescriptioncontroller.text,
                                  startdatedb: startDateInString,
                                  enddatedb: endDateInString,
                                  duedatedb: dueDateInString,
                                  duetimedb: duetime,
                                  facultydb: facultyvalue,
                                  admindb: adminreasoncontroller.text,
                                  statusdb: status,
                                  reasondb: reason
                              );
                              _clearassignpage();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => adminpage()),
                              );
                            },
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.05,
                              width: MediaQuery.of(context).size.width * 0.4,
                              decoration: new BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.rectangle,
                                border: Border.all(width: 2.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Center(
                                  child: Text(
                                    'Add Task',
                                    style: GoogleFonts.lato(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                0.02),
                                  ),
                                ),
                              ),
                            )))
                    : SizedBox()),
      ),
    );
  }

  void _clearassignpage() {
    checkInserttask = 'Assign';
    categoryvalue = "HR office duty";
    tasktitlecontroller.clear();
    taskdescriptioncontroller.clear();
    startDateInString = '';
    endDateInString = '';
    dueDateInString = '';
    duetime = "";
    facultyvalue = "Ishu";
  }
}
