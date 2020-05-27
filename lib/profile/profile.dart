import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uow/models/currentUser.dart';
import 'package:uow/provider/carPoolingProvider.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CurrentUser user =
        Provider.of<CarPoolingProvider>(context, listen: false).user;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile Page",
          style: TextStyle(fontSize: 18.0),
        ),
      ),
      backgroundColor: Colors.blue[300],
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                radius: 80,
                child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(
                                "https://cdn.pixabay.com/photo/2016/08/08/09/17/avatar-1577909_960_720.png")))),
              ),
              Text(
                'MySelf',
                style: TextStyle(
                  fontFamily: 'SourceSansPro',
                  fontSize: 25,
                ),
              ),

              // Welcome text, currently not needed

              // Text(
              //   'Welcome',
              //   style: TextStyle(
              //     fontSize: 20,
              //     fontFamily: 'SourceSansPro',
              //     color: Colors.red[400],
              //     letterSpacing: 2.5,
              //   ),
              // ),
              SizedBox(
                height: 20.0,
                width: 200,
                child: Divider(
                  color: Colors.teal[100],
                ),
              ),
              Text("My motto here/some quote here"),
              Card(
                  color: Colors.white,
                  margin:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                  child: ListTile(
                    leading: Icon(
                      Icons.person,
                      color: Colors.teal[900],
                    ),
                    title: Text(
                      user.userName,
                      style: TextStyle(fontFamily: 'BalooBhai', fontSize: 20.0),
                    ),
                  )),
              Card(
                  color: Colors.white,
                  margin:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                  child: ListTile(
                    leading: Icon(
                      Icons.portrait,
                      color: Colors.teal[900],
                    ),
                    title: Text(
                      'Last Name',
                      style: TextStyle(fontFamily: 'BalooBhai', fontSize: 20.0),
                    ),
                  )),
              Card(
                  color: Colors.white,
                  margin:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                  child: ListTile(
                    leading: Icon(
                      Icons.email,
                      color: Colors.teal[900],
                    ),
                    title: Text(
                      'Email Id',
                      style: TextStyle(fontFamily: 'BalooBhai', fontSize: 20.0),
                    ),
                  )),
              Card(
                  color: Colors.white,
                  margin:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                  child: ListTile(
                    leading: Icon(
                      Icons.phone,
                      color: Colors.teal[900],
                    ),
                    title: Text(
                      '+91 85465XXX8XX',
                      style: TextStyle(fontFamily: 'BalooBhai', fontSize: 20.0),
                    ),
                  )),
              Card(
                color: Colors.white,
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                child: ListTile(
                  leading: Icon(
                    Icons.cake,
                    color: Colors.teal[900],
                  ),
                  title: Text(
                    '08-05-1995',
                    style: TextStyle(fontSize: 20.0, fontFamily: 'Neucha'),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
