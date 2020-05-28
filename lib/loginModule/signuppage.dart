import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:uow/provider/carPoolingProvider.dart';
import 'package:velocity_x/velocity_x.dart';

import 'widgets/phoneVerificationPopup.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool isSignUp = false;
  // to hold values of phone no. input
  TextEditingController userPhoneConte = TextEditingController();

  // to notify errors in phone no. input
  bool hasError = false;
  String userName = "";

  String basicValidator(String value) {
    if (value == '') {
      return 'Input Required';
    } else {
      return null;
    }
  }

  // This Function performs sigin operation.
  void _performSignIn() async {
    // condition check : if correct phone no. is entered.
    if (userPhoneConte.text == "" ||
        userPhoneConte.text.length < 10 ||
        (userName == "" && isSignUp)) {
      setState(() {
        hasError = true;
      });
      Fluttertoast.showToast(
          msg: 'Please provide a phone number ' +
              (isSignUp ? "and UserName" : ""));
      return;
    }

    FirebaseUser _response; // var to store sign-Ined user
    await showDialog(
        context: context,
        builder: (context) {
          // in response we get the firebase user object, which is set equal to _response
          return PhoneVerificationPopup(
            phoneNo: userPhoneConte.text,
            callBack: (FirebaseUser status) {
              _response = status;
            },
          );
        },
        barrierDismissible: false);

    if (_response.displayName == null || _response.displayName == "") {
      setState(() {
        isSignUp = true;
      });
      await showDialog(
          context: context,
          builder: (context) {
            // in response we get the firebase user object, which is set equal to _response
            return AlertDialog(
              title: "Please Enter User Name".text.make(),
              content: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  cursorColor: Colors.greenAccent,
                  style: TextStyle(fontSize: 25),
                  onChanged: (val) {
                    setState(() {
                      userName = val;
                    });
                  },
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
              ),
              actions: [
                FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: "OK".text.make())
              ],
            );
          },
          barrierDismissible: false);
      if (userName == "") {
        return;
      }
    }

    // found user in response
    if (_response != null) {
      // save the current user in memory and current state
      UserUpdateInfo info = new UserUpdateInfo();
      info.displayName = userName;
      if (isSignUp) await _response.updateProfile(info);
      await Provider.of<CarPoolingProvider>(context, listen: false)
          .currentUser
          .storeUserInMemory(_response);

      Fluttertoast.showToast(msg: 'Saved');

      // navigate to home screen
      Navigator.pushReplacementNamed(context, '/home');
    }

    // User not found flash a message
    Fluttertoast.showToast(msg: 'Failure');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: true,
      extendBody: true,
      body: Flex(
        direction: Axis.vertical,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Container(
              child: Stack(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(15, 30, 0, 0),
                    child: Text(
                      isSignUp ? 'Signup' : "Log-in",
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
                ],
              ),
            ),
          ),

          Container(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Column(
              children: <Widget>[
                isSignUp
                    ? TextField(
                        cursorColor: Colors.greenAccent,
                        style: TextStyle(fontSize: 25),
                        onChanged: (val) {
                          setState(() {
                            userName = val;
                          });
                        },
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
                      )
                    : Container(),
                SizedBox(height: 20),
                TextField(
                  style: TextStyle(fontSize: 25),
                  controller: userPhoneConte,
                  maxLength: 10,
                  decoration: InputDecoration(
                    labelText: 'PHONE',
                    prefixText: "+91",
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
                  cursorColor: Colors.greenAccent,
                ),
              ],
            ),
          ),
          Expanded(child: Container()), //adds space
          Container(
            height: 45,
            // width: 100,
            margin: EdgeInsets.symmetric(horizontal: 30),
            child: GestureDetector(
              onTap: () {
                print('hello2');
                _performSignIn();
              },
              child: Material(
                borderRadius: BorderRadius.circular(20.0),
                shadowColor: Colors.greenAccent,
                color: Colors.green,
                elevation: 7.0,
                child: Center(
                  child: Text(
                    isSignUp ? 'SIGNUP' : "LOGIN",
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
          // Temporary Back Button for Back Navigation
          Padding(
            padding: const EdgeInsets.all(8.0).copyWith(bottom: 20),
            child: Center(
              child: FlatButton(
                  onPressed: () {
                    setState(() {
                      isSignUp = !isSignUp;
                    });
                  },
                  child: Text(!isSignUp ? "Sign-Up" : "Log-In")),
            ),
          ),
        ],
      ),
    );
  }
}
