import 'package:flutter/material.dart';

class Diabetica extends StatefulWidget {
  Diabetica({Key key}) : super(key: key);

  _DiabeticaState createState() => _DiabeticaState();
}

class _DiabeticaState extends State<Diabetica> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Column(
          children: <Widget>[
            Text("Diabetica", style: TextStyle(fontSize: 50, color: Colors.black),),
          
          ],
        ),
      ),
    );
  }
}