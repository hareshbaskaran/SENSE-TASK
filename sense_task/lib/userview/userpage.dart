

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rounded_expansion_tile/rounded_expansion_tile.dart';
import 'package:sense_task/Services/firebase_crud.dart';
import 'package:sense_task/UserInfo.dart';

import '../../LoginPage.dart';
import '../../adminview/adminpage.dart';
import '../AssignTask_Admin.dart';
import '../Models/TaskMango.dart';

int status = 0;
String tasktype = 'All Tasks';
User? fac;
Color bb = Color(0xFFADA4A5);
Color b = Color(0xFF817B7C);

class userpage extends StatefulWidget {
  const userpage({Key? key}) : super(key: key);

  @override
  State<userpage> createState() => _userpageState();
}

class _userpageState extends State<userpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Container(
      constraints: BoxConstraints.expand(),
      decoration: BoxDecoration(
        image: DecorationImage(
          alignment: Alignment.topCenter,
          image: AssetImage('assets/images/bgnd.png'),

          // color: Colors.amber,
        ),
      ),
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Padding(
              padding: EdgeInsets.only(top: 10),
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {
                        setState(() {});
                      },
                      icon: Icon(Icons.menu)),
                  Text(
                    'Hello, ',
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: MediaQuery.of(context).size.width * 0.06),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      '$username_user !',
                      style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: MediaQuery.of(context).size.width * 0.052),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 8, 0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '3 tasks waiting for you ...',
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: MediaQuery.of(context).size.width * 0.04),
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.7,
            child: Divider(
              color: Colors.transparent,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
            child: Row(
              children: [
                Text(
                  'Ongoing Tasks',
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: MediaQuery.of(context).size.width * 0.045),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.3,
              decoration: new BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                border: Border.all(width: 1.0),
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: StreamBuilder(
                    stream: UsernameQuery.UserOngoing(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: CircularProgressIndicator(
                            color: Colors.deepPurpleAccent,
                          ),
                        );
                      }
                      return ListView(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        children: snapshot.data!.docs.map((document) {
                          return Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 8),
                            child: Dismissible(
                              key: UniqueKey(),
                              background: Container(
                                decoration: new BoxDecoration(
                                  color: Theme.of(context).errorColor,
                                  shape: BoxShape.rectangle,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0)),
                                ),
                                child: Icon(
                                  Icons.close,
                                  color: Colors.white,
                                  size: 35,
                                ),
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.only(left: 20),
                                margin: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 8),
                              ),
                              secondaryBackground: Container(
                                decoration: new BoxDecoration(
                                  color: Colors.green,
                                  shape: BoxShape.rectangle,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0)),
                                ),
                                child: Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 35,
                                ),
                                alignment: Alignment.centerRight,
                                padding: EdgeInsets.only(right: 20),
                                margin: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 8),
                              ),
                              onDismissed: (direction) {
                                if (direction == DismissDirection.endToStart) {
                                  setState(() {
                                    showDialog(
                                      context: context,
                                      builder: (_) =>
                                          FunkyOverlayacceptdecline(accept: 1),
                                    );
                                  });
                                } else {
                                  setState(() {
                                    showDialog(
                                      context: context,
                                      builder: (_) => FunkyOverlayacceptdecline(
                                        accept: 0,
                                      ),
                                    );
                                  });
                                }
                              },
                              child: Align(
                                  child: Stack(children: <Widget>[
                                Container(
                                  decoration: new BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.rectangle,
                                    border: Border.all(width: 1.0),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15.0)),
                                  ),
                                  child: Card(
                                    elevation: 0,
                                    color: Colors.white,
                                    child: RoundedExpansionTile(
                                      rotateTrailing: false,
                                      trailing: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Icon(
                                            Icons.arrow_drop_down_outlined,
                                            color: Colors.black,
                                          ),
                                        ],
                                      ),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(4)),
                                      title: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${document['title']}",
                                            style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.05),
                                          ),
                                          SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.01),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  standardtext(text: 'Date:  '),
                                                  Align(
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: Text(
                                                      " ${document['startdate']}",
                                                      textAlign: TextAlign.left,
                                                      style: GoogleFonts.poppins(
                                                          color: Colors.amber,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.04),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.15)
                                                ],
                                              ),
                                              SizedBox(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.01),
                                              (pageview == 1)
                                                  ? Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        standardtext(
                                                            text:
                                                                'Faculty     :  '),
                                                        Align(
                                                          alignment:
                                                              Alignment.topLeft,
                                                          child: Text(
                                                            " ${document['faculty']}",
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: GoogleFonts.poppins(
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    0.04),
                                                          ),
                                                        )
                                                        /*  standardtext(text: " ${task_data.facultydb}"),*/
                                                      ],
                                                    )
                                                  : Align(
                                                      alignment:
                                                          Alignment.centerRight,
                                                      child: Text(
                                                        '${document['duedate']}  ,   ${document['duetime']}',
                                                        style: GoogleFonts.poppins(
                                                            color: Colors.red,
                                                            fontSize: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.03),
                                                      ),
                                                    ),
                                            ],
                                          )
                                        ],
                                      ),
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                ///todo: category have to replaced in the heading or is it same update i  next commit
                                                standardtext(
                                                    text: 'Category :  '),
                                                Align(
                                                  alignment: Alignment.topLeft,
                                                  child: Text(
                                                    " ${document['category']} ",
                                                    textAlign: TextAlign.left,
                                                    style: GoogleFonts.poppins(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.04),
                                                  ),
                                                )
                                                /*  standardtext(text: " ${task_data.facultydb}"),*/
                                              ],
                                            ),
                                            SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.01),
                                            standardtext(
                                                text: 'Event Description:'),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(20.0),
                                              child: Text(
                                                "${document['description']}",
                                                textAlign: TextAlign.left,
                                                style: GoogleFonts.poppins(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.04),
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                standardtext(text: 'Due :  '),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    " ${document['duedate']}",
                                                    textAlign: TextAlign.left,
                                                    style: GoogleFonts.poppins(
                                                        color: Colors.redAccent,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.04),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                // standardtext(
                                                //     text: 'Time left:  '),
                                                // Padding(
                                                //     padding:
                                                //         const EdgeInsets.all(
                                                //             8.0),
                                                //     child: (int.parse(document[
                                                //                             'duedate']
                                                //                         .split(
                                                //                             "/")[
                                                //                     0]) -
                                                //                 DateTime.now()
                                                //                     .day !=
                                                //             0)
                                                //         ? Text(
                                                //             "${int.parse(document['duedate'].split("/")[0]) - DateTime.now().day} days , ${document['duedate'].split(":")[0]} hours ${document['duedate'].split(":")[1]} mins  ",
                                                //             textAlign:
                                                //                 TextAlign.left,
                                                //             style: GoogleFonts.poppins(
                                                //                 color: Colors
                                                //                     .redAccent,
                                                //                 fontWeight:
                                                //                     FontWeight
                                                //                         .bold,
                                                //                 fontSize: MediaQuery.of(
                                                //                             context)
                                                //                         .size
                                                //                         .width *
                                                //                     0.04),
                                                //           )
                                                //         : Text(
                                                //             " ${hrleft} hours ${minleft} mins  ",
                                                //             textAlign:
                                                //                 TextAlign.left,
                                                //             style: GoogleFonts.poppins(
                                                //                 color: Colors
                                                //                     .redAccent,
                                                //                 fontWeight:
                                                //                     FontWeight
                                                //                         .bold,
                                                //                 fontSize: MediaQuery.of(
                                                //                             context)
                                                //                         .size
                                                //                         .width *
                                                //                     0.04),
                                                //           )),
                                              ],
                                            ),
                                            SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.008),
                                            (pageview == 1)
                                                ? Column(
                                                    children: [
                                                      standardtext(
                                                          text:
                                                              "${document['reason']}"),
                                                    ],
                                                  )
                                                : SizedBox(
                                                    height: 0,
                                                  ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                (document['status'] == 0)
                                    ? Container(
                                        padding: const EdgeInsets.only(
                                            right: 20, top: 20),
                                        alignment: Alignment.topRight,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Icon(
                                              Icons.circle_rounded,
                                              color: Colors.black,
                                              size: 14,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(left: 8),
                                              child: Text(
                                                'Assigned',
                                                style: GoogleFonts.poppins(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.035),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    : (document['status'] == 1)
                                        ? Container(
                                            padding: const EdgeInsets.only(
                                                right: 20, top: 20),
                                            alignment: Alignment.topRight,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Icon(
                                                  Icons.circle_rounded,
                                                  color: Colors.green,
                                                  size: 18,
                                                ),
                                                Text(
                                                  'Completed',
                                                  style: GoogleFonts.poppins(
                                                      color: Colors.black,
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.03),
                                                ),
                                              ],
                                            ),
                                          )
                                        : (document['status'] == -1)
                                            ? Container(
                                                padding: const EdgeInsets.only(
                                                    right: 20, top: 20),
                                                alignment: Alignment.topRight,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    Icon(
                                                      Icons.circle_rounded,
                                                      color: Colors.red,
                                                      size: 18,
                                                    ),
                                                    Text(
                                                      'Rejected',
                                                      style: GoogleFonts.poppins(
                                                          color: Colors.black,
                                                          fontSize: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.03),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            : (document['status'] == 2)
                                                ? Container(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 20, top: 20),
                                                    alignment:
                                                        Alignment.topRight,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      children: [
                                                        Icon(
                                                          Icons.circle_rounded,
                                                          color: Colors.red,
                                                          size: 18,
                                                        ),
                                                        Text(
                                                          'Overdue',
                                                          style: GoogleFonts.poppins(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.03),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                : SizedBox()
                              ])),
                            ),
                          );
                        }).toList(),
                      );
                    }),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
            child: Row(
              children: [
                Text(
                  '$tasktype',
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: MediaQuery.of(context).size.width * 0.045),
                ),
                Spacer(),
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                      onPressed: () {
                      },
                      icon: Icon(Icons.filter_alt_sharp)),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: StreamBuilder(
                stream:UsernameQuery.UserAccepted(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ListView(
                    shrinkWrap: true,
                    children: snapshot.data!.docs.map((document) {
                      return Padding(
                        padding: EdgeInsets.fromLTRB(6, 0, 6, 8),
                        child: Align(
                            child: Stack(children: <Widget>[
                          Container(
                            decoration: new BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.rectangle,
                              border: Border.all(width: 1.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.0)),
                            ),
                            child: Card(
                              elevation: 0,
                              color: Colors.white,
                              child: RoundedExpansionTile(
                                rotateTrailing: false,
                                trailing: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Icon(
                                      Icons.arrow_drop_down_outlined,
                                      color: Colors.black,
                                    ),
                                  ],
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4)),
                                title: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${document['title']}",
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.05),
                                    ),
                                    SizedBox(
                                        height: MediaQuery.of(context)
                                                .size
                                                .height *
                                            0.01),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            standardtext(text: 'Date:  '),
                                            Align(
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                " ${document['startdate']}",
                                                textAlign: TextAlign.left,
                                                style: GoogleFonts.poppins(
                                                    color: Colors.amber,
                                                    fontWeight:
                                                        FontWeight.bold,
                                                    fontSize:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.04),
                                              ),
                                            ),
                                            SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.15),
                                            /*  standardtext(text: 'Due :  '),
                        Align(
                          alignment: Alignment.topRight,
                          child: Text(
                            " ${task_data.duedatedb}",
                            textAlign: TextAlign.left,
                            style: GoogleFonts.poppins(
                                color: Colors.redAccent,
                                fontWeight: FontWeight.bold,
                                fontSize: MediaQuery.of(context).size.width * 0.04),
                          ),
                        )*/
                                          ],
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.01),
                                        (pageview == 1)
                                            ? Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  standardtext(
                                                      text:
                                                          'Faculty     :  '),
                                                  Align(
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: Text(
                                                      " ${document['faculty']}",
                                                      textAlign:
                                                          TextAlign.left,
                                                      style: GoogleFonts.poppins(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.04),
                                                    ),
                                                  )
                                                  /*  standardtext(text: " ${task_data.facultydb}"),*/
                                                ],
                                              )
                                            : Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: Text(
                                                  '${document['duedate']}  ,   ${document['duetime']}',
                                                  style: GoogleFonts.poppins(
                                                      color: Colors.red,
                                                      fontSize: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width *
                                                          0.03),
                                                ),
                                              ),
                                      ],
                                    )
                                  ],
                                ),
                                children: [
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ///todo: category have to replaced in the heading or is it same update i  next commit
                                          standardtext(text: 'Category :  '),
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              " ${document['category']} ",
                                              textAlign: TextAlign.left,
                                              style: GoogleFonts.poppins(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.04),
                                            ),
                                          )
                                          /*  standardtext(text: " ${task_data.facultydb}"),*/
                                        ],
                                      ),
                                      SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.01),
                                      standardtext(
                                          text: 'Event Description:'),
                                      Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: Text(
                                          "${document['description']}",
                                          textAlign: TextAlign.left,
                                          style: GoogleFonts.poppins(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.04),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          standardtext(text: 'Due :  '),
                                          Padding(
                                            padding:
                                                const EdgeInsets.all(8.0),
                                            child: Text(
                                              " ${document['duedate']}",
                                              textAlign: TextAlign.left,
                                              style: GoogleFonts.poppins(
                                                  color: Colors.redAccent,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.04),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          // standardtext(text: 'Time left:  '),
                                          // Padding(
                                          //     padding:
                                          //         const EdgeInsets.all(8.0),
                                          //     child: (int.parse(document[
                                          //                         'duedate']
                                          //                     .split("/")[0]) -
                                          //                 DateTime.now().day !=
                                          //             0)
                                          //         ? Text(
                                          //             "${int.parse(document['duedate'].split("/")[0]) - DateTime.now().day} days , ${document['duedate'].split(":")[0]} hours ${document['duedate'].split(":")[1]} mins  ",
                                          //             textAlign: TextAlign.left,
                                          //             style: GoogleFonts.poppins(
                                          //                 color:
                                          //                     Colors.redAccent,
                                          //                 fontWeight:
                                          //                     FontWeight.bold,
                                          //                 fontSize: MediaQuery.of(
                                          //                             context)
                                          //                         .size
                                          //                         .width *
                                          //                     0.04),
                                          //           )
                                          //         : Text(
                                          //             " ${hrleft} hours ${minleft} mins  ",
                                          //             textAlign: TextAlign.left,
                                          //             style: GoogleFonts.poppins(
                                          //                 color:
                                          //                     Colors.redAccent,
                                          //                 fontWeight:
                                          //                     FontWeight.bold,
                                          //                 fontSize: MediaQuery.of(
                                          //                             context)
                                          //                         .size
                                          //                         .width *
                                          //                     0.04),
                                          //           )),
                                        ],
                                      ),
                                      SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.008),
                                      (pageview == 1)
                                          ? Column(
                                              children: [
                                                standardtext(
                                                    text:
                                                        "${document['reason']}"),
                                              ],
                                            )
                                          : SizedBox(
                                              height: 0,
                                            ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          (document['status'] == 0)
                              ? Container(
                                  padding: const EdgeInsets.only(
                                      right: 20, top: 20),
                                  alignment: Alignment.topRight,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.end,
                                    children: [
                                      Icon(
                                        Icons.circle_rounded,
                                        color: Colors.black,
                                        size: 14,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 8),
                                        child: Text(
                                          'Assigned',
                                          style: GoogleFonts.poppins(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.035),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : (document['status'] == 1)
                                  ? Container(
                                      padding: const EdgeInsets.only(
                                          right: 20, top: 20),
                                      alignment: Alignment.topRight,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Icon(
                                            Icons.circle_rounded,
                                            color: Colors.green,
                                            size: 18,
                                          ),
                                          Text(
                                            'Completed',
                                            style: GoogleFonts.poppins(
                                                color: Colors.black,
                                                fontSize:
                                                    MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        0.03),
                                          ),
                                        ],
                                      ),
                                    )
                                  : (document['status'] == -1)
                                      ? Container(
                                          padding: const EdgeInsets.only(
                                              right: 20, top: 20),
                                          alignment: Alignment.topRight,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Icon(
                                                Icons.circle_rounded,
                                                color: Colors.red,
                                                size: 18,
                                              ),
                                              Text(
                                                'Rejected',
                                                style: GoogleFonts.poppins(
                                                    color: Colors.black,
                                                    fontSize:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.03),
                                              ),
                                            ],
                                          ),
                                        )
                                      : (document['status'] == 2)
                                          ? Container(
                                              padding: const EdgeInsets.only(
                                                  right: 20, top: 20),
                                              alignment: Alignment.topRight,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Icon(
                                                    Icons.circle_rounded,
                                                    color: Colors.red,
                                                    size: 18,
                                                  ),
                                                  Text(
                                                    'Overdue',
                                                    style: GoogleFonts.poppins(
                                                        color: Colors.black,
                                                        fontSize: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.03),
                                                  ),
                                                ],
                                              ),
                                            )
                                          : SizedBox()
                        ])),
                      );
                    }).toList(),
                  );
                }),
          ),
        ],
      ),
    )));
  }

  Future<void> _updateTask(
      var id,
      String category_update,
      String title_update,
      String description_update,
      String startdate_update,
      String enddate_update,
      String duedate_update,
      String duetime_update,
      String faculty_update,
      int status_update,
      String reason_update) async {
/*    if ((int.parse(task_data!.duedatedb.split("/")[0]) -
        DateTime.now().minute == -1)){
      setState(() {
        status == 2;
      });
    }*/
    await FirebaseTask.updateTask(
            categorydb: category_update,
            titledb: title_update,
            descriptiondb: description_update,
            startdatedb: startdate_update,
            enddatedb: enddate_update,
            duedatedb: duedate_update,
            duetimedb: duetime_update,
            facultydb: faculty_update,
            statusdb: status_update,
            docId: id,
            reasondb: reason_update)
        .whenComplete(
      () => Navigator.pop(context),
    );
  }
}

class largetext extends StatelessWidget {
  String text;

  largetext({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Text(
        text,
        textAlign: TextAlign.left,
        style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: b,
            fontSize: MediaQuery.of(context).size.width * 0.045),
      ),
    );
  }
}

class standardtext extends StatelessWidget {
  String text;

  standardtext({required this.text});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Text(
        text,
        textAlign: TextAlign.left,
        style: GoogleFonts.poppins(
            color: bb,
            fontWeight: FontWeight.w600,
            fontSize: MediaQuery.of(context).size.width * 0.04),
      ),
    );
  }
}

class smalltext extends StatelessWidget {
  String text;

  smalltext({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Text(
        textAlign: TextAlign.center,
        text,
        style: GoogleFonts.poppins(
            color: bb, fontSize: MediaQuery.of(context).size.width * 0.02),
      ),
    );
  }
}

class FunkyOverlayacceptdecline extends StatefulWidget {
  int accept = 1;
  FunkyOverlayacceptdecline({required this.accept});
  @override
  State<StatefulWidget> createState() => FunkyOverlayacceptdeclineState();
}

class FunkyOverlayacceptdeclineState extends State<FunkyOverlayacceptdecline>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.elasticInOut);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    QueryDocumentSnapshot? document =
    ModalRoute.of(context)!.settings.arguments as QueryDocumentSnapshot?;
    return Center(
      child: Material(
        color: Colors.transparent,
        child: ScaleTransition(
          scale: scaleAnimation,
          child: Container(
            decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0))),
            child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                    height: MediaQuery.of(context).size.height * 0.13,
                    width: MediaQuery.of(context).size.width * 0.85,
                    decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0))),
                    child: (widget.accept == 1)
                        ? Column(
                            children: [
                              Text("Do you wish to Accept the Task ?"),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            elevation: 5.0,
                                            shape: StadiumBorder(),
                                            primary: Colors.black),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.04,
                                              12,
                                              MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.04,
                                              12),
                                          child: Text(
                                            'No',
                                            style: GoogleFonts.lato(
                                                color: Colors.white,
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .height *
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
                                        onPressed: () async {
                                          setState(() {
                                            status = 1;
                                          });
                                          ///todo:accept to be work
                     /*                     await FirebaseTask.updateTask(
                                              categorydb: document!['category'],
                                              titledb: document['title'],
                                              descriptiondb: document['description'],
                                              startdatedb: document['startdate'],
                                              enddatedb: document['enddate'],
                                              duedatedb: document['duedate'],
                                              duetimedb: document['duetime'],
                                              facultydb: document['faculty'],
                                              statusdb: 1,
                                              reasondb: '',
                                              docId: document.id
                                          ).whenComplete(
                                                () => Navigator.pop(context),
                                          );*/
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.04,
                                              12,
                                              MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.04,
                                              12),
                                          child: Text(
                                            'Accept',
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
                            ],
                          )
                        : Column(
                            children: [
                              Text("Do you wish to Decline the Task ?"),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 60,
                                  child: TextField(
                                    decoration: InputDecoration(
                                        fillColor: Colors.black,
                                        hintText:
                                            'Type the reason to decline...',
                                        hintStyle: TextStyle(
                                          color: Colors.black,
                                        )),
                                    keyboardType: TextInputType.text,
                                    maxLines: 2,
                                    cursorColor: Colors.black,
                                    controller: taskreasoncontroller,
                                    onSubmitted: (helo) async {
                                      setState(() {
                                        status = -1;
                                      });
                                      Navigator.pop(context);
                                    },
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    taskreasoncontroller.clear();
                                    Navigator.pop(context);
                                  },
                                  child: Text('Close')),
                            ],
                          ))),
          ),
        ),
      ),
    );
  }
}
