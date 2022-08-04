import 'package:flutter/material.dart';
import 'AdminMongo.dart';
import 'LoginPage.dart';
import 'UserMango.dart';
import 'mangodb.dart';
var UserQuerryLength;
var AdminQuerryLength;
class staffpage_a extends StatefulWidget {
  const staffpage_a({Key? key}) : super(key: key);

  @override
  State<staffpage_a> createState() => _staffpage_aState();
}

class _staffpage_aState extends State<staffpage_a> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: FutureBuilder(
              future:
              (pageview==1)?
              MongoDbModel.getAdmin():
              MongoDbModel.getQuerryTask(),
              builder: (context,AsyncSnapshot snapshot){
                if(snapshot.connectionState == ConnectionState.waiting){
                  print('connection waiting');
                  return Center(
                    child: CircularProgressIndicator(),
                  );}
                else {
                  if(snapshot.hasData){
                    (pageview==1)?
                    AdminQuerryLength=snapshot.data.length:
                    UserQuerryLength=snapshot.data.length;
                    print(AdminQuerryLength);///todo: this is where querry check happen if task length = 0
                    print('Task has Data');
                    return
                      (pageview==1)?
                      ListView.builder(
                        reverse: true,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: AdminQuerryLength,
                        itemBuilder: (BuildContext context, int index) {
                          return Center(child: UserCard (UserMongo.fromJson(snapshot.data[index])));
                        }):
                      ListView.builder(
                          reverse: true,
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: UserQuerryLength,
                          itemBuilder: (BuildContext context, int index) {
                            return Center(child: AdminCard (AdminMongo.fromJson(snapshot.data[index])));
                          });

                  }else{
                    return Center(
                      child: Text(
                          'NO data Available'
                      ),
                    );
                  }
                }
              }
          ),
        ),
    );
  }
}
Widget UserCard(UserMongo user_data){
  return Center(
    child: Card(
    child: Column(
      children: [
        Text("${user_data.username}"),
        Text("${user_data.password}")
      ],
    ),
    ),
  );
}
Widget AdminCard(AdminMongo admin_data){
  return Center(
    child: Card(
      child: Column(
        children: [
          Text("${admin_data.username}"),
          Text("${admin_data.password}")
        ],
      ),
    ),
  );
}