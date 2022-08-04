import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:sense_task/LoginPage.dart';
import 'package:sense_task/AssignTask_Admin.dart';
import 'package:sense_task/StaffPage_Admin.dart';
import 'package:sense_task/TaskPage_Admin.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'mangodb.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';

final tabsList = ['All Tasks', 'Assigned', 'Accepted', 'Rejected', 'Overdue'];

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

bool already_sign_in = false;
CheckloggedIn() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int? intValue = prefs.getInt('intValue');
  if (intValue == 1) {
    already_sign_in = true;
    print("true");
  } else {
    already_sign_in = false;
    print("false");
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MongoDbModel.connect();
  await Hive.initFlutter();
  Box<dynamic> Hive_box = await Hive.openBox('myBox');
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CheckloggedIn();
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
        home:  /*(already_sign_in)?TabsScreen():*/
            loginpage(Hive_box));
  }
}

class TabsScreen extends StatefulWidget {
  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int tabView = 1;

  @override
  Widget build(BuildContext context) {
    print('Just entered : $tabView');
    // return Scaffold(
    //     appBar: PreferredSize(
    //       preferredSize: Size.fromHeight(65.0),
    //       child: AppBar(
    //         elevation: 0.3,
    //         automaticallyImplyLeading: false,
    //         backgroundColor: Colors.white,
    //         bottom: PreferredSize(
    //           preferredSize: Size.fromHeight(65),
    //           child: Padding(
    //             padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
    //             child: CarouselSlider(
    //               options: CarouselOptions(
    //                 height: 50,
    //                 viewportFraction: 0.4,
    //                 enlargeCenterPage: true,
    //               ),
    //               items: tabsList
    //                   .map(
    //                     (item) => ElevatedButton(
    //                       style: ButtonStyle(
    //                           elevation: MaterialStateProperty.all(3),
    //                           backgroundColor:
    //                               MaterialStateProperty.all(Colors.black),
    //                           shape: MaterialStateProperty.all<
    //                                   RoundedRectangleBorder>(
    //                               RoundedRectangleBorder(
    //                             borderRadius: BorderRadius.circular(18.0),
    //                           ))),
    //                       onPressed: () {
    //                         tabView = tabsList.indexOf(item) + 1;
    //                         print(tabView);
    //                         setState(() {});
    //                       },
    //                       child: Container(
    //                         width: MediaQuery.of(context).size.width * 0.4,
    //                         child: Text('$item', textAlign: TextAlign.center),
    //                       ),
    //                     ),
    //                   )
    //                   .toList(),
    //             ),
    //           ),
    //         ),
    //       ),
    //     ),
    //     body: (taskpage_a(
    //       tabView: tabView,
    //     )));

    return DefaultTabController(
      length:2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.0),
          child: AppBar(
            automaticallyImplyLeading: false,
            centerTitle: false,
            backgroundColor: Colors.black,
            bottom: TabBar(
              indicatorColor: Colors.white,
              tabs: [
                Tab(text: 'All Tasks'),
                Tab(text: 'Completed Tasks'),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            taskpage_a(
            ),
            staffpage_a()
          ],
        ),
      ),
    );
  }
}
