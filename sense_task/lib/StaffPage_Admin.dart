//
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:rounded_expansion_tile/rounded_expansion_tile.dart';
// import 'package:sense_task/services/firebase_crud.dart';
// import 'adminmongo.dart';
// import 'assigntask_admin.dart';
// import 'loginpage.dart';
// import 'models/taskmango.dart';
// import 'taskpage_admin.dart';
// import 'models/usermango.dart';
// import 'main.dart';
// import 'mangodb.dart';
//
// /*text(e["category"]),
//                                 text(e["description"]),
//                                 text(e["startdate"]),
//                                 text(e["enddate"]),
//                                 text(e["duedate"]),
//                                 text(e["faculty"]),
//                                 text(e["status"]),
//                                 text(e["reason"]),*/
//
// /*class itemlist extends statelesswidget {
//   list<documentsnapshot> _task = [];
//   @override
//   widget build(buildcontext context) {
//     return streambuilder<querysnapshot>(
//       stream: firebasetask.readitems(),
//       builder: (context, snapshot) {
//         if (snapshot.haserror) {
//           print(snapshot.tostring());
//           return text('something went wrong');
//         } else if (snapshot.hasdata || snapshot.data != null) {
//           return listview.separated(
//             separatorbuilder: (context, index) => sizedbox(height: 16.0),
//             itemcount: snapshot.data!.docs.length,
//             itembuilder: (context, index) {
//               map<string, dynamic> data = _task[index].data()!
//               as map<string, dynamic>;
//               return ink(
//                 decoration: boxdecoration(
//                   borderradius: borderradius.circular(8.0),
//                 ),
//                 child: listtile(
//                   shape: roundedrectangleborder(
//                     borderradius: borderradius.circular(8.0),
//                   ),
//                   ontap: () => navigator.of(context).push(
//                     materialpageroute(
//                       builder: (context) => taskassign_a(
//                       ),
//                     ),
//                   ),
//                   title: text(
//                     data['title'],
//                     maxlines: 1,
//                     overflow: textoverflow.ellipsis,
//                   ),
//                   subtitle: text(
//                     data['category'],
//                     maxlines: 1,
//                     overflow: textoverflow.ellipsis,
//                   ),
//                 ),
//               );
//             },
//           );
//         }
//
//         return center(
//           child: circularprogressindicator(
//           ),
//         );
//       },
//     );
//   }
// }*/
// class second extends statefulwidget {
//   late bool grey;
//   @override
//   secondstate createstate() => secondstate();
// }
//
// class secondstate extends state<second> {
//   secondstate();
//
//   widget build(buildcontext context) {
//     return scaffold(
//         floatingactionbutton: _floating(context),
//       body: streambuilder(
//           stream: firebasefirestore.instance.collection('tasks').snapshots(),
//           builder:
//               (buildcontext context, asyncsnapshot<querysnapshot> snapshot) {
//             if (!snapshot.hasdata) {
//               print(firebasefirestore.instance.collection('tasks').snapshots().tostring());
//               return center(
//                 child: circularprogressindicator(),
//               );
//             }
//             return listview(
//               children: snapshot.data!.docs.map((document) {
//                 return align(
//                     child: stack(children: <widget>[
//                       card(
//                         elevation: 0,
//                         color: colors.white,
//                         child: roundedexpansiontile(
//                           trailing: column(
//                             mainaxisalignment: mainaxisalignment.end,
//                             crossaxisalignment: crossaxisalignment.end,
//                             children: [
//                               icon(
//                                 icons.arrow_drop_down_outlined,
//                                 color: colors.black,
//                               ),
//                             ],
//                           ),
//                           shape: roundedrectangleborder(borderradius: borderradius.circular(4)),
//                           title: column(
//                             mainaxisalignment: mainaxisalignment.start,
//                             crossaxisalignment: crossaxisalignment.start,
//                             children: [
//                               largetext(text: document['title']),
//                               sizedbox(height: mediaquery.of(context).size.height * 0.01),
//                               column(
//                                 mainaxisalignment: mainaxisalignment.start,
//                                 crossaxisalignment: crossaxisalignment.start,
//                                 children: [
//                                   row(
//                                     mainaxisalignment: mainaxisalignment.start,
//                                     crossaxisalignment: crossaxisalignment.center,
//                                     children: [
//                                       standardtext(text: 'date:  '),
//                                       align(
//                                         alignment: alignment.topleft,
//                                         child: text(
//                                           document['startdate'],
//                                           textalign: textalign.left,
//                                           style: googlefonts.poppins(
//                                               color: colors.amber,
//                                               fontweight: fontweight.bold,
//                                               fontsize:
//                                               mediaquery.of(context).size.width * 0.04),
//                                         ),
//                                       ),
//                                       sizedbox(width: mediaquery.of(context).size.width * 0.15),
//                                     ],
//                                   ),
//                                   sizedbox(height: mediaquery.of(context).size.width * 0.01),
//                                   (pageview == 1)
//                                       ? row(
//                                     mainaxisalignment: mainaxisalignment.start,
//                                     crossaxisalignment: crossaxisalignment.center,
//                                     children: [
//                                       standardtext(text: 'faculty     :  '),
//                                       align(
//                                         alignment: alignment.topleft,
//                                         child: text(
//                                           document['faculty'],
//                                           textalign: textalign.left,
//                                           style: googlefonts.poppins(
//                                               color: colors.black,
//                                               fontweight: fontweight.bold,
//                                               fontsize:
//                                               mediaquery.of(context).size.width *
//                                                   0.04),
//                                         ),
//                                       )
//                                       /*  standardtext(text: " ${task_data.facultydb}"),*/
//                                     ],
//                                   )
//                                       : align(
//                                     alignment: alignment.centerright,
//                                     child: text(
//                                       document['duedate'] + " " +  document['duetime'],
//                                       style: googlefonts.poppins(
//                                           color: colors.red,
//                                           fontsize:
//                                           mediaquery.of(context).size.width * 0.03),
//                                     ),
//                                   ),
//                                 ],
//                               )
//                             ],
//                           ),
//                           children: [
//                             column(
//                               mainaxisalignment: mainaxisalignment.start,
//                               crossaxisalignment: crossaxisalignment.start,
//                               children: [
//                                 row(
//                                   mainaxisalignment: mainaxisalignment.start,
//                                   crossaxisalignment: crossaxisalignment.start,
//                                   children: [
//                                     ///todo: category have to replaced in the heading or is it same update i  next commit
//                                     standardtext(text: 'category :  '),
//                                     align(
//                                       alignment: alignment.topleft,
//                                       child: text(
//                                         document['category'],
//                                         textalign: textalign.left,
//                                         style: googlefonts.poppins(
//                                             color: colors.black,
//                                             fontweight: fontweight.bold,
//                                             fontsize: mediaquery.of(context).size.width * 0.04),
//                                       ),
//                                     )
//                                     /*  standardtext(text: " ${task_data.facultydb}"),*/
//                                   ],
//                                 ),
//                                 sizedbox(height: mediaquery.of(context).size.height * 0.01),
//                                 standardtext(text: 'event description:'),
//                                 padding(
//                                   padding: const edgeinsets.all(20.0),
//                                   child: text(
//                                     document['description'],
//                                     textalign: textalign.left,
//                                     style: googlefonts.poppins(
//                                         color: colors.black,
//                                         fontweight: fontweight.bold,
//                                         fontsize: mediaquery.of(context).size.width * 0.04),
//                                   ),
//                                 ),
//                                 row(
//                                   children: [
//                                     standardtext(text: 'due :  '),
//                                     padding(
//                                       padding: const edgeinsets.all(8.0),
//                                       child: text(
//                                         document['duedate'],
//                                         textalign: textalign.left,
//                                         style: googlefonts.poppins(
//                                             color: colors.redaccent,
//                                             fontweight: fontweight.bold,
//                                             fontsize: mediaquery.of(context).size.width * 0.04),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 row(
//                                   children: [
//                                     standardtext(text: 'time left:  '),
//                                     // padding(
//                                     //     padding: const edgeinsets.all(8.0),
//                                     //     child: (int.parse(task_data.duedatedb.split("/")[0]) -
//                                     //         datetime.now().day !=
//                                     //         0)
//                                     //         ? text(
//                                     //       "${int.parse(task_data.duedatedb.split("/")[0]) - datetime.now().day} days , ${task_data.duetimedb.split(":")[0]} hours ${task_data.duetimedb.split(":")[1]} mins  ",
//                                     //       textalign: textalign.left,
//                                     //       style: googlefonts.poppins(
//                                     //           color: colors.redaccent,
//                                     //           fontweight: fontweight.bold,
//                                     //           fontsize:
//                                     //           mediaquery.of(context).size.width *
//                                     //               0.04),
//                                     //     )
//                                     //         : text(
//                                     //       " ${hrleft} hours ${minleft} mins  ",
//                                     //       textalign: textalign.left,
//                                     //       style: googlefonts.poppins(
//                                     //           color: colors.redaccent,
//                                     //           fontweight: fontweight.bold,
//                                     //           fontsize:
//                                     //           mediaquery.of(context).size.width *
//                                     //               0.04),
//                                     //     )
//                                     // ),
//                                   ],
//                                 ),
//                                 sizedbox(height: mediaquery.of(context).size.width * 0.008),
//                                 (pageview == 1)
//                                     ? column(
//                                   children: [
//                                     standardtext(text: document['reason']),
//                                   ],
//                                 )
//                                     : sizedbox(
//                                   height: 0,
//                                 ),
//                                 (pageview == 1)
//                                     ? center(
//                                   child: row(
//                                     mainaxisalignment: mainaxisalignment.center,
//                                     crossaxisalignment: crossaxisalignment.center,
//                                     children: [
//                                       padding(
//                                         padding: const edgeinsets.all(15.0),
//                                         child: elevatedbutton(
//                                             style: elevatedbutton.stylefrom(
//                                                 elevation: 5.0,
//                                                 shape: stadiumborder(),
//                                                 primary: colors.black),
//                                             onpressed: () {
//                                               setstate(() => isedit = 1);
//                                                 categoryvalue = document['category'];
//                                                 tasktitlecontroller.text = document['title'];
//                                                 taskdescriptioncontroller.text = document['description'];
//                                                 startdateinstring = document['startdate'];
//                                                 enddateinstring = document['enddate'];
//                                                 duedateinstring = document['duedate'];
//                                                 duetime = document['duetime'];
//                                                 facultyvalue = document['faculty'];
//                                                 checkinserttask = "update";
//                                               ;
//                                               navigator.push(
//                                                   context,
//                                                   materialpageroute(
//                                                       builder:
//                                                           (buildcontext context) {
//                                                         return taskassign_a();
//                                                       },
//                                                       settings: routesettings(
//                                                           arguments: task_data)))
//                                                   .then((value) {
//                                                 setstate(() {});
//                                               });
//                                             },
//                                             child: padding(
//                                               padding: edgeinsets.fromltrb(
//                                                   mediaquery.of(context).size.height *
//                                                       0.04,
//                                                   12,
//                                                   mediaquery.of(context).size.height *
//                                                       0.04,
//                                                   12),
//                                               child: text(
//                                                 'edit',
//                                                 style: googlefonts.lato(
//                                                     color: colors.white,
//                                                     fontsize: mediaquery.of(context)
//                                                         .size
//                                                         .height *
//                                                         0.02),
//                                               ),
//                                             )),
//                                       ),
//                                       padding(
//                                         padding: const edgeinsets.all(15.0),
//                                         child: elevatedbutton(
//                                             style: elevatedbutton.stylefrom(
//                                                 elevation: 5.0,
//                                                 shape: stadiumborder(),
//                                                 primary: colors.black),
//                                             onpressed: () async {
//                                               ///todo:delete function
//                                               firebasetask.deletetask(docid: document.id);
//                                              // await mongodbmodel.delete_task(task_data);
//                                               setstate(() {});
//                                             },
//                                             child: padding(
//                                               padding: edgeinsets.fromltrb(
//                                                   mediaquery.of(context).size.height *
//                                                       0.04,
//                                                   12,
//                                                   mediaquery.of(context).size.height *
//                                                       0.04,
//                                                   12),
//                                               child: text(
//                                                 'delete',
//                                                 style: googlefonts.lato(
//                                                     color: colors.white,
//                                                     fontsize: mediaquery.of(context)
//                                                         .size
//                                                         .height *
//                                                         0.02),
//                                               ),
//                                             )),
//                                       ),
//                                     ],
//                                   ),
//                                 )
//                                     : row(
//                                   children: [
//                                     padding(
//                                       padding: const edgeinsets.all(15.0),
//                                       child: elevatedbutton(
//                                           style: elevatedbutton.stylefrom(
//                                               elevation: 5.0,
//                                               shape: stadiumborder(),
//                                               primary: colors.black),
//                                           onpressed: () {
//                                             showdialog(
//                                                 context: context,
//                                                 builder: (_) => alertdialog(
//                                                     title: text(
//                                                         'do you wish to accept the task ?'),
//                                                     actions: [
//                                                       elevatedbutton(
//                                                           onpressed: () {
//                                                             navigator.push(
//                                                                 context,
//                                                                 materialpageroute(
//                                                                     builder: (context) =>
//                                                                         tabsscreen()));
//                                                           },
//                                                           child: text('no')),
//                                                       elevatedbutton(
//                                                           onpressed: () async {
//                                                             status = 1;
//                                                             await _updatetask(
//                                                                 document.id,
//                                                                 document['category'],
//                                                                 document['title'],
//                                                                 document['description'],
//                                                                 document['startdate'],
//                                                                 document['enddate'],
//                                                                 document['duedate'],
//                                                                 document['duetime'],
//                                                                 document['faculty'],
//                                                                 status,
//                                                                 taskreasoncontroller
//                                                                     .text
//                                                             );
//                                                             navigator.push(
//                                                                 context,
//                                                                 materialpageroute(
//                                                                     builder: (context) =>
//                                                                         tabsscreen()));
//                                                           },
//                                                           child: text("yes"))
//                                                     ]),
//                                                 barrierdismissible: false);
//                                           },
//
//                                           ///add accept onpressed
//                                           child: padding(
//                                             padding: edgeinsets.fromltrb(
//                                                 mediaquery.of(context).size.height * 0.04,
//                                                 12,
//                                                 mediaquery.of(context).size.height * 0.04,
//                                                 12),
//                                             child: text(
//                                               'accept',
//                                               style: googlefonts.lato(
//                                                   color: colors.white,
//                                                   fontsize:
//                                                   mediaquery.of(context).size.height *
//                                                       0.02),
//                                             ),
//                                           )),
//                                     ),
//                                     spacer(),
//                                     padding(
//                                       padding: const edgeinsets.all(8.0),
//                                       child: elevatedbutton(
//                                           style: elevatedbutton.stylefrom(
//                                               elevation: 5.0,
//                                               shape: stadiumborder(),
//                                               primary: colors.black),
//                                           onpressed: () {
//                                             showdialog(
//                                                 context: context,
//                                                 builder: (_) => alertdialog(
//                                                     title: text(
//                                                         'do you wish to decline the task ?'),
//                                                     actionsalignment:
//                                                     mainaxisalignment.center,
//                                                     actions: [
//                                                       column(
//                                                         children: [
//                                                           padding(
//                                                             padding:
//                                                             const edgeinsets.all(
//                                                                 8.0),
//                                                             child: container(
//                                                               height: 60,
//                                                               child: textfield(
//                                                                 onchanged: (_) {
//                                                                   if (_.length > 0)
//                                                                     widget.grey =
//                                                                     false;
//                                                                   else
//                                                                     widget.grey =
//                                                                     true;
//                                                                   setstate(() {});
//                                                                 },
//                                                                 decoration:
//                                                                 inputdecoration(
//                                                                     fillcolor:
//                                                                     colors
//                                                                         .black,
//                                                                     hinttext:
//                                                                     'type the reason to decline...',
//                                                                     hintstyle:
//                                                                     textstyle(
//                                                                       color: colors
//                                                                           .black,
//                                                                     )),
//                                                                 keyboardtype:
//                                                                 textinputtype
//                                                                     .text,
//                                                                 maxlines: 2,
//                                                                 cursorcolor:
//                                                                 colors.black,
//                                                                 controller:
//                                                                 taskreasoncontroller,
//                                                                 onsubmitted:
//                                                                     (helo) async {
//                                                                   status = -1;
//                                                                   await _updatetask(
//                                                                             document.id,
//                                                                       document['category'],
//                                                                       document['title'],
//                                                                       document['description'],
//                                                                       document['startdate'],
//                                                                       document['enddate'],
//                                                                       document['duedate'],
//                                                                       document['duetime'],
//                                                                       document['faculty'],
//                                                                             status,
//                                                                             taskreasoncontroller.text
//                                                                   );
//                                                                       },
//
//                                                                 ///enter title
//                                                               ),
//                                                             ),
//                                                           ),
//                                                           elevatedbutton(
//                                                               onpressed: () {
//                                                                 taskreasoncontroller
//                                                                     .clear();
//                                                                 navigator.pop(
//                                                                     context);
//                                                               },
//                                                               child: text('close')),
//                                                         ],
//                                                       ),
//                                                     ]),
//                                                 barrierdismissible: false);
//                                           },
//
//                                           ///add reject onpressed
//                                           child: padding(
//                                             padding: edgeinsets.fromltrb(
//                                                 mediaquery.of(context).size.height *
//                                                     0.048,
//                                                 12,
//                                                 mediaquery.of(context).size.height *
//                                                     0.048,
//                                                 12),
//                                             child: text(
//                                               'reject',
//                                               style: googlefonts.lato(
//                                                   color: colors.white,
//                                                   fontsize:
//                                                   mediaquery.of(context).size.height *
//                                                       0.02),
//                                             ),
//                                           )),
//                                     ),
//                                   ],
//                                 )
//                               ],
//                             )
//                           ],
//                         ),
//                       ),
//                       (document['status'] == 0)
//                           ? container(
//                         padding: const edgeinsets.only(right: 20),
//                         alignment: alignment.topright,
//                         child: row(
//                           mainaxisalignment: mainaxisalignment.end,
//                           crossaxisalignment: crossaxisalignment.end,
//                           children: [
//                             icon(
//                               icons.circle_rounded,
//                               color: colors.black,
//                               size: 18,
//                             ),
//                             text(
//                               'assigned',
//                               style: googlefonts.poppins(
//                                   color: colors.black,
//                                   fontsize: mediaquery.of(context).size.width * 0.03),
//                             ),
//                           ],
//                         ),
//                       )
//                           : (document['status'] == 1)
//                           ? container(
//                         padding: const edgeinsets.only(right: 20),
//                         alignment: alignment.topright,
//                         child: row(
//                           mainaxisalignment: mainaxisalignment.end,
//                           crossaxisalignment: crossaxisalignment.end,
//                           children: [
//                             icon(
//                               icons.circle_rounded,
//                               color: colors.green,
//                               size: 18,
//                             ),
//                             text(
//                               'completed',
//                               style: googlefonts.poppins(
//                                   color: colors.black,
//                                   fontsize: mediaquery.of(context).size.width * 0.03),
//                             ),
//                           ],
//                         ),
//                       )
//                           : (document['status'] == -1)
//                           ? container(
//                         padding: const edgeinsets.only(right: 20),
//                         alignment: alignment.topright,
//                         child: row(
//                           mainaxisalignment: mainaxisalignment.end,
//                           crossaxisalignment: crossaxisalignment.end,
//                           children: [
//                             icon(
//                               icons.circle_rounded,
//                               color: colors.red,
//                               size: 18,
//                             ),
//                             text(
//                               'rejected',
//                               style: googlefonts.poppins(
//                                   color: colors.black,
//                                   fontsize:
//                                   mediaquery.of(context).size.width * 0.03),
//                             ),
//                           ],
//                         ),
//                       )
//                           : (document['status'] == 2)
//                           ? container(
//                         padding: const edgeinsets.only(right: 20),
//                         alignment: alignment.topright,
//                         child: row(
//                           mainaxisalignment: mainaxisalignment.end,
//                           crossaxisalignment: crossaxisalignment.end,
//                           children: [
//                             icon(
//                               icons.circle_rounded,
//                               color: colors.red,
//                               size: 18,
//                             ),
//                             text(
//                               'overdue',
//                               style: googlefonts.poppins(
//                                   color: colors.black,
//                                   fontsize:
//                                   mediaquery.of(context).size.width *
//                                       0.03),
//                             ),
//                           ],
//                         ),
//                       )
//                           : sizedbox()
//                     ]));
//               }).tolist(),
//
//             );
//           }),
//     );
//   }
//   future<void> _updatetask(
//       var id,
//       string category_update,
//       string title_update,
//       string description_update,
//       string startdate_update,
//       string enddate_update,
//       string duedate_update,
//       string duetime_update,
//       string faculty_update,
//       int status_update,
//       string reason_update) async {
//     await firebasetask.updatetask(
//         docid: id,
//         categorydb: category_update,
//         titledb: title_update,
//         descriptiondb: description_update,
//         startdatedb: startdate_update,
//         enddatedb: enddate_update,
//         duedatedb: duedate_update,
//         duetimedb: duetime_update,
//         facultydb: faculty_update,
//         statusdb: status_update,
//         reasondb: reason_update
//     ).whencomplete(
//           () => navigator.pop(context),
//     );
//   }
// }
// widget _floating(buildcontext context) {
//   if (pageview == 1) {
//     return floatingactionbutton(
//       backgroundcolor: colors.black,
//       onpressed: () {
//         navigator.push(
//             context, materialpageroute(builder: (context) => taskassign_a()));
//       },
//       child: const icon(icons.add),
//     );
//   } else {
//     return container();
//   }
// }
// /*
// document['title']
// document['category']
// document['description']
// document['startdate']
// document['endate']
// document['duedate']
// document['duetime']
// document['faculty']
// */