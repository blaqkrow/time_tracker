import 'package:flutter/material.dart';
import 'package:time_tracker/app/home_page.dart';
import 'package:time_tracker/services/auth.dart';
import 'sign_in/sign_in_page.dart';

class LandingPage extends StatelessWidget {
  LandingPage({@required this.auth});
  final AuthBase auth;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User>( //streams of type User
      stream: auth.onAuthStateChanged,
      // initialData: , <- initial data of stream
      builder: (context, snapshot) { 
        //called whenever there is a new value in the stream
        //snapshot -> object that holds data from stream
        if(snapshot.connectionState == ConnectionState.active){
          User user = snapshot.data; //because stream returns a User
          if(user == null) {
            return SignInPage(
              auth: auth,
            );
          }
          return HomePage(
            auth: auth,
          );
        } else { //when no data is in the stream
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}