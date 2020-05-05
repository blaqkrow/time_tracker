import 'package:flutter/material.dart';
import 'package:time_tracker/app/home_page.dart';
import 'package:time_tracker/services/auth.dart';
import 'sign_in/sign_in_page.dart';

class LandingPage extends StatefulWidget {
  LandingPage({@required this.auth});
  final AuthBase auth;
  @override
  _LandingPageState createState() => _LandingPageState();
}
/* 
  Main page on the app which switches between screens based on selections and authentication state (signed in or out)
 */
class _LandingPageState extends State<LandingPage> {

  User _user;

  @override
  void initState() { //called when widget is added into state tree (aka upon starting the app)
    super.initState();
    _checkCurrentUser();
    widget.auth.onAuthStateChanged.listen((user) {
      // ? -> if user is null
      print('user: ${user?.uid}');
    });
  }

  Future<void> _checkCurrentUser() async {
    User user = await widget.auth.currentUser();
    _updateUser(user);
  }

  void _updateUser(User user) {
    setState(() { // when setState is called -> build method fires again!
      _user = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(_user == null) {
      return SignInPage(
        auth: widget.auth,
        onSignIn: _updateUser,// onSignIn and updateUser have the SAME method signature
      );
    }
    return HomePage(
      auth: widget.auth,
      onSignOut: () => _updateUser(null),
    );
  }
}