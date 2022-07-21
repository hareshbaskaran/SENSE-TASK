import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;
import 'package:sense_task/UserMango.dart';
import 'package:sense_task/main.dart';
import 'package:sense_task/mangodb.dart';

TextEditingController usernamevalue = new TextEditingController();
TextEditingController passwordvalue = new TextEditingController();
String username = usernamevalue.text;
String password = passwordvalue.text;
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
                                          controller: usernamevalue,
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
                            Container(
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
                                          controller: passwordvalue,
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
                                  padding: const EdgeInsets.all(15.0),
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          elevation: 5.0,
                                          shape: StadiumBorder(),
                                          primary: Colors.black),
                                      onPressed: () {},
                                      child: Padding(
                                        padding: EdgeInsets.fromLTRB(
                                            MediaQuery.of(context).size.height *
                                                0.04,
                                            12,
                                            MediaQuery.of(context).size.height *
                                                0.04,
                                            12),
                                        child: Text(
                                          'Register',
                                          style: GoogleFonts.lato(
                                              color: Colors.white,
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.02),
                                        ),
                                      )),
                                ),
                                Spacer(),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          elevation: 5.0,
                                          shape: StadiumBorder(),
                                          primary: Colors.black),
                                      onPressed: () {
                                        _loginpageState()._insertData(
                                            usernamevalue.text,
                                            passwordvalue.text);
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
                            ? Column(
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
                                  Text('USERPAGE')
                                ],
                              )
                            : Text('nothing')
              ],
            ),
          ),
        ));
  }

  //future class of providing id and catching data from  username and password and passing to mangodbmodel class
  Future<void> _insertData(String name, String pass) async {
    var _id = M.ObjectId();

    ///from MANGODBMODEL created a object id here we calling it as variable as each objectID carries user information
    final data = UserMongo(id: _id, username: name, password: pass);

    ///parameterised class changed class members to input changed strings and objectID
    var result = await UserMangoDB.insert(data);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
            'User name and password inserted succesfully for this id : $_id ')));
    _clearall();
  }

  void _clearall() {
    username = "";
    password = "";
  }

  ///todo: provide a ckear all function to login button so that once clicked all the given strings get cleared

}
