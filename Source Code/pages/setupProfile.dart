import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diabetica/customWidgets/profileWidget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SetupProfilePage extends StatefulWidget {
  SetupProfilePage({Key key}) : super(key: key);

  _SetupProfilePageState createState() => _SetupProfilePageState();
}

class _SetupProfilePageState extends State<SetupProfilePage> {

    TextEditingController _ageCon = TextEditingController();
  //TextEditingController _genderCon = TextEditingController();
  TextEditingController _heightCon = TextEditingController();
  TextEditingController _weightCon = TextEditingController();
  TextEditingController _a1cCon = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  double bmr = 0.0;
  String gender = "male";
  int _radioVal = 0;

  void valChange(int value) {
    setState(() {
      _radioVal = value;

      switch (_radioVal) {
        case 0:
          setState(() {
            gender = 'male';
          });
          break;

        case 1:
          setState(() {
            gender = "Female";
          });
          break;
      }
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Form(
              key: _formKey,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                        top: 35,
                      ),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                              child: new CustomTextField(
                            control: _ageCon,
                            hint: "Age",
                            errorTxt: "Please Enter Your Age",
                            padL: 0,
                            padR: 20,
                            input: TextInputType.number,
                          )),
                          Expanded(
                              child: new CustomTextField(
                            control: _a1cCon,
                            hint: "Blood Suger Level",
                            errorTxt: "Enter Blood Suger Level",
                            padL: 0,
                            padR: 0,
                            input: TextInputType.number,
                          )),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 15),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                              child: new CustomTextField(
                            control: _heightCon,
                            hint: "Height in cm",
                            errorTxt: "Add your Age",
                            padL: 0,
                            padR: 20,
                            input: TextInputType.number,
                          )),
                          Expanded(
                              child: new CustomTextField(
                            control: _weightCon,
                            hint: "Weight in Kg",
                            errorTxt: "Add your age",
                            padL: 0,
                            padR: 0,
                            input: TextInputType.number,
                          )),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(20),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Radio(
                          value: 0,
                          groupValue: _radioVal,
                          onChanged: valChange,
                        ),
                        Text('Male'),
                        Radio(
                          value: 1,
                          groupValue: _radioVal,
                          onChanged: valChange,
                        ),
                        Text('Female'),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 40, bottom: 40),
                      child: Container(
                        height: 50,
                        width: 250,
                        decoration: BoxDecoration(
                            color: Color(0xff396CFE),
                            borderRadius: BorderRadius.circular(8)),
                        child: FlatButton(
                          child: Text(
                            "Done",
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              if (gender.toLowerCase() == "male") {
                                setState(() {
                                  bmr = 66.4730 +
                                      (13.7516 *
                                          double.parse(
                                              _weightCon.text.toString())) +
                                      (5.0033 *
                                          double.parse(
                                              _heightCon.text.toString())) -
                                      (6.7550 *
                                          double.parse(
                                              _ageCon.text.toString()));
                                });
                              } else {
                                setState(() {
                                  bmr = 655.0955 +
                                      (9.5634 *
                                          double.parse(
                                              _weightCon.text.toString())) +
                                      (1.8496 *
                                          double.parse(
                                              _heightCon.text.toString())) -
                                      (4.6756 *
                                          double.parse(
                                              _ageCon.text.toString()));
                                });
                              }
                              Map<String, dynamic> data = <String, dynamic>{
                                "age": double.parse(_ageCon.text.toString()),
                                "height":
                                    double.parse(_heightCon.text.toString()),
                                "weight":
                                    double.parse(_weightCon.text.toString()),
                                "a1c": double.parse(_a1cCon.text.toString()),
                                "gender": gender,
                                "bmr": bmr
                              };
                              try {
                                FirebaseAuth.instance
                                    .currentUser()
                                    .then((FirebaseUser user) {
                                  String u = user.uid;
                                  Firestore.instance
                                      .document('users/$u')
                                      .setData(data);
                                });
                                Navigator.pop(context);
                              } catch (e) {
                                print(e);
                              }
                            }
                          },
                        ),
                      ),
                    ),
                  ]),
            ),
          )
    );
  }
}