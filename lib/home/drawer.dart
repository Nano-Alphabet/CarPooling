import 'package:flutter/material.dart';
import 'package:uow/loginModule/signuppage.dart';
import 'package:uow/profile/profile.dart';
import 'package:uow/tempNavigator.dart';

class MyDrawer extends StatefulWidget {
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.

        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Container(
              child: Row(
                children: [],
              ),
            ),

            decoration: new BoxDecoration(
                color: Colors.indigo,
                gradient: LinearGradient(stops: [
                  0,
                  1
                ], colors: [
                  Color.fromRGBO(63, 0, 129, 1),
                  Color.fromRGBO(110, 97, 171, 1)
                ])),
          ),
          ListTile(
            title: Text('Home'),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('Profile'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => ProfilePage()));
            },
          ),
          ListTile(
            title: Text('Sign Up'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => SignUp()));
            },
          ),
          ListTile(
            title: Text('Temp Page'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => TempNavigator()));
            },
          ),
        ],
      ),
    );
  }
}
