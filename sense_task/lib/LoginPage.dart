import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;
import 'package:sense_task/Services/firebase_crud.dart';
import 'package:sense_task/StaffPage_Admin.dart';
import 'package:sense_task/TaskPage_Admin.dart';
import 'package:sense_task/adminview/admin_facultypage.dart';
import 'package:sense_task/adminview/adminpage.dart';
import 'package:sense_task/main.dart';
import 'package:sense_task/userview/userpage.dart';
import 'Filterpage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'main.dart';
import 'package:http/http.dart' as http;



List<String> faculty_list = [];
List<dynamic> faculty_data=[];
String facultyvalue = "Ishwarya";

getfacultylistAPI() async {
  faculty_list = [];
  var faculty_url = Uri.parse(
      "https://gist.githubusercontent.com/iamishu2908/006812760864f6859dcaaf5e719f29b0/raw/acd0f3ad6c4495e061bb30ee29545a1dff4de3f8/facultynames.json");
  var faculty_response = await http.get(faculty_url);
  print('Response status: ${faculty_response.statusCode}');
  print('Response body: ${faculty_response.body}');
  final faculty_data = await json.decode(faculty_response.body);
  if (faculty_response.statusCode == 200) {
    for (int i = 0; i < faculty_data.length; i++) {
      faculty_list.add(
        faculty_data[i]['name'],
      );
    }
  }
}


///B2A4F0
Box<dynamic> Hive_box = Hive.box('myBox');
bool isButtonDisabled = true;
User? user;
bool checkbox_value = false;
Prefsetsignin() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setInt('intValue', 1);
}
bool userlogin=false;
bool alertuser=false;
bool adminlogin=false;
bool alertlogin=false;
TextEditingController usernamevalue_admin = new TextEditingController();
TextEditingController passwordvalue_admin = new TextEditingController();
String username_admin = usernamevalue_admin.text;
String password_admin = passwordvalue_admin.text;
TextEditingController usernamevalue_user = new TextEditingController();
TextEditingController passwordvalue_user = new TextEditingController();
String username_user = usernamevalue_user.text;
String password_user = passwordvalue_user.text;
bool grey = true;
int pageview = 2;
final GoogleSignIn googleSignIn = GoogleSignIn();
bool isLoggedIn = false;


Future<User?> signInWithGoogle({required BuildContext context}) async {
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

  if (googleSignInAccount != null) {
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    try {
      final UserCredential userCredential =
          await auth.signInWithCredential(credential);

      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential') {
// handle the error here
      } else if (e.code == 'invalid-credential') {
// handle the error here
      }
    } catch (e) {
// handle the error here
    }
  }

  return user;
}

void signOutGoogle() async {
  await googleSignIn.signOut();

  print("User Signed Out");
}

class loginpage extends StatefulWidget {
  late final Box<dynamic> box;
  loginpage(this.box);
  @override
  State<loginpage> createState() => _loginpageState();
}

class _loginpageState extends State<loginpage> {
  void initState() {
    getfacultylistAPI();
    super.initState();
  }
  void onLoginStatusChanged(bool isLoggedIn) {
    setState(() {
      isLoggedIn = isLoggedIn;
    });
  }
  bool searchusername(){
    for (int i = 0 ;i<=faculty_list.length;i++)
      {
        if (faculty_list[i] == usernamevalue_user.text)
          return true;
      }
    return false;
  }

  var loggedIn = false;
  var firebaseAuth = FirebaseAuth.instance;
  bool grey = true;
  @override
  Widget build(BuildContext context) {
    Hive_box = widget.box;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.2),
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
                (pageview == 1)
                    ? Column(children: [
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left:MediaQuery.of(context).size.width * 0.08),
                        child: Text('Login as Admin',style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontWeight: FontWeight.w300,
                            fontSize: MediaQuery.of(context).size.width * 0.045)),
                      ),
                    ],
                  ),
                  (adminlogin==false)?
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Center(
                              child: SingleChildScrollView(
                                child: Container(
                                  width: MediaQuery.of(context).size.width * 0.7,
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
                                          color: Colors.transparent,
                                          constraints: BoxConstraints(
                                              minHeight: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                                  0.05),
                                          child: TextField(
                                            maxLines: 1,
                                            onChanged: (_) {
                                              setState(() {
                                              });
                                            },
                                            decoration: InputDecoration(
                                              hintText: "   Enter Admin Password",
                                              hintStyle: TextStyle(

                                              ),
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
                            ),
                          ),
                          Container(
                            child: MaterialButton(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 18.0),
                                child: Icon(
                                  Icons.chevron_right_outlined,
                                  color: Colors.black,
                                ),
                              ),
                              onPressed: (){
                                if(passwordvalue_admin.text=="Sense_Task"){
                                  setState(() {
                                    adminlogin=true;
                                  });
                                }
                                else setState(() {
                                  alertlogin=true;
                                });
                              },
                            ),
                              width: MediaQuery.of(context).size.width * 0.1,
                          )
                        ],
                        ),
                      ):_googleSignInButton(),
                  (alertlogin==true&&adminlogin==false)?
                      Text(
                        'Invalid Password',
                        style: TextStyle(
                          color: Colors.red
                        ),
                      ):SizedBox(),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.1),
                        InkWell(
                          child: Text(
                            'Tap here, To Login as User',
                            style: GoogleFonts.lato(
                                decoration: TextDecoration.underline,
                                color: Colors.deepPurpleAccent,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.04),
                          ),
                          onTap: () {
                            setState(() {
                              alertlogin=false;
                              adminlogin=false;
                              passwordvalue_admin.clear();
                              pageview = 2;
                            });
                          },
                        ),
                      ])
                    : (pageview == 2)
                        ? Column(children: [
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left:MediaQuery.of(context).size.width * 0.08,bottom: 20),
                        child: Text('Login as User',style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontWeight: FontWeight.w300,
                            fontSize: MediaQuery.of(context).size.width * 0.045)),
                      ),
                    ],
                  ),
                  (userlogin==false)?
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Center(
                            child: SingleChildScrollView(
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.7,
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
                                        color: Colors.transparent,
                                        constraints: BoxConstraints(
                                            minHeight: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.05),
                                        child: TextField(
                                          maxLines: 1,
                                          onChanged: (_) {
                                            setState(() {
                                            });
                                          },
                                          decoration: InputDecoration(
                                            hintText: "   Enter Username",
                                            hintStyle: TextStyle(

                                            ),
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
                          ),
                        ),
                        Container(
                          child: MaterialButton(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 18.0),
                              child: Icon(
                                Icons.chevron_right_outlined,
                                color: Colors.black,
                              ),
                            ),
                            onPressed: (){
                              setState(() {
                                if(searchusername()){
                                  userlogin=true;
                                }
                                else {
                                  alertuser=true;
                                }
                              });
                            },
                          ),
                          width: MediaQuery.of(context).size.width * 0.1,
                        )
                      ],
                    ),
                  ):_googleSignInButton(),
                  SizedBox(height: 20),
                  (alertuser==true)?
                  Text(
                    'No Such User Exists',
                    style: TextStyle(
                        color: Colors.red
                    ),
                  ):SizedBox(),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.1),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: InkWell(
                                child: Text(
                                  'Tap here, to Login as admin',
                                  style: GoogleFonts.lato(
                                      decoration: TextDecoration.underline,
                                      color: Colors.deepPurpleAccent,
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.04),
                                ),
                                onTap: () {
                                  setState(() {
                                    usernamevalue_user.clear();
                                    userlogin=false;
                                    alertuser=false;
                                    pageview = 1;
                                  });
                                },
                              ),
                            ),
                          ])
                        : Text('nothing')
              ],
            ),
          ),
        ));
  }

  Widget _googleSignInButton() {
    return Container(
      height: 60,
      width: 340,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: MaterialButton(
        color: Colors.black,
        onPressed: () async {
          setState(() {
            already_sign_in = true;
          });
          User? user = await signInWithGoogle(context: context);
          if (user != null) {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => (pageview == 2)
                      ? userpage()
                      : (pageview == 1)
                          ? adminpage()
                          : userpage()
                  ),
            );
          }
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        highlightElevation: 0,
        height: 60,
        minWidth: 320,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                color: Colors.transparent,
                alignment: Alignment.centerLeft,
                height: 20,
                width: 20,
                /* child: Image(
                  image: AssetImage('assets/images/googleicon.png'),
                ),*/
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                'Sign in with Google',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

///todo:implement this in onpressed else in login page
class ErrorCred extends StatelessWidget {
  const ErrorCred({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
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

SnackBar customSnackBar({required String content}) {
  return SnackBar(
    backgroundColor: Colors.black,
    content: Text(
      content,
      style: TextStyle(color: Colors.redAccent, letterSpacing: 0.5),
    ),
  );
}

Future<void> signOut({required BuildContext context}) async {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  try {
    await FirebaseAuth.instance.signOut();
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      customSnackBar(
        content: 'Error signing out. Try again.',
      ),
    );
  }
}
