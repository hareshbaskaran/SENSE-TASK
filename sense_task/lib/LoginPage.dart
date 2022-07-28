import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;
import 'package:sense_task/UserMango.dart';
import 'package:sense_task/main.dart';
import 'package:sense_task/mangodb.dart';
import 'StaffPage_Admin.dart';

TextEditingController usernamevalue_admin = new TextEditingController();
TextEditingController passwordvalue_admin = new TextEditingController();
String username_admin = usernamevalue_admin.text;
String password_admin = passwordvalue_admin.text;
TextEditingController usernamevalue_user = new TextEditingController();
TextEditingController passwordvalue_user = new TextEditingController();
String username_user = usernamevalue_user.text;
String password_user = passwordvalue_user.text;
bool grey = true;
int adminpage = 0;

class loginpage extends StatefulWidget {
  const loginpage({Key? key}) : super(key: key);

  @override
  State<loginpage> createState() => _loginpageState();
}

class _loginpageState extends State<loginpage> {
  bool grey = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  textAlign: TextAlign.center,
                  'SENSE TASK MANAGEMENT',
                  style: GoogleFonts.lato(
                      color: Colors.black,
                      fontSize: MediaQuery.of(context).size.width * 0.075),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.025),
                Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.03,
                      right: MediaQuery.of(context).size.width * 0.03),
                  child: Container(
                      child: Image(
                          image: AssetImage('assets/images/loginpic.png'))),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                (adminpage == 0)
                    ? Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    elevation: 5.0,
                                    shape: StadiumBorder(),
                                    primary: Colors.black),
                                onPressed: () {
                                  setState(() {
                                    adminpage = 1;
                                  });
                                },
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(
                                      MediaQuery.of(context).size.height * 0.04,
                                      12,
                                      MediaQuery.of(context).size.height * 0.04,
                                      12),
                                  child: Text(
                                    'Login as Admin',
                                    style: GoogleFonts.lato(
                                        color: Colors.white,
                                        fontSize:
                                            MediaQuery.of(context).size.height *
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
                                onPressed: () {
                                  setState(() {
                                    adminpage = 2;
                                  });
                                },
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(
                                      MediaQuery.of(context).size.height * 0.04,
                                      12,
                                      MediaQuery.of(context).size.height * 0.04,
                                      12),
                                  child: Text(
                                    'Login as User',
                                    style: GoogleFonts.lato(
                                        color: Colors.white,
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                0.02),
                                  ),
                                )),
                          )
                        ],
                      )
                    : (adminpage == 1)
                        ? Column(children: [
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(3),
                                  alignment: Alignment.centerLeft,
                                  child: TextButton(
                                      onPressed: () {
                                        setState(() {
                                          adminpage = 0;
                                        });
                                      },
                                      child: Icon(
                                        Icons.arrow_back_ios,
                                        color: Colors.black,
                                      )),
                                ),
                                Text(
                                  textAlign: TextAlign.center,
                                  'Login as Admin',
                                  style: GoogleFonts.lato(
                                      color: Colors.black,
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.075),
                                ),
                              ],
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(0, 0,
                                  MediaQuery.of(context).size.width * 0.7, 0),
                              child: Text(
                                'username',
                                style: GoogleFonts.lato(
                                    color: Colors.black,
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.03),
                              ),
                            ),
                            Center(
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.9,
                                decoration: new BoxDecoration(
                                  color: Color(0xFFF7F8F8),
                                  shape: BoxShape.rectangle,
                                  border: Border.all(width: 2.0),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0)),
                                ),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        constraints: BoxConstraints(
                                            minHeight: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.05),
                                        child: TextField(
                                          maxLines: 1,
                                          onChanged: (_) {
                                            setState(() {});
                                          },
                                          decoration: InputDecoration(
                                            fillColor: Colors.black,
                                            border: InputBorder.none,
                                          ),
                                          cursorColor: Colors.black,
                                          controller: usernamevalue_admin,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.025),
                            /*   Container(
                              padding: EdgeInsets.fromLTRB(0, 0,
                                  MediaQuery.of(context).size.width * 0.7, 0),
                              child: Text(
                                'password',
                                style: GoogleFonts.lato(
                                    color: Colors.black,
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.03),
                              ),
                            ),
                            Center(
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.9,
                                decoration: new BoxDecoration(
                                  color: Color(0xFFF7F8F8),
                                  shape: BoxShape.rectangle,
                                  border: Border.all(width: 2.0),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0)),
                                ),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        constraints: BoxConstraints(
                                            minHeight: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.05),
                                        child: TextField(
                                          maxLines: 1,
                                          onChanged: (_) {
                                            setState(() {});
                                          },
                                          decoration: InputDecoration(
                                            fillColor: Colors.black,
                                            border: InputBorder.none,
                                          ),
                                          cursorColor: Colors.black,
                                          controller: passwordvalue_admin,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.025),*/
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          elevation: 5.0,
                                          shape: StadiumBorder(),
                                          primary: Colors.black),
                                      onPressed: () {
                                        ///todo: implement querry check on admin
                                        if (AdminQuerryLength != "null") {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    TabsScreen()),
                                          );
                                          print(
                                              "supeerstar $AdminQuerryLength");
                                        } else {
                                          print(
                                              "poweerstar $AdminQuerryLength");
                                        }
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.fromLTRB(
                                            MediaQuery.of(context).size.height *
                                                0.048,
                                            12,
                                            MediaQuery.of(context).size.height *
                                                0.048,
                                            12),
                                        child: Text(
                                          'Login',
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
                            // Center(
                            //   child: ElevatedButton(
                            //       onPressed: () {
                            //         _insertData(usernamevalue.text, passwordvalue.text);
                            //         Navigator.push(
                            //           context,
                            //           MaterialPageRoute(builder: (context) => TabsScreen()),
                            //         );
                            //
                            //         ///polymorphism
                            //       },
                            //       child: Container(
                            //         height: MediaQuery.of(context).size.height * 0.05,
                            //         width: MediaQuery.of(context).size.width * 0.6,
                            //         decoration: new BoxDecoration(
                            //           color: Colors.black,
                            //           shape: BoxShape.rectangle,
                            //           border: Border.all(width: 2.0),
                            //           borderRadius: BorderRadius.all(Radius.circular(15.0)),
                            //         ),
                            //         child: Center(
                            //           child: Text(
                            //             "Login ",
                            //             style: TextStyle(
                            //               color: Colors.white,
                            //             ),
                            //           ),
                            //         ),
                            //       )),
                            // ),],);
                          ])
                        : (adminpage == 2)
                            ? Column(children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(3),
                                      alignment: Alignment.centerLeft,
                                      child: TextButton(
                                          onPressed: () {
                                            setState(() {
                                              adminpage = 0;
                                            });
                                          },
                                          child: Icon(
                                            Icons.arrow_back_ios,
                                            color: Colors.black,
                                          )),
                                    ),
                                    Text(
                                      textAlign: TextAlign.center,
                                      'Login as User',
                                      style: GoogleFonts.lato(
                                          color: Colors.black,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.075),
                                    ),
                                  ],
                                ),
                                Container(
                                  padding: EdgeInsets.fromLTRB(
                                      0,
                                      0,
                                      MediaQuery.of(context).size.width * 0.7,
                                      0),
                                  child: Text(
                                    'username',
                                    style: GoogleFonts.lato(
                                        color: Colors.black,
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.03),
                                  ),
                                ),
                                Center(
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.9,
                                    decoration: new BoxDecoration(
                                      color: Color(0xFFF7F8F8),
                                      shape: BoxShape.rectangle,
                                      border: Border.all(width: 2.0),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15.0)),
                                    ),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            constraints: BoxConstraints(
                                                minHeight:
                                                    MediaQuery.of(context)
                                                            .size
                                                            .height *
                                                        0.05),
                                            child: TextField(
                                              maxLines: 1,
                                              onChanged: (_) {
                                                setState(() {});
                                              },
                                              decoration: InputDecoration(
                                                fillColor: Colors.black,
                                                border: InputBorder.none,
                                              ),
                                              cursorColor: Colors.black,
                                              controller: usernamevalue_user,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.025),
                                /*           Container(
                                  padding: EdgeInsets.fromLTRB(
                                      0,
                                      0,
                                      MediaQuery.of(context).size.width * 0.7,
                                      0),
                                  child: Text(
                                    'password',
                                    style: GoogleFonts.lato(
                                        color: Colors.black,
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.03),
                                  ),
                                ),
                                Center(
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.9,
                                    decoration: new BoxDecoration(
                                      color: Color(0xFFF7F8F8),
                                      shape: BoxShape.rectangle,
                                      border: Border.all(width: 2.0),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15.0)),
                                    ),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            constraints: BoxConstraints(
                                                minHeight:
                                                    MediaQuery.of(context)
                                                            .size
                                                            .height *
                                                        0.05),
                                            child: TextField(
                                              maxLines: 1,
                                              onChanged: (_) {
                                                setState(() {});
                                              },
                                              decoration: InputDecoration(
                                                fillColor: Colors.black,
                                                border: InputBorder.none,
                                              ),
                                              cursorColor: Colors.black,
                                              controller: passwordvalue_user,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.025),*/
                                Row(
                                  children: [
                                    /*Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              elevation: 5.0,
                                              shape: StadiumBorder(),
                                              primary: Colors.black),
                                          onPressed: () {},
                                          child: Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.04,
                                                12,
                                                MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.04,
                                                12),
                                            child: Text(
                                              'Register',
                                              style: GoogleFonts.lato(
                                                  color: Colors.white,
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .height *
                                                          0.02),
                                            ),
                                          )),
                                    ),
                                    Spacer(),*/
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              elevation: 5.0,
                                              shape: StadiumBorder(),
                                              primary: Colors.black),
                                          onPressed: () {
                                            ///todo :on pressed snapshot.length
                                            if (UserQuerryLength != 0) {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        TabsScreen()),
                                              );
                                              print(
                                                  ' powerstar $UserQuerryLength');
                                            } else {}
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.048,
                                                12,
                                                MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.048,
                                                12),
                                            child: Text(
                                              'Login',
                                              style: GoogleFonts.lato(
                                                  color: Colors.white,
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .height *
                                                          0.02),
                                            ),
                                          )),
                                    ),
                                  ],
                                ),
                              ])
                            : Text('nothing')
              ],
            ),
          ),
        ));
  }

  void _clearall() {
    username_admin = "";
    username_user = "";
    password_admin = "";
    password_user = "";
  }
}

///todo:implement this in onpressed else in login page
class ErrorCred extends StatelessWidget {
  const ErrorCred({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        "The given Credentials are wrong",
        style: TextStyle(
          color: Colors.red,
          fontSize: 12,
        ),
      ),
    );
  }
}
