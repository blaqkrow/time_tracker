import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:time_tracker/app/home_page.dart';
import 'sign_in/sign_in_page.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}
/* 
  Main page on the app which switches between screens based on selections and authentication state (signed in or out)
 */
class _LandingPageState extends State<LandingPage> {

  FirebaseUser _user;

  void _updateUser(FirebaseUser user) {
    setState(() { // when setState is called -> build method fires again!
      _user = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(_user == null) {
      return SignInPage(
        onSignIn: _updateUser,// onSignIn and updateUser have the SAME method signature
      );
    }
    return HomePage(
      onSignOut: () => _updateUser(null),
    );
  }
}