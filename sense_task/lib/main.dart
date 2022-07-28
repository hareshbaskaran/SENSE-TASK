import 'package:flutter/material.dart';
import 'package:sense_task/LoginPage.dart';
import 'package:sense_task/AssignTask_Admin.dart';
import 'package:sense_task/StaffPage_Admin.dart';
import 'package:sense_task/TaskPage_Admin.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'mangodb.dart';
import 'package:realm/realm.dart' as realm;

class SizeConfig {
  static MediaQueryData _mediaQueryData = const MediaQueryData();
  static double screenWidth = 0;
  static double screenHeight = 0;
  static double blockSizeHorizontal = 0;
  static double blockSizeVertical = 0;
  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MongoDbModel.connect();
  await Hive.initFlutter();
  Box<dynamic> Hive_box = await Hive.openBox('myBox');
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        secondaryHeaderColor: Colors.black,
        splashColor: Colors.black,
      ),
      debugShowCheckedModeBanner: false,
      home: loginpage(),
      //home: const TabsScreen(),
    );
  }
}

class TabsScreen extends StatelessWidget {
  const TabsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.0),
          child: AppBar(
            automaticallyImplyLeading: false,
            centerTitle: false,
            backgroundColor: Colors.black,
            bottom: const TabBar(
              indicatorColor: Colors.white,
              tabs: [Tab(text: 'Tasks'), Tab(text: 'Staff')],
            ),
          ),
        ),
        body: TabBarView(
          children: [taskpage_a(), staffpage_a()],
        ),
      ),
    );
  }
}
