import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class BaseAuth{
  Future<FirebaseUser> googleSignIn();
  Future<FirebaseUser> userNow();
}
final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = GoogleSignIn();


class Auth implements  BaseAuth{
  @override
  Future<FirebaseUser> googleSignIn() async{
    
    GoogleSignInAccount gUser = await _googleSignIn.signIn();
    GoogleSignInAuthentication gAuth = await gUser.authentication;

    AuthCredential cred = GoogleAuthProvider.getCredential(idToken: gAuth.idToken, accessToken: gAuth.accessToken);
    FirebaseUser user = await _auth.signInWithCredential(cred);

    return user;
  }

  @override
  Future<FirebaseUser> userNow() async{
    
    final FirebaseUser user = await _auth.currentUser();
    return user;
  }

}