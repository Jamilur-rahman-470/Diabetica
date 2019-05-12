import 'package:flutter/material.dart';

class TopCard extends StatelessWidget {
  const TopCard({
    Key key,
    @required this.photo,
    @required this.name,
  }) : super(key: key);

  final String photo;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Container(
        width: 300,
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 15, bottom: 20),
              child: Container(
                height: 105,
                width: 105,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.black54,
                  image: DecorationImage(
                    image: NetworkImage(photo),
                    fit: BoxFit.cover,
                    alignment: Alignment.center
                  )
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 30),
              child: Text('Hi, $name', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500, color: Colors.black54),),
            )
          ],
        ),
      ),
    );
  }
}



class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key key, this.hint, this.errorTxt, this.padR, this.padL,
    this.control, this.input
  }) :super(key: key);

  final TextEditingController control;
  final String hint;
  final String errorTxt;
  final double padR;
  final double padL;
  final TextInputType input;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: padR, left: padL),
      child: TextFormField(
        controller: control,
        keyboardType: input,
        decoration: InputDecoration(
          fillColor: Colors.transparent,
          filled: true,
          hintText: hint,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
        validator: (val) {
          if(val.isEmpty){return errorTxt;}
        },
        onSaved: null,
      ),
    );
  }
}
