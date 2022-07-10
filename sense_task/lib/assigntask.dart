import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sense_task/main.dart';
import 'package:sense_task/taskpage_a.dart';

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
  'Venue Preparation for TRB/TNPSC exams fvgfdgfdgdg',
  'OTHERS'
];

class taskassign extends StatefulWidget {
  const taskassign({Key? key}) : super(key: key);

  @override
  State<taskassign> createState() => _taskassignState();
}

class _taskassignState extends State<taskassign> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => TabsScreen()));
        },
        child: const Icon(Icons.check),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 24),
        child: Column(
          children: [
            Container(
              //padding: EdgeInsets.fromLTRB(80, 100, 100, 0),
              child: Center(
                child: Text(
                  'Assign Task',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: MediaQuery.of(context).size.width * 0.065,
                  ),
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
            Container(
              padding: EdgeInsets.fromLTRB(
                  0, 0, MediaQuery.of(context).size.width * 0.7, 0),
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
                height: 65,
                //height: SizeConfig. screenHeight * 0.1,
                width: MediaQuery.of(context).size.width,
                decoration: new BoxDecoration(
                  color: Color(0xFFF7F8F8),
                  shape: BoxShape.rectangle,
                  border: Border.all(width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                ),
                child: Row(
                  //mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: 20),
                    new DropdownButtonHideUnderline(
                      child: DropdownButton(
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: Color(0xFF7b6f72),
                          size: 20,
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
                          print(newValue);
                          setState(() {
                            categoryvalue = newValue!;
                          });
                        },
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.normal,
                          color: Color(0xFFada4a5),
                          fontSize: 15,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
