import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sense_task/main.dart';
import 'package:sense_task/taskpage_a.dart';
import 'package:hive_flutter/hive_flutter.dart';

TextEditingController tasktitle = new TextEditingController();
TextEditingController taskdescription = new TextEditingController();

TextEditingController weightValue =new TextEditingController();
TextEditingController dobValue =new TextEditingController();
TextEditingController heightValue =new TextEditingController();

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
String facultyvalue = 'Ishu';
var facultylist = [
  'Ishu',
  'Haresh',
  'Mami',
  'Shobi',
];

String height = heightValue.text;

// class Task {
//   String category;
//   String title;
//   String description;
//   String eventdate;
//   String duedate;
//   String eventtime;
//   String duetime;
//   String faculty;
//   Task(this.category, this.title, this.description, this.eventdate,
//       this.duedate, this.eventtime, this.duetime, this.faculty);
// }

// List<Task> assignTaskList = [];
// bool isTaskthere = false;

class taskassign_a extends StatefulWidget {
  bool grey = true;

  @override
  State<taskassign_a> createState() => _taskassign_aState();
}

Box<dynamic> Hive_box = Hive.box('myBox');
bool isDateSelected = false;
bool isRegister = true;

class _taskassign_aState extends State<taskassign_a> {
  @override
  void initState() {
    if (Hive_box.get('assigntask') != null) {
      categoryvalue = Hive_box.get('categoryvalue');
      startDateInString = startDate.toString().substring(0, 10);
      endDateInString = endDate.toString().substring(0, 10);
      dueDateInString = dueDate.toString().substring(0, 10);
      heightValue.text = Hive_box.get('height');
      // assignTaskList = Hive_box.get('assigntask');
      // if (assignTaskList.length > 0) {
      //   isTaskthere = true;
      // }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            Container(
              //padding: EdgeInsets.fromLTRB(80, 100, 100, 0),
              child: Text(
                'Assign Task',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: MediaQuery.of(context).size.width * 0.065,
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
            Container(
              padding: EdgeInsets.fromLTRB(
                  0, 0, MediaQuery.of(context).size.width * 0.7, 2),
              child: Text(
                'Task Category',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: MediaQuery.of(context).size.width * 0.03,
                ),
              ),
            ),
            Center(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.08,
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: new BoxDecoration(
                  color: Color(0xFFF7F8F8),
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
                              color: Color(0xFF7b6f72),
                              size: 20.09,
                            ),
                            alignment: Alignment.centerLeft,
                            dropdownColor: Colors.white,
                            value: categoryvalue,
                            items: items.map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(items),
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
                              color: Color(0xFFada4a5),
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
                  color: Colors.black,
                  fontSize: MediaQuery.of(context).size.width * 0.03,
                ),
              ),
            ),

            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: new BoxDecoration(
                  color: Color(0xFFF7F8F8),
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
                              labelText: 'Enter title',
                              labelStyle: TextStyle(color: Colors.black)),
                          keyboardType: TextInputType.multiline,
                          maxLines: 20,
                          cursorColor: Colors.black,
                          controller: tasktitle,
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
                              labelText: 'Enter Task description',
                              labelStyle: TextStyle(color: Colors.black)),
                          //keyboardType: TextInputType.multiline,
                          // maxLines: 20,
                          cursorColor: Colors.black,
                          controller: taskdescription,
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
                  color: Colors.black,
                  fontSize: MediaQuery.of(context).size.width * 0.03,
                ),
              ),
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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
                                  primary:
                                      Colors.black, // header background color
                                  onPrimary: Colors.white, // header text color
                                  onSurface: Colors.black, // body text color
                                ),
                                textButtonTheme: TextButtonThemeData(
                                  style: TextButton.styleFrom(
                                    primary: Colors.black, // button text color
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
                                "${startDate.month}/${startDate.day}/${startDate.year}";
                            print(startDateInString); // 08/14/2019
                          });
                        }
                        setState(() {});
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.08,
                        width: MediaQuery.of(context).size.width * 0.45,
                        decoration: new BoxDecoration(
                          color: Color(0xFFF7F8F8),
                          shape: BoxShape.rectangle,
                          border: Border.all(width: 2.0),
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        ),
                        child: Row(
                          children: [
                            SizedBox(width: 5),
                            Icon(
                              Icons.calendar_month_sharp,
                              color: Color(0xFF7b6f72),
                              size: 30,
                            ),
                            SizedBox(width: 10),
                            (startDateInString != '')
                                ? Text(
                                    startDateInString,
                                    style: TextStyle(color: Colors.black38),
                                  )
                                : Text(
                                    "Start date",
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      color: (weightValue.text == '')
                                          ? Color(0xFFada4a5)
                                          : Colors.transparent,
                                      fontSize: 15,
                                    ),
                                  )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Center(
                    child: GestureDetector(
                      onTap: () async {
                        final datePick = await showDatePicker(
                          context: context,
                          initialDate: endDate,
                          firstDate: startDate,
                          lastDate: new DateTime.now(),
                          builder: (context, child) {
                            return Theme(
                              data: Theme.of(context).copyWith(
                                colorScheme: ColorScheme.light(
                                  primary:
                                      Colors.black, // header background color
                                  onPrimary: Colors.white, // header text color
                                  onSurface: Colors.black, // body text color
                                ),
                                textButtonTheme: TextButtonThemeData(
                                  style: TextButton.styleFrom(
                                    primary: Colors.black, // button text color
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
                                "${endDate.month}/${endDate.day}/${endDate.year}";
                            print(endDateInString); // 08/14/2019
                          });
                        }
                        setState(() {});
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.08,
                        width: MediaQuery.of(context).size.width * 0.45,
                        decoration: new BoxDecoration(
                          color: Color(0xFFF7F8F8),
                          shape: BoxShape.rectangle,
                          border: Border.all(width: 2.0),
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        ),
                        child: Row(
                          children: [
                            SizedBox(width: 5),
                            Icon(
                              Icons.calendar_month_sharp,
                              color: Color(0xFF7b6f72),
                              size: 30,
                            ),
                            SizedBox(width: 10),
                            (endDateInString != '')
                                ? Text(
                                    endDateInString,
                                    style: TextStyle(color: Colors.black38),
                                  )
                                : Text(
                                    "End date",
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      color: (weightValue.text == '')
                                          ? Color(0xFFada4a5)
                                          : Colors.transparent,
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
            Center(
              child: GestureDetector(
                onTap: () async {
                  final datePick = await showDatePicker(
                    context: context,
                    initialDate: dueDate,
                    firstDate: startDate,
                    lastDate: DateTime.now().add(new Duration(days: 90)),
                    builder: (context, child) {
                      return Theme(
                        data: Theme.of(context).copyWith(
                          colorScheme: ColorScheme.light(
                            primary: Colors.black, // header background color
                            onPrimary: Colors.white, // header text color
                            onSurface: Colors.black, // body text color
                          ),
                          textButtonTheme: TextButtonThemeData(
                            style: TextButton.styleFrom(
                              primary: Colors.black, // button text color
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
                          "${dueDate.month}/${dueDate.day}/${dueDate.year}";
                      print(dueDateInString); // 08/14/2019
                    });
                  }
                  setState(() {});
                },
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.08,
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: new BoxDecoration(
                    color: Color(0xFFF7F8F8),
                    shape: BoxShape.rectangle,
                    border: Border.all(width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  ),
                  child: Row(
                    children: [
                      SizedBox(width: 20),
                      Icon(
                        Icons.calendar_month_sharp,
                        color: Color(0xFF7b6f72),
                        size: 30,
                      ),
                      SizedBox(width: 30),
                      (dueDateInString != '')
                          ? Text(
                              dueDateInString,
                              style: TextStyle(color: Colors.black38),
                            )
                          : Text(
                              "Due Date",
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                color: (weightValue.text == '')
                                    ? Color(0xFFada4a5)
                                    : Colors.transparent,
                                fontSize: 15,
                              ),
                            )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Container(
              padding: EdgeInsets.fromLTRB(
                  15, 0, MediaQuery.of(context).size.width * 0.7, 2),
              child: Text(
                'Event Timings (optional)',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: MediaQuery.of(context).size.width * 0.03,
                ),
              ),
            ),
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
                            primary: Colors.black, // header background color
                            onPrimary: Colors.white, // header text color
                            onSurface: Colors.black, // body text color
                          ),
                          textButtonTheme: TextButtonThemeData(
                            style: TextButton.styleFrom(
                              primary: Colors.black, // button text color
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
                          "${dueDate.month}/${dueDate.day}/${dueDate.year}";
                      print(dueDateInString); // 08/14/2019
                    });
                  }
                  setState(() {});
                },
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.08,
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: new BoxDecoration(
                    color: Color(0xFFF7F8F8),
                    shape: BoxShape.rectangle,
                    border: Border.all(width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  ),
                  child: Row(
                    children: [
                      SizedBox(width: 20),
                      Icon(
                        Icons.calendar_month_sharp,
                        color: Color(0xFF7b6f72),
                        size: 30,
                      ),
                      SizedBox(width: 30),
                      (dueDateInString != '')
                          ? Text(
                              dueDateInString,
                              style: TextStyle(color: Colors.black38),
                            )
                          : Text(
                              "Due Date",
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                color: (weightValue.text == '')
                                    ? Color(0xFFada4a5)
                                    : Colors.transparent,
                                fontSize: 15,
                              ),
                            )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
            Container(
              padding: EdgeInsets.fromLTRB(
                  0, 0, MediaQuery.of(context).size.width * 0.7, 2),
              child: Text(
                'Task Category',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: MediaQuery.of(context).size.width * 0.03,
                ),
              ),
            ),
            Center(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.08,
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: new BoxDecoration(
                  color: Color(0xFFF7F8F8),
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
                              color: Color(0xFF7b6f72),
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
                            // After selecting the desired option,it will
                            // change button value to selected value
                            onChanged: (String? newValue) {
                              setState(() {
                                facultyvalue = newValue!;
                              });
                            },
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              color: Color(0xFFada4a5),
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

            // Center(
            //   child: Container(
            //     height: 65,
            //     width: 3005,
            //     decoration: new BoxDecoration(
            //       color: Color(0xFFF7F8F8),
            //       shape: BoxShape.rectangle,
            //       borderRadius: BorderRadius.all(Radius.circular(14.0)),
            //     ),
            //     child: Stack(children: [
            //       Padding(
            //         padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            //         child: TextField(
            //           style: TextStyle(
            //               fontWeight: FontWeight.normal,
            //               color: Colors.black,
            //               fontSize: 15),
            //           keyboardType: TextInputType.number,
            //           textAlign: TextAlign.left,
            //           cursorColor: Colors.grey,
            //           controller: heightValue,
            //           inputFormatters: <TextInputFormatter>[
            //             FilteringTextInputFormatter.singleLineFormatter
            //           ],
            //           decoration: InputDecoration(
            //             border: InputBorder.none,
            //             focusedBorder: InputBorder.none,
            //             enabledBorder: InputBorder.none,
            //             errorBorder: InputBorder.none,
            //             disabledBorder: InputBorder.none,
            //             // hintText: "Your Height",
            //             hintText: 'Your Height',
            //             hintStyle: TextStyle(
            //               fontWeight: FontWeight.normal,
            //               color: Colors.black,
            //               fontSize: 15,
            //             ),
            //             icon: Icon(
            //               Icons.height_sharp,
            //               color: Color(0xFF7b6f72),
            //               size: 30,
            //             ),
            //             fillColor: Colors.grey,
            //           ),
            //         ),
            //       ),
            //     ]),
            //   ),
            // ),

            ///TODO: Add task assigning datas with setting parameters
            ///try ov-ai profile page and try to implement according to ui design
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TabsScreen()),
          );
        },
        child: const Icon(Icons.done),
      ),
    );
  }
}
