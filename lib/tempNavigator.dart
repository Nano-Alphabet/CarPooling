import 'package:flutter/material.dart';
import 'package:uniteonwheels/home/homePage.dart';
import 'package:uniteonwheels/signInModule/signInPage.dart';

class TempNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            FlatButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => HomePage()));
                },
                child: Text('Home Page')),
            FlatButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => MySignInPage())); // TODO add class
                },
                child: Text('Sign in page')),
            FlatButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => ); // TODO add class
                },
                child: Text('Sign In OTP')),
          ],
        ),
      ),
    );
  }
}
