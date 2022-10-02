import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sense_task/LoginPage.dart';
import 'package:sense_task/Models/UserLoginModel.dart';
import 'package:sense_task/main.dart';

String googleuser = "haredfgf";
late User _user;
bool _isSigningOut = false;
class UserInfoScreen extends StatefulWidget {
  const UserInfoScreen({Key? key, required User user}): _user = user,
        super(key: key);
  final User _user;

  @override
  _UserInfoScreenState createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {

  @override
  void initState() {
    _user = widget._user;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Drawer(
        child: SafeArea(
          child: Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 8.0),
                Text(
                  _user.displayName!,
                  style: TextStyle(
                    fontSize: 26,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  '( ${_user.email!} )',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 24.0),
                SizedBox(height: 16.0),
                _isSigningOut
                    ? CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                      )
                    : ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            Colors.black,
                          ),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        onPressed: () async {
                          setState(() {
                            _isSigningOut = true;
                            googleuser = _user.displayName!;
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => loginpage(Hive_box)));
                          });

                          ///todo:sign-in method
                          await signOut(context: context);
                          setState(() {
                            _isSigningOut = false;
                          });
                        },
                        child: Padding(
                          padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                          child: Text(
                            'Sign Out',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
