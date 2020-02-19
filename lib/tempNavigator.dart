import 'package:flutter/material.dart';
import 'package:uniteonwheels/home/homePage.dart';

import 'signInModule/signInOTPPage.dart';
import 'signInModule/signInPage.dart';

class TempNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
                          builder: (BuildContext context) =>
                              MySignInPage())); // TODO add class
                },
                child: Text('Sign in page')),
            FlatButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              MySignInOTPPage())); // TODO add class
                },
                child: Text('Sign In OTP')),
          ],
        ),
      ),
    );
  }
}
