import 'package:flutter/material.dart';


class LogInPageCard extends StatelessWidget {
  const LogInPageCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
       width: 290,
       height: 70,
       decoration: BoxDecoration(
         color: Colors.white,
         borderRadius: BorderRadius.circular(40)
       ),
       child: Row(
         mainAxisAlignment: MainAxisAlignment.center,
         children: <Widget>[
             Padding(
               padding: const EdgeInsets.only(right: 40, left: 18),
               child: Container(
                 height: 20,
                 width: 20,
                 decoration: BoxDecoration(
                   color: Color(0xff396CFE),
                   borderRadius: BorderRadius.circular(10),
                 ),
               ),
             ),
           
           Expanded(
             child: Text("DIABETICA", style: TextStyle(fontSize: 30, fontWeight: FontWeight.w400, color: Colors.black)),
           ),
           
           Padding(
               padding: const EdgeInsets.only(left: 40.0, right: 18.0),
               child: Container(
                 height: 20,
                 width: 20,
                 decoration: BoxDecoration(
                   color: Color(0xffFE396E),
                   borderRadius: BorderRadius.circular(10),
                 ),
               ),
             ),
         ],
       ),
    );
  }
}

class BrandLogo extends StatelessWidget {
  const BrandLogo({
    Key key, @required this.y, @required this.x
  }) : super(key: key);

  final double x;
  final double y;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 40),
      child: Container(
        height: y,
        width: x,
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('images/band-aid.png'))
        ),
      ),
    );
  }
}
