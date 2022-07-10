import 'package:flutter/material.dart';
import 'package:sense_task/assigntask_a.dart';
import 'package:sense_task/staffpage_a.dart';
import 'package:sense_task/taskpage_a.dart';
import 'package:hive_flutter/hive_flutter.dart';
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

void main() async{
  await Hive.initFlutter();
  // Hive.registerAdapter(CalorieDataAdapter());
  Box<dynamic> Hive_box = await Hive.openBox('myBox');
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const TabsScreen(),
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
        appBar:PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child:AppBar(
          automaticallyImplyLeading: false,
          centerTitle:false,
          backgroundColor: Colors.black,
          bottom: const TabBar(
            indicatorColor: Colors.white,
            tabs: [
              Tab( text: 'task'),
              Tab( text: 'staff')
            ],
          ),
        ),
        ),
        body: const TabBarView(
          children: [taskpage_a(),staffpage_a()],
        ),
      ),
    );
  }
}



