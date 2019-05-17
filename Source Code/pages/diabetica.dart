import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diabetica/customWidgets/DiabeticaWidget.dart';
import 'package:diabetica/customWidgets/loadingScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/widgets.dart';

class Diabetica extends StatefulWidget {
  Diabetica({Key key}) : super(key: key);

  _DiabeticaState createState() => _DiabeticaState();
}

class _DiabeticaState extends State<Diabetica> {
  String photoUri = "";
  String name = "";
  String uk = "";

  double age = 0;
  double weight = 0;
  double height = 0;
  double a1c = 0;
  double bmr = 0;

  Stream<DocumentSnapshot> getStraem(double val) {
    if (val * 1.375 <= 1000) {
      return Firestore.instance.document('food/1000').snapshots();
    } else if (val * 1.375 > 1000 && val * 1.375 <= 1600) {
      return Firestore.instance.document('food/1600').snapshots();
    } else if (val * 1.375 > 1600 && val * 1.375 <= 2200) {
      return Firestore.instance.document('food/2200').snapshots();
    }
    return Firestore.instance.document('food/2800').snapshots();
  }

  String getTime() {
    DateTime time = DateTime.now();
    int hour = int.parse(time.toString().substring(11, 13));
    if (hour >= 6 && hour <= 8) {
      return 'm';
    } else if (hour > 8 && hour <= 12) {
      return 'ms';
    } else if (hour > 12 && hour <= 15) {
      return 'l';
    } else if (hour > 15 && hour <= 17) {
      return 'as';
    } else if (hour > 17 && hour <= 23) {
      return 'd';
    }
    return 's';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(
            "Diabetica",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.w400, fontSize: 22),
          ),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.monetization_on),
              onPressed: () {},
            ),
          ],
        ),
        body: ListView(
          scrollDirection: Axis.vertical,
          children: <Widget>[
            //Todo: Top Widget Start
            Container(
              color: Colors.white,
              child: StreamBuilder(
                stream: FirebaseAuth.instance.onAuthStateChanged,
                initialData: "",
                builder: (BuildContext context, user) {
                  bool _visible = false;

                  if (user.hasData) {
                    if (user.connectionState == ConnectionState.active) {
                      name = user.data.displayName;
                      photoUri = user.data.photoUrl;
                      uk = user.data.uid;
                      _visible = true;
                      return Visibility(
                        visible: _visible,
                        maintainState: false,
                        maintainSize: false,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 18.0, bottom: 18, left: 30, right: 30),
                              child: Container(
                                  width: 85,
                                  height: 85,
                                  decoration: BoxDecoration(
                                      color: Colors.black45,
                                      borderRadius: BorderRadius.circular(45),
                                      image: DecorationImage(
                                          image: NetworkImage(photoUri)))),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: 30.0,
                                    bottom: 10,
                                  ),
                                  child: Text("Hi,",
                                      style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 24,
                                          fontWeight: FontWeight.w400)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 5),
                                  child: Text(name,
                                      style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 30,
                                          fontWeight: FontWeight.w400)),
                                )
                              ],
                            )
                          ],
                        ),
                      );
                    }
                    return LoadingScreen();
                  }
                  return LoginAlter();
                },
              ),
            ), //Todo: TopWidget End
            //todo: 2nd Widget Star
            StreamBuilder(
              stream: FirebaseAuth.instance.onAuthStateChanged,
              builder: (BuildContext context, user) {
                if (user.hasData) {
                  String u = user.data.uid;
                  return StreamBuilder(
                    stream: Firestore.instance.document('users/$u').snapshots(),
                    builder: (BuildContext context, shot) {
                      if (shot.hasData &&
                          shot.connectionState == ConnectionState.active) {
                        if (shot.connectionState != ConnectionState.none) {
                          age = shot.data['age'];
                          weight = shot.data['weight'];
                          height = shot.data['height'];
                          a1c = shot.data['a1c'];
                          bmr = shot.data['bmr'];
                          return StreamBuilder(
                            stream: getStraem(bmr),
                            builder: (BuildContext context, food) {
                              if (food.hasData &&
                                  food.connectionState ==
                                      ConnectionState.active) {
                                //Morning
                                String item1 = food.data['item1'];
                                String item2 = food.data['item2'];
                                String item3 = food.data['item3'];
                                //Morning snack
                                String item5 = food.data['item5'];
                                String item6 = food.data['item6'];
                                //lunch
                                String item7 = food.data['item7'];
                                String item8 = food.data['item8'];
                                String item9 = food.data['item9'];
                                String item10 = food.data['item10'];
                                String item11 = food.data['item11'];
                                String item12 = food.data['item12'];
                                String item13 = food.data['item13'];
                                String item14 = food.data['item14'];
                                String item15 = food.data['item15'];
                                String item4 = food.data['item4'];
                                

                                return Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      new InfoCard(
                                          age: age,
                                          a1c: a1c,
                                          height: height,
                                          weight: weight,
                                          bmr: bmr.roundToDouble(),),
                                      //Morning
                                      Visibility(
                                        visible:
                                            getTime() == 'm' ? true : false,
                                        maintainSize: false,
                                        maintainState: false,
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          elevation: 2,
                                          color: Color(0xff395CFE),
                                          child: Center(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 50,
                                                      bottom: 5,
                                                      left: 10),
                                                  child: Text(
                                                    "Your Diet".toUpperCase(),
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 24,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 20,
                                                      bottom: 5,
                                                      left: 10),
                                                  child: Text(
                                                    "morning 7am - 8am"
                                                        .toUpperCase(),
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 24,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 10,
                                                      bottom: 10,
                                                      left: 10),
                                                  child: Text(
                                                    item1,
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 10,
                                                      bottom: 10,
                                                      left: 10),
                                                  child: Text(
                                                    item2,
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 10,
                                                      bottom: 50,
                                                      left: 10),
                                                  child: Text(
                                                    item3,
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      //Morning End
                                      //Morning Snack
                                      Visibility(
                                        visible:
                                            getTime() == 'ms' ? true : false,
                                        maintainSize: false,
                                        maintainState: false,
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          elevation: 2,
                                          color: Color(0xff395CFE),
                                          child: Center(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 50,
                                                      bottom: 5,
                                                      left: 10),
                                                  child: Text(
                                                    "Your Diet".toUpperCase(),
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 24,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 20, bottom: 5),
                                                  child: Text(
                                                    "Morning snaks 11am - 11:30am"
                                                        .toUpperCase(),
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w300,
                                                        color: Colors.white,
                                                        fontSize: 24),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 10, bottom: 5),
                                                  child: Text(
                                                    item4,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w300,
                                                        color: Colors.white,
                                                        fontSize: 20),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 10, bottom: 50),
                                                  child: Text(
                                                    item5,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w300,
                                                        color: Colors.white,
                                                        fontSize: 20),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      //Morning Snack
                                      //Lunch
                                      Visibility(
                                        visible:
                                            getTime() == 'l' ? true : false,
                                        maintainSize: false,
                                        maintainState: false,
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          elevation: 2,
                                          color: Color(0xff395CFE),
                                          child: Center(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 50,
                                                      bottom: 5,
                                                      left: 10),
                                                  child: Text(
                                                    "Your Diet".toUpperCase(),
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 24,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 5, bottom: 5),
                                                  child: Text(
                                                    "Lunch 1pm - 2pm"
                                                        .toUpperCase(),
                                                    style: TextStyle(
                                                        fontSize: 24,
                                                        fontWeight:
                                                            FontWeight.w300,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 10, bottom: 5),
                                                  child: Text(
                                                    item6,
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w300,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 10, bottom: 5),
                                                  child: Text(
                                                    item7,
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w300,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 10, bottom: 5),
                                                  child: Text(
                                                    item8,
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w300,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 10, bottom: 50),
                                                  child: Text(
                                                    item9,
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w300,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      //Lunch end
                                      //AfterNoon
                                      Visibility(
                                        visible:
                                            getTime() == 'as' ? true : false,
                                        maintainSize: false,
                                        maintainState: false,
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          elevation: 2,
                                          color: Color(0xff395cfe),
                                          child: Center(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 50,
                                                      bottom: 5,
                                                      left: 10),
                                                  child: Text(
                                                    "Your Diet".toUpperCase(),
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 24,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 10, bottom: 5),
                                                  child: Text(
                                                    "Afternoon Snack 5pm - 6pm"
                                                        .toUpperCase(),
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w300,
                                                        fontSize: 24,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 10, bottom: 50),
                                                  child: Text(
                                                    item4,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w300,
                                                        fontSize: 20,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      //Afternoon end
                                      //Dinner
                                      Visibility(
                                        visible:
                                            getTime() == 'd' ? true : false,
                                        maintainSize: false,
                                        maintainState: false,
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          elevation: 2,
                                          color: Color(0xff395cfe),
                                          child: Center(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 50,
                                                      bottom: 5,
                                                      left: 10),
                                                  child: Text(
                                                    "Your Diet".toUpperCase(),
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 24,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 10, bottom: 5),
                                                  child: Text(
                                                    "Dinner 8pm - 9pm"
                                                        .toUpperCase(),
                                                    style: TextStyle(
                                                        fontSize: 24,
                                                        fontWeight:
                                                            FontWeight.w300,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 10, bottom: 5),
                                                  child: Text(
                                                    item10,
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w300,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 10, bottom: 5),
                                                  child: Text(
                                                    item11,
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w300,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 10, bottom: 5),
                                                  child: Text(
                                                    item12,
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w300,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 10, bottom: 5),
                                                  child: Text(
                                                    item13,
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w300,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 10, bottom: 5),
                                                  child: Text(
                                                    item14,
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w300,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 10, bottom: 50),
                                                  child: Text(
                                                    item15,
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w300,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      //Dinner End
                                      //Sleap
                                      Visibility(
                                        visible:
                                            getTime() == 's' ? true : false,
                                        maintainSize: false,
                                        maintainState: false,
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          elevation: 2,
                                          color: Color(0xff395cfe),
                                          child: Center(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 50,
                                                      bottom: 50,
                                                      left: 10),
                                                  child: Text(
                                                    "You Should Have Some Sleep".toUpperCase(),
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 24,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      //Sleap End
                                    ],
                                  ),
                                );
                              }
                              return LoadingScreen();
                            },
                          );
                        }
                        return Profile();
                      }
                      return LoadingScreen();
                    },
                  );
                }
                return LoginAlter();
              },
            ),
            //Todo: 2nd Widget End
            //Todo: 3rd Widget Start

            //todo: 3rd Widget End
          ],
        ));
  }
}
