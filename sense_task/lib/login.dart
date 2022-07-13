import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;
import 'package:sense_task/MongoDBModel.dart';
import 'package:sense_task/mangodb.dart';
TextEditingController usernamevalue = new TextEditingController();
TextEditingController passwordvalue = new TextEditingController();
String username = usernamevalue.text;
String password = passwordvalue.text;
bool grey = true;
class loginpage extends StatefulWidget {
  const loginpage({Key? key}) : super(key: key);

  @override
  State<loginpage> createState() => _loginpageState();
}

class _loginpageState extends State<loginpage> {
  bool grey = true;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body:SafeArea(
        child:Column(
          mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
           padding: EdgeInsets.fromLTRB(
               0, 0, 0, MediaQuery.of(context).size.width * 0.1),
            child:
            Text(
              'SENSE TASK MANAGEMENT',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: MediaQuery.of(context).size.width * 0.075
              ),
            ),
          ),
         SizedBox( height: MediaQuery.of(context).size.height * 0.025),
          Container(
              height: MediaQuery.of(context).size.height * 0.3,
              width: MediaQuery.of(context).size.width * 0.75,
              child:
          Image(image:AssetImage('assets/images/vit-logo.png') )),
          SizedBox( height: MediaQuery.of(context).size.height * 0.2),
          Container(
            padding: EdgeInsets.fromLTRB(
                0, 0, MediaQuery.of(context).size.width * 0.7, 0),
            child: Text(
              'username',
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
                      constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height * 0.05),
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
                        controller:usernamevalue,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox( height: MediaQuery.of(context).size.height * 0.025),
          Container(
            padding: EdgeInsets.fromLTRB(
                0, 0, MediaQuery.of(context).size.width * 0.7, 0),
            child: Text(
              'password',
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
                      constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height * 0.05),
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
                        controller:passwordvalue,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox( height: MediaQuery.of(context).size.height * 0.025),
          Center(
            child: ElevatedButton(
                onPressed: () {
                  _insertData(usernamevalue.text, passwordvalue.text);
                },
                child: Container(
                  height: MediaQuery.of(context).size.height*0.05,
                    width: MediaQuery.of(context).size.width * 0.6,
                    decoration: new BoxDecoration(
                      color: Colors.black,
                      shape: BoxShape.rectangle,
                      border: Border.all(width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    ),
                  child: Center(
                    child: Text(
                      "Login ",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
            ),
          ),
        ],
      ),
    ));
  }
}
Future<void> _insertData (String name,String pass) async{
  var _id = M.ObjectId();
  final data = MangoDbModel(id: _id, username: name, password: pass);
  var result = await MongoDatabase.insert(data);
  ///add a snack bar for ID insertion
  //_clearall();
}
/*
String nameController = username;
String passController = password;
void _clearall(){
 nameController = "";
 passController = "";
}
*/

