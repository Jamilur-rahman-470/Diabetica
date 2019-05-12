import 'package:flutter/material.dart';
import 'authentication/auth.dart';
import 'authentication/auth_provider.dart';
import 'authentication/rootPage.dart';
import 'pages/loginpage.dart';
import 'pages/profileSetupPage.dart';
import 'pages/diabetica.dart';


void main() => runApp(MainApp());

class MainApp extends StatelessWidget {
  const MainApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AuthProvider(
      auth: Auth(),
      child: MaterialApp(
        title: "Diabetica",
        home: Root(),
        initialRoute: '/',
        routes: {
          '/profile': (context) => ProfileSetup(),
          '/login' : (context) => LogInScreen(),
          '/main' : (context) => Diabetica(),
        },
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Color(0xffE9E9E9),
          accentColor: Color(0xff396CFE),
          scaffoldBackgroundColor: Color(0xFFE9E9E9),
        ),
      ),
    );
  }
}
