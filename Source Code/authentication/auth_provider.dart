import 'package:flutter/material.dart';
import 'auth.dart';

class AuthProvider extends InheritedWidget{
  @override
  const AuthProvider({Key key, Widget child, this.auth}):super(key: key, child: child);
  final BaseAuth auth;


  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static AuthProvider of(BuildContext context){
    return context.inheritFromWidgetOfExactType(AuthProvider);
  }

}

