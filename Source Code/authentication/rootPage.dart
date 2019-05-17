
import 'package:diabetica/pages/diabetica.dart';
import 'package:flutter/material.dart';
import 'auth.dart';
import 'auth_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:diabetica/pages/loginpage.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Root extends StatefulWidget {
  @override
  _RootState createState() => _RootState();
}

enum AuthStatus{
  signedIn,
  notSignedIn,
  pending,
}


class _RootState extends State<Root> {
  AuthStatus status = AuthStatus.pending;

  void didChangeDependencies(){
    super.didChangeDependencies();
    final BaseAuth auth = AuthProvider.of(context).auth;
    auth.userNow().then((FirebaseUser user){
      setState(() {
        status = user == null? AuthStatus.notSignedIn : AuthStatus.signedIn;
      });
    });
  }

  void _signedIn(){
    setState(() {
      status = AuthStatus.signedIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    switch(status){
      case AuthStatus.notSignedIn:
        return LogInScreen(onSignedIn: _signedIn,);

      case AuthStatus.signedIn:
        return Diabetica();
      case AuthStatus.pending:
        return LoadingScreen();
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