import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diabetica/authentication/auth.dart';
import 'package:diabetica/authentication/auth_provider.dart';
import 'package:diabetica/pages/diabetica.dart';
import 'package:diabetica/pages/profileSetupPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class Dbroot extends StatefulWidget {
  Dbroot({Key key}) : super(key: key);

  _DbrootState createState() => _DbrootState();
}

enum dbStatus{
  setupDone, 
  setNotDone,
}


class _DbrootState extends State<Dbroot> {
  dbStatus status = dbStatus.setNotDone;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final BaseAuth auth = AuthProvider.of(context).auth;
    auth.userNow().then((FirebaseUser user){
      String userId = user.uid;
      Firestore.instance.document('users/$userId').get().then((shot)=>{
        if(shot.exists){
          setState((){
            status = dbStatus.setupDone;
          })
        }else{
          setState((){
            status = dbStatus.setNotDone;
          })
        }
      });
    });
  }

  void _setupDone(){
    setState(() {
     status = dbStatus.setupDone; 
    });
  }

  @override
  Widget build(BuildContext context) {
    switch(status){
      case dbStatus.setNotDone:
        return ProfileSetup(setupDone: _setupDone,);
      case dbStatus.setupDone :
        return Diabetica();
    }
  }
}

Widget LoadingScreen(){
  return Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.redAccent,
      elevation: 0,
    ),
    body: Container(
      color: Colors.redAccent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SpinKitFadingCube(
            size: 30,
            color: Colors.white,
          ),
        ],
      ),
    ),
  );
}