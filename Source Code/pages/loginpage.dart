import 'package:diabetica/authentication/auth.dart';
import 'package:diabetica/authentication/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:diabetica/customWidgets/LoginPageWidgets.dart';

class LogInScreen extends StatefulWidget {
  LogInScreen({Key key, this.onSignedIn}) : super(key: key);

  final VoidCallback onSignedIn;
  _LogInScreenState createState() => _LogInScreenState();
}
enum FormType{
  login,
  profile,
}

class _LogInScreenState extends State<LogInScreen> {
  FormType type = FormType.login;
  final formkey = GlobalKey<FormState>();

  Future<void> _signIn()async{
    try{
      final BaseAuth auth = AuthProvider.of(context).auth;
      await auth.googleSignIn();
      //widget.onSignedIn();
      //widget.onSignedIn();
      Navigator.pushReplacementNamed(context, '/profile');
    }catch(e){
      
    }
  }

  void movetoLogin(){
    setState(() {
     type = FormType.login; 
    });
  }

  void movetoProfile(){
    setState(() {
     type = FormType.profile;
    });
  }

  List<Widget> formWidget(){
    switch(type){
      case FormType.login:
        return [];
      case FormType.profile:
        return [];
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new LogInPageCard(),
            new BrandLogo(x: 125, y: 125,),
            Padding(
              padding: EdgeInsets.only(top: 60),
              child: Container(
                height: 55,
                width: 270,
                decoration: BoxDecoration(
                  color: Color(0xff396CFE),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 50.0),
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          image: DecorationImage(image: AssetImage("images/google.png"))
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10, right: 70),
                      child: FlatButton(
                        child: Text("Signup", style: TextStyle(color: Colors.white, fontSize: 24,)),
                        onPressed: _signIn,
                      )
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      )
    );
  }
}
