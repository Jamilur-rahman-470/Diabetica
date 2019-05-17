import 'package:diabetica/authentication/auth.dart';
import 'package:diabetica/authentication/auth_provider.dart';
import 'package:diabetica/pages/setupProfile.dart';
import 'package:flutter/material.dart';


class LoginAlter extends StatelessWidget {
  const LoginAlter({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 50.0),
              child: Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("images/google.png"))),
              ),
            ),
            Padding(
                padding: EdgeInsets.only(left: 10, right: 70),
                child: FlatButton(
                  child: Text("Signup",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      )),
                  onPressed: () async {
                    try {
                      final BaseAuth auth = AuthProvider.of(context).auth;
                      await auth.googleSignIn();
                    } catch (e) {}
                  },
                ))
          ],
        )
      ],
    );
  }
}

class Profile extends StatelessWidget {
  const Profile({
    Key key, this.d
  }) : super(key: key);
  final String d;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      color: Colors.black,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("Phofile Not Setup Correctly \n Please Setup Your Profile \n $d", style: TextStyle(color: Colors.white, fontSize: 20),),
          Padding(
            padding: EdgeInsets.only(top: 15, bottom: 15),
            child: Container(
              height: 30,
              width: 170,
              color: Colors.white,
              child: FlatButton(
                child: Text("Setup Profile", style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w400),),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> SetupProfilePage()));
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}


class UserValue extends StatelessWidget {
  const UserValue({
    Key key, this.name, this.padB,
    @required this.value,
  }) : super(key: key);

  final double value;
  final String name;
  final double padB;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(top: 25, left: 10, right: 10, bottom: padB),
        child: Text("$name :  $value", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w400),),
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  const InfoCard({
    Key key,
    this.bmr,
    @required this.age,
    @required this.a1c,
    @required this.height,
    @required this.weight,
  }) : super(key: key);

  final double age;
  final double a1c;
  final double height;
  final double weight;
  final double bmr;


  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff396CFE),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            children: <Widget>[
              new UserValue(
                name: "Age",
                value: age,
                padB: 0,
              ),
              new UserValue(
                name: "Blood Suger",
                value: a1c,
                padB: 0,
              ),
            ],
          ),
          Row(
            children: <Widget>[
              new UserValue(
                name: "Height",
                value: height,
                padB: 0,
              ),
              new UserValue(
                name: "Weight",
                value: weight,
                padB: 0,
              ),
            ],
          ),
          Row(
            children: <Widget>[
              new UserValue(
                name: "bmr",
                value: bmr,
                padB: 30,
              ),
            ],
          ),
        ],
      ),
    );
  }
}