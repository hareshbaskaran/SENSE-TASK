import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'LoginPage.dart';

class UserInfoScreen extends StatefulWidget {
  const UserInfoScreen({Key? key})
      : _user = user,
        super(key: key);



  @override
  _UserInfoScreenState createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  late User _user;
  bool _isSigningOut = false;


  @override
  void initState() {
    _user = widget._user;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    User? useruser =
    ModalRoute.of(context)!.settings.arguments as User?;
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BackButton(

            ),
            _user.photoURL != null
                ? ClipOval(
              child: Material(
                child: Image.network(
                  _user.photoURL!,
                  fit: BoxFit.fitHeight,
                ),
              ),
            )
                : ClipOval(
              child: Material(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Icon(
                    Icons.person,
                    size: 60,
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.0),
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
                letterSpacing: 0.5,
              ),
            ),
            SizedBox(height: 16.0),
            _isSigningOut
                ? CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            )
                : ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  Colors.deepPurpleAccent,
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
                });
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
                    letterSpacing: 2,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}