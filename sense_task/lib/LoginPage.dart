import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;
import 'package:sense_task/Services/firebase_crud.dart';
import 'package:sense_task/TaskPage_Admin.dart';
import 'package:sense_task/UserInfo.dart';
import 'package:sense_task/main.dart';
import 'package:sense_task/mangodb.dart';
import 'Filterpage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'main.dart';

Box<dynamic> Hive_box = Hive.box('myBox');
bool isButtonDisabled = true;
late User user;
bool checkbox_value = false;
Prefsetsignin() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setInt('intValue', 1);
}
TextEditingController usernamevalue_admin = new TextEditingController();
TextEditingController passwordvalue_admin = new TextEditingController();
String username_admin = usernamevalue_admin.text;
String password_admin = passwordvalue_admin.text;
TextEditingController usernamevalue_user = new TextEditingController();
TextEditingController passwordvalue_user = new TextEditingController();
String username_user = usernamevalue_user.text;
String password_user = passwordvalue_user.text;
bool grey = true;
int pageview = 0;
// pageview = 0 displays the login page
// pageview = 1 displays the admin view
// pageview = 2 displays the user view

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();
// final fbLogin = FacebookLogin();
bool isLoggedIn = false;
var det = "";

 Future<User?> signInWithGoogle({required BuildContext context}) async {
FirebaseAuth auth = FirebaseAuth.instance;
User? user;
final GoogleSignIn googleSignIn = GoogleSignIn();

final GoogleSignInAccount? googleSignInAccount =
    await googleSignIn.signIn();

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
}
else if (e.code == 'invalid-credential') {
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
  void onLoginStatusChanged(bool isLoggedIn) {
    setState(() {
      isLoggedIn = isLoggedIn;
    });
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
                (pageview == 0)
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
                                    pageview = 1;
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
                                    pageview = 2;
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
                    : (pageview == 1)
                        ? Column(children: [
                            Row(
                              children: [
                                Container(
                                  color: Colors.transparent,
                                  padding: EdgeInsets.all(3),
                                  alignment: Alignment.centerLeft,
                                  child: TextButton(
                                      onPressed: () {
                                        setState(() {
                                          pageview = 0;
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
                              color: Colors.transparent,
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
                                    MediaQuery.of(context).size.height * 0.025),
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
                                        ///todo:firebase collection push is given in admin login - changed in user but have to check
                                        FirebaseCrud.addUserDetails(
                                            username: password_admin
                                        );
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  TabsScreen()),
                                        );
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
                          ])
                        : (pageview == 2)
                            ? Column(children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(3),
                                      alignment: Alignment.centerLeft,
                                      child: TextButton(
                                          onPressed: () {
                                            setState(() {
                                              pageview = 0;
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
                                  color: Colors.transparent,
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
                                            color: Colors.transparent,
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
                                _googleSignInButton()
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

      User? user =
      await signInWithGoogle(context: context);

      setState(() {
        already_sign_in = false;
      });

      if (user != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  TabsScreen()
                 // UserInfoScreen(user: user)
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