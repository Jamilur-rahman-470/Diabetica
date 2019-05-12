import 'dart:async';
import 'dart:core' as prefix0;
import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';



abstract class BaseDB{
  Future<bool> dbExist(); 
}

class DB implements BaseDB{
  
  
  @override
  Future<bool> dbExist() async {
    // TODO: implement dbExist
    String userID ="";
    prefix0.bool data;
    
    FirebaseAuth.instance.currentUser().then((FirebaseUser user){
        userID = user.uid;
    });

    DocumentReference dbRef = Firestore.instance.document('users/$userID');
    dbRef.get().then((shot){
      shot.exists ? data = true : data = false;
    });
    return data;
  }

}