import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(15, 60, 0, 0),
                  child: Text(
                    'Signup',
                    style: GoogleFonts.balooDa(
                      textStyle: TextStyle(
                        fontSize: 80.0,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(262, 70, 0, 0),
                  child: Text(
                    '.',
                    style: GoogleFonts.balooDa(
                      textStyle: TextStyle(
                        fontSize: 80.0,
                        color: Colors.green,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 180, left: 20, right: 20),
                  child: Column(
                    children: <Widget>[
                      TextField(
                        cursorColor: Colors.greenAccent,
                        style: TextStyle(fontSize: 25),
                        decoration: InputDecoration(
                          labelText: 'NAME',
                          labelStyle: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                              fontSize: 20,
                              color: Colors.grey,
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green),
                          ),
                        ),
                      ),
                      SizedBox(height:20),
                      TextField(
                        style: TextStyle(fontSize: 25),
                        decoration: InputDecoration(
                          labelText: 'PHONE',
                          labelStyle: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                              fontSize: 20,
                              color: Colors.grey,
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green),
                          ),
                        ),
                        obscureText: true,
                        cursorColor: Colors.greenAccent,
                      ),
                      SizedBox(height:20),
                      TextField(
                        cursorColor: Colors.greenAccent,
                        style: TextStyle(fontSize: 25),
                        decoration: InputDecoration(
                          labelText: 'EMAIL',
                          labelStyle: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                              fontSize: 20,
                              color: Colors.grey,
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 60),
          Container(
            height: 45,
            // width: 100,
            margin: EdgeInsets.symmetric(horizontal: 30),
            child: Material(
              borderRadius: BorderRadius.circular(20.0),
              shadowColor: Colors.greenAccent,
              color: Colors.green,
              elevation: 7.0,
              child: GestureDetector(
                onTap: () {
                  print('hello2');
                },
                child: Center(
                  child: Text(
                    'SIGNUP',
                    style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
