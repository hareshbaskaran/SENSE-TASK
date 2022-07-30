import 'TaskPage_Admin.dart';
import 'package:sense_task/TaskMango.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sense_task/main.dart';
import 'package:mongo_dart/mongo_dart.dart' as T;
import 'mangodb.dart';
import 'TaskMango.dart';
import 'package:google_fonts/google_fonts.dart';

List<Widget> allTasks = [];

TextEditingController tasktitlecontroller = new TextEditingController();

TextEditingController taskdescriptioncontroller = new TextEditingController();

var checkInserttask = "Assign";

String startDateInString = '';
DateTime startDate = DateTime.now();

String endDateInString = '';
DateTime endDate = DateTime.now();

String dueDateInString = '';
DateTime dueDate = DateTime.now();

TaskMongo? task_data;

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
String facultyvalue = 'Ishu';
var facultylist = [
  'Ishu',
  'Haresh',
  'Mami',
  'Shobi',
];

String duetime = '';

int status = 0;

String reason = '';

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
    TaskMongo? task_data =
        ModalRoute.of(context)!.settings.arguments as TaskMongo?;
    // void initState() {
    //   super.initState();
    //   if (task_data != null) {
    //     print('Updating UI');
    //     categoryvalue = task_data.categorydb;
    //     tasktitlecontroller.text = task_data.titledb;
    //     taskdescriptioncontroller.text = task_data.descriptiondb;
    //     startDateInString = task_data.startdatedb;
    //     endDateInString = task_data.enddatedb;
    //     dueDateInString = task_data.duedatedb;
    //     duetime = task_data.duetimedb;
    //     facultyvalue = task_data.facultydb;
    //     _checkInserttask = "update";
    //     print(categoryvalue);
    //     print(tasktitlecontroller.text);
    //
    //     print(taskdescriptioncontroller.text);
    //     print(startDate);
    //     print(startDateInString);
    //     print(endDate);
    //     print(endDateInString);
    //     print(dueDate);
    //     print(dueDateInString);
    //     print(duetime);
    //     print(facultyvalue);
    //   }
    //   ;
    // }

    return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 30),
            child: ListView(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                Center(
                    child: Stack(children: [
                  Center(
                    child: Container(
                      //padding: EdgeInsets.fromLTRB(80, 100, 100, 0),
                      child: Text(
                        checkInserttask + 'Task',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: MediaQuery.of(context).size.width * 0.065,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    child: BackButton(
                        color: Colors.black,
                        onPressed: () {
                          Navigator.pop(
                            context,
                            MaterialPageRoute(
                                builder: (context) => taskpage_a()),
                          );
                          setState(() => isEdit = 0);
                        }),
                  ),
                ])),

                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                Container(
                  padding: EdgeInsets.fromLTRB(
                      0, 0, MediaQuery.of(context).size.width * 0.7, 2),
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
                    height: MediaQuery.of(context).size.height * 0.08,
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: new BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.rectangle,
                      border: Border.all(width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
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
                                  color: Colors.black,
                                  size: 20.09,
                                ),
                                alignment: Alignment.centerLeft,
                                dropdownColor: Colors.white,
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
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(
                      0, 0, MediaQuery.of(context).size.width * 0.7, 2),
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
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: new BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.rectangle,
                      border: Border.all(width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
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
                              decoration: InputDecoration(
                                  fillColor: Colors.black,
                                  border: InputBorder.none,
                                  hintText: 'Enter title',
                                  hintStyle: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                              keyboardType: TextInputType.text,
                              maxLines: 2,
                              cursorColor: Colors.black,
                              controller: tasktitlecontroller,

                              ///enter title
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
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
                                  fillColor: Colors.black,
                                  border: InputBorder.none,
                                  hintText: 'Enter Task description',
                                  hintStyle: TextStyle(color: Colors.black)),
                              keyboardType: TextInputType.text,
                              // maxLines: 20,
                              cursorColor: Colors.black,
                              controller: taskdescriptioncontroller,

                              ///task description
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
                Container(
                  padding: EdgeInsets.fromLTRB(
                      0, 0, MediaQuery.of(context).size.width * 0.7, 2),
                  child: Text(
                    'Event Date',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: MediaQuery.of(context).size.width * 0.03,
                    ),
                  ),
                ),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      /*Container(
                        color: Colors.transparent,
                        height: MediaQuery.of(context).size.height * 0.08,
                        width: MediaQuery.of(context).size.width * 0.175,
                        decoration: new BoxDecoration(
                          color: Colors.black,
                          shape: BoxShape.rectangle,
                          border: Border.all(width: 2.0),
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        ),
                        child: Icon(
                          Icons.date_range,
                          color: Colors.white,
                          size: MediaQuery.of(context).size.width * 0.1,
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.025,
                      ),*/
                      Center(
                        child: GestureDetector(
                          onTap: () async {
                            final datePick = await showDatePicker(
                              context: context,
                              initialDate: startDate,
                              firstDate: new DateTime(1900),
                              lastDate: new DateTime.now(),
                              builder: (context, child) {
                                return Theme(
                                  data: Theme.of(context).copyWith(
                                    colorScheme: ColorScheme.light(
                                      primary: Colors
                                          .black, // header background color
                                      onPrimary:
                                          Colors.white, // header text color
                                      onSurface:
                                          Colors.black, // body text color
                                    ),
                                    textButtonTheme: TextButtonThemeData(
                                      style: TextButton.styleFrom(
                                        primary:
                                            Colors.black, // button text color
                                      ),
                                    ),
                                  ),
                                  child: child!,
                                );
                              },
                            );
                            if (datePick != null && datePick != startDate) {
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
                            height: MediaQuery.of(context).size.height * 0.08,
                            width: MediaQuery.of(context).size.width * 0.35,
                            decoration: new BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.rectangle,
                              border: Border.all(width: 2.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.0)),
                            ),
                            child: Row(
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.025,
                                ),
                                Icon(
                                  Icons.calendar_month_sharp,
                                  color: Colors.black,
                                  size: 30,
                                ),
                                SizedBox(width: 5),
                                (startDateInString != '')
                                    ? Text(
                                        startDateInString,
                                        style: TextStyle(color: Colors.black),
                                      )
                                    : Text(
                                        "Start date",
                                        style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black,
                                          fontSize: 15,
                                        ),
                                      )
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.025,
                      ),
                      Center(
                        child: GestureDetector(
                          onTap: () async {
                            final datePick = await showDatePicker(
                              context: context,
                              initialDate: endDate,
                              firstDate: new DateTime(1900),
                              lastDate: new DateTime.now(),
                              builder: (context, child) {
                                return Theme(
                                  data: Theme.of(context).copyWith(
                                    colorScheme: ColorScheme.light(
                                      primary: Colors
                                          .black, // header background color
                                      onPrimary:
                                          Colors.white, // header text color
                                      onSurface:
                                          Colors.black, // body text color
                                    ),
                                    textButtonTheme: TextButtonThemeData(
                                      style: TextButton.styleFrom(
                                        primary:
                                            Colors.black, // button text color
                                      ),
                                    ),
                                  ),
                                  child: child!,
                                );
                              },
                            );
                            if (datePick != null && datePick != endDate) {
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
                            height: MediaQuery.of(context).size.height * 0.08,
                            width: MediaQuery.of(context).size.width * 0.35,
                            decoration: new BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.rectangle,
                              border: Border.all(width: 2.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.0)),
                            ),
                            child: Row(
                              children: [
                                SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.025),
                                Icon(
                                  Icons.calendar_month_sharp,
                                  color: Colors.black,
                                  size: 30,
                                ),
                                SizedBox(width: 10),
                                (endDateInString != '')
                                    ? Text(
                                        endDateInString,
                                        style: TextStyle(color: Colors.black),
                                      )
                                    : Text(
                                        "End date",
                                        style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black,
                                          fontSize: 15,
                                        ),
                                      )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(
                      0, 0, MediaQuery.of(context).size.width * 0.7, 2),
                  child: Text(
                    'Due Details',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: MediaQuery.of(context).size.width * 0.03,
                    ),
                  ),
                ),
                Row(
                  children: [
                    /*Container(
                      color: Colors.transparent,
                        height: MediaQuery.of(context).size.height * 0.08,
                        width: MediaQuery.of(context).size.width * 0.175,
                        decoration: new BoxDecoration(
                          color: Colors.black,
                          shape: BoxShape.rectangle,
                          border: Border.all(width: 2.0),
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        ),
                        child: Center(
                          child: Text(
                            'DUE',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.05),
                          ),
                        )),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.025),*/
                    Center(
                      child: GestureDetector(
                        onTap: () async {
                          final datePick = await showDatePicker(
                            context: context,
                            initialDate: dueDate,
                            firstDate: new DateTime(1900),
                            lastDate: new DateTime.now(),
                            builder: (context, child) {
                              return Theme(
                                data: Theme.of(context).copyWith(
                                  colorScheme: ColorScheme.light(
                                    primary:
                                        Colors.black, // header background color
                                    onPrimary:
                                        Colors.white, // header text color
                                    onSurface: Colors.black, // body text color
                                  ),
                                  textButtonTheme: TextButtonThemeData(
                                    style: TextButton.styleFrom(
                                      primary:
                                          Colors.black, // button text color
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
                          height: MediaQuery.of(context).size.height * 0.08,
                          width: MediaQuery.of(context).size.width * 0.35,
                          decoration: new BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.rectangle,
                            border: Border.all(width: 2.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                          ),
                          child: Row(
                            children: [
                              SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 0.025,
                              ),
                              Icon(
                                Icons.calendar_month_sharp,
                                color: Colors.black,
                                size: 30,
                              ),
                              SizedBox(width: 5),
                              (dueDateInString != '')
                                  ? Text(
                                      dueDateInString,
                                      style: TextStyle(color: Colors.black),
                                    )
                                  : Text(
                                      "Due date",
                                      style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        color: Colors.black,
                                        fontSize: 15,
                                      ),
                                    )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.025),
                    Row(
                      children: [
                        Container(
                            height: MediaQuery.of(context).size.height * 0.08,
                            width: MediaQuery.of(context).size.width * 0.35,
                            decoration: new BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.rectangle,
                              border: Border.all(width: 2.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.0)),
                            ),
                            child: DateTimePicker(
                              icon: Icon(
                                Icons.timelapse_outlined,
                                color: Colors.black,
                                size: 30,
                              ),
                              type: DateTimePickerType.time,
                              textAlign: TextAlign.center,
                              timeHintText: 'time',
                              cursorColor: Colors.black,
                              style: TextStyle(
                                color: Colors.black,
                              ),
                              timeFieldWidth: 0,
                              onChanged: (value) {
                                duetime = value;
                                print('timeeeee');
                                print(duetime);
                              },
                            )),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                Container(
                  padding: EdgeInsets.fromLTRB(
                      0, 0, MediaQuery.of(context).size.width * 0.7, 2),
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
                    height: MediaQuery.of(context).size.height * 0.08,
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: new BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.rectangle,
                      border: Border.all(width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
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
                                  color: Colors.black,
                                  size: 20.09,
                                ),
                                alignment: Alignment.centerLeft,
                                dropdownColor: Colors.white,
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
                ),

                ///TODO: Add task assigning datas with setting parameters
                ///try ov-ai profile page and try to implement according to ui design
              ],
            ),
          ),
        ),
        floatingActionButton: (isEdit == 1)
            ? Padding(
                padding: const EdgeInsets.all(15.0),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        elevation: 5.0,
                        shape: StadiumBorder(),
                        primary: Colors.black),
                    onPressed: () async {
                      print('before updating in db');
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
                      await _updateTask(
                          task_data!.id_t,
                          categoryvalue,
                          tasktitlecontroller.text,
                          taskdescriptioncontroller.text,
                          startDateInString,
                          endDateInString,
                          dueDateInString,
                          duetime,
                          facultyvalue,
                          status,
                          reason);

                      _clearassignpage();

                      print('updateeeeeeeeee');
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => taskpage_a()),
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(
                          MediaQuery.of(context).size.height * 0.04,
                          12,
                          MediaQuery.of(context).size.height * 0.04,
                          12),
                      child: Text(
                        'Update',
                        style: GoogleFonts.lato(
                            color: Colors.white,
                            fontSize:
                                MediaQuery.of(context).size.height * 0.02),
                      ),
                    )),
              )
            : Padding(
                padding: const EdgeInsets.all(15.0),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        elevation: 5.0,
                        shape: StadiumBorder(),
                        primary: Colors.black),
                    onPressed: () {
                      setState(() => isEdit = 0);
                      _inserttask(
                          categoryvalue,
                          tasktitlecontroller.text,
                          taskdescriptioncontroller.text,
                          startDateInString,
                          endDateInString,
                          dueDateInString,
                          duetime,
                          facultyvalue,
                          status,
                          reason);
                      _clearassignpage();
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => taskpage_a()),
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(
                          MediaQuery.of(context).size.height * 0.04,
                          12,
                          MediaQuery.of(context).size.height * 0.04,
                          12),
                      child: Text(
                        'Add Task',
                        style: GoogleFonts.lato(
                            color: Colors.white,
                            fontSize:
                                MediaQuery.of(context).size.height * 0.02),
                      ),
                    )),
              ));
  }

  void _clearassignpage() {
    categoryvalue = "HR office duty";
    tasktitlecontroller.clear();
    taskdescriptioncontroller.clear();
    startDateInString = '';
    endDateInString = '';
    dueDateInString = '';
    duetime = "";
    facultyvalue = "Ishu";
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

  Future<void> _inserttask(
      String category1,
      String title1,
      String description1,
      String startdate1,
      String enddate1,
      String duedate1,
      String duetime1,
      String faculty1,
      int status1,
      String reason1) async {
    var id_task = T.ObjectId();
    task_data = TaskMongo(
        id_t: id_task,
        categorydb: category1,
        titledb: title1,
        descriptiondb: description1,
        startdatedb: startdate1,
        enddatedb: enddate1,
        duedatedb: duedate1,
        duetimedb: duetime1,
        facultydb: faculty1,
        statusdb: status1,
        reasondb: reason1);
    var result = await MongoDbModel.insert_task(task_data!);
  }
}
