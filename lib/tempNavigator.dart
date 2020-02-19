import 'package:flutter/material.dart';
import 'package:uniteonwheels/home/homePage.dart';
<<<<<<< HEAD
import 'package:uniteonwheels/signInModule/signInOTPPage.dart';
=======
import 'package:uniteonwheels/signInModule/signInPage.dart';
>>>>>>> 61c7c2440ae6eb02de18e37adf9a514ed82d929e

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
                          builder: (BuildContext context) =>MySignInOTPPage() )); // TODO add class
                },
                child: Text('Sign In OTP')),
          ],
        ),
      ),
    );
  }
}
