import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diabetica/customWidgets/loadingScreen.dart';
import 'package:diabetica/pages/loginpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:diabetica/customWidgets/profileWidget.dart';


class ProfileSetup extends StatefulWidget {
 ProfileSetup({Key key, this.setupDone}) : super(key: key);
  final VoidCallback setupDone;


   ProfileSetupState createState() =>  ProfileSetupState();
}

class  ProfileSetupState extends State <ProfileSetup> {

  //Form Controller
  TextEditingController _ageCon = TextEditingController();
  //TextEditingController _genderCon = TextEditingController();
  TextEditingController _heightCon = TextEditingController();
  TextEditingController _weightCon = TextEditingController();
  TextEditingController _a1cCon = TextEditingController();
  
  //Important Variable
  double _bmr;
  final _formKey = GlobalKey<FormState>();
  String gender = "";
  int _radioVal = 0;
  
  void valChange(int value){
    setState(() {
      _radioVal = value;
      
      switch(_radioVal){
        
        case 0:
          gender = "Male";
        break;
        
        case 1:
          gender = "Female";
        break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile SetUp'.toUpperCase(), style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.w300),),
        elevation: 0,
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: FirebaseAuth.instance.onAuthStateChanged,
        builder: (BuildContext context, user){
          if(user.hasData){
          String name;
          String photo;
          String u;
          double bmr = 0;
          if(user.connectionState == ConnectionState.active){
           
            name = user.data.displayName;
            photo = user.data.photoUrl;
            u = user.data.uid;

            return ListView(
              scrollDirection: Axis.vertical,
              children: <Widget>[
                new TopCard(photo: photo, name: name),
                Padding(
                  padding: const EdgeInsets.only(top: 25.0),
                  child: Container(
                    width: 340,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(top: 35,),
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(child: new CustomTextField(control: _ageCon, hint: "Age", errorTxt: "Please Enter Your Age", padL: 0, padR: 20, input: TextInputType.number,)),
                                      Expanded(child: new CustomTextField(control: _a1cCon, hint: "Blood Suger Level", errorTxt: "Enter Blood Suger Level", padL: 0, padR: 0, input: TextInputType.number,)),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 15),
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(child: new CustomTextField(control: _heightCon, hint: "Height in cm", errorTxt: "Add your Age", padL: 0,padR: 20, input: TextInputType.number,)),
                                      Expanded(child: new CustomTextField(control: _weightCon, hint: "Weight in Kg", errorTxt: "Add your age", padL: 0, padR: 0, input: TextInputType.number,)),
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
                                      borderRadius: BorderRadius.circular(8)
                                    ),
                                    child: FlatButton(
                                      child: Text("Done", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500, color: Colors.white),),
                                      onPressed: (){
                                        
                                        if(_formKey.currentState.validate()){
                                          if(gender.toLowerCase() == "male"){
                                              setState(() {
                                                bmr = 66.4730 + (13.7516*double.parse(_weightCon.text.toString()))+
                                                    (5.0033*double.parse(_heightCon.text.toString()))-(6.7550*double.parse(_ageCon.text.toString()));
                                              });
                                            }else{
                                              setState(() {
                                                bmr = 655.0955 +(9.5634*double.parse(_weightCon.text.toString()))+
                                                    (1.8496*double.parse(_heightCon.text.toString()))- (4.6756*double.parse(_ageCon.text.toString()));
                                              });
                                            }
                                          Map<String, dynamic> data = <String, dynamic>{
                                            "age" : double.parse(_ageCon.text.toString()),
                                            "height": double.parse(_heightCon.text.toString()),
                                            "weight": double.parse(_weightCon.text.toString()),
                                            "a1c": double.parse(_a1cCon.text.toString()),
                                            "gender" : gender,
                                            "bmr" : bmr
                                          };
                                          try{

                                              Firestore.instance.document('users/$u').setData(data);
                                              //Navigator.pushReplacementNamed(context, '/main');
                                              widget.setupDone();
                                          }catch(e){
                                            print(e);
                                          }
                                        }
                                      },
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            );
          }return LoadingScreen();
          }return LogInScreen();
        }
      ),
    );
  }
}

