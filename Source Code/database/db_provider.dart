import 'package:flutter/material.dart';
import 'db.dart';


class DbProvider extends InheritedWidget{
  const DbProvider({Key key, Widget child, this.db }):super(key: key, child: child);
  final BaseDB db;

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static DbProvider of(BuildContext context){
    return context.inheritFromWidgetOfExactType(DbProvider);
  }

}