import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sense_task/main.dart';
import 'package:sense_task/taskpage_a.dart';
import 'package:hive_flutter/hive_flutter.dart';
TextEditingController weightValue = TextEditingController();
TextEditingController dobValue = TextEditingController();
TextEditingController heightValue = TextEditingController();
String birthDateInString = '';
DateTime birthDate = DateTime.now();

String Stafflist = 'Staffs';
var items = ['Staffs', 'Other'];
String height = heightValue.text ;
class Task {
 String category;
 String title;
 String description;
 String eventdate;
 String duedate;
 String eventtime;
 String duetime;
 String faculty;
  Task(this.category,this.title,this.description,this.eventdate,this.duedate,this.eventtime,
      this.duetime,this.faculty);
}
List<Task> assignTaskList = [];
bool isTaskthere = false;

class taskassign_a extends StatefulWidget {
  taskassign_a();

  @override
  State<taskassign_a> createState() => _taskassign_aState();
}
Box<dynamic> Hive_box = Hive.box('myBox');
bool isDateSelected = false;
bool isRegister = true;
class _taskassign_aState extends State<taskassign_a> {
  @override
  void initState() {
    if (Hive_box.get('assigntask') != null)
    {
      Stafflist = Hive_box.get('StaffList');
      birthDateInString = birthDate.toString().substring(0, 10);
      heightValue.text = Hive_box.get('height');
      assignTaskList=Hive_box.get('assigntask');
      if (assignTaskList.length>0){
        isTaskthere = true;
      }
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Center(
        child:Column(
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
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03),
            Container(
              padding: EdgeInsets.fromLTRB(0, 0, MediaQuery.of(context).size.width * 0.7, 0),
              child: Text(
                'Faculty',
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
                  borderRadius:
                  BorderRadius.all(Radius.circular(15.0)),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        SizedBox(width: 20),

                        Container(
                          child: Icon(
                            Icons.people,
                            color: Color(0xFF7b6f72),
                            size: 30,
                          ),
                        ),
                         SizedBox( width: MediaQuery.of(context).size.width * 0.25),
                        new DropdownButtonHideUnderline(
                          child: DropdownButton(
                            icon: Icon(
                              Icons.arrow_drop_down,
                              color: Color(0xFF7b6f72),
                              size: 20.09,
                            ),
                            alignment: Alignment.center,
                            dropdownColor: Colors.white,
                            value: Stafflist,
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
                                Stafflist = newValue!;
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
            Center(
              child: GestureDetector(
                onTap: () async {
                  final datePick = await showDatePicker(
                    context: context,
                    initialDate: birthDate,
                    firstDate: new DateTime(1900),
                    lastDate: new DateTime.now(),
                    builder: (context, child) {
                      return Theme(
                        data: Theme.of(context).copyWith(
                          colorScheme: ColorScheme.light(
                            primary: Colors.black, // header background color
                            onPrimary:
                            Colors.white, // header text color
                            onSurface:
                            Colors.black, // body text color
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
                  if (datePick != null && datePick != birthDate) {
                    setState(() {
                      birthDate = datePick;
                      isDateSelected = true;

                      // put it here
                      birthDateInString =
                      "${birthDate.month}/${birthDate.day}/${birthDate.year}";
                      print(birthDateInString); // 08/14/2019
                    });
                  }
                  setState(() {});
                },
                child: Container(
                  height: 65,
                  width: 300,
                  decoration: new BoxDecoration(
                    color: Color(0xFFF7F8F8),
                    shape: BoxShape.rectangle,
                    borderRadius:
                    BorderRadius.all(Radius.circular(14.0)),
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
                      (birthDateInString != '')
                          ? Text(
                        birthDateInString,
                        style: TextStyle(color: Colors.black38),
                      )
                          : Text(
                        "<- Select Date of Birth",
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
            Center(
              child: Container(
                height: 65,
                width: 3005,
                decoration: new BoxDecoration(
                  color: Color(0xFFF7F8F8),
                  shape: BoxShape.rectangle,
                  borderRadius:
                  BorderRadius.all(Radius.circular(14.0)),
                ),
                child: Stack(children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: 15, horizontal: 20),
                    child: TextField(
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                          fontSize: 15),
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.left,
                      cursorColor: Colors.grey,
                      controller: heightValue,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.singleLineFormatter
                      ],
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        // hintText: "Your Height",
                        hintText: 'Your Height',
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                          fontSize: 15,
                        ),
                        icon: Icon(
                          Icons.height_sharp,
                          color: Color(0xFF7b6f72),
                          size: 30,
                        ),
                        fillColor: Colors.grey,
                      ),
                    ),
                  ),
                ]),
              ),
            ),
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
