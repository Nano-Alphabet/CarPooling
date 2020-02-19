import 'package:flutter/material.dart';
import 'package:pin_entry_text_field/pin_entry_text_field.dart';

class MySignInOTPPage extends StatefulWidget {
  @override
  _MySignInOTPPageState createState() => _MySignInOTPPageState();
}

class _MySignInOTPPageState extends State<MySignInOTPPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("OTP Page"),
        ),
        body: Container(
          child: Center(
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    "Kindly Enter the OTP received",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                PinEntryTextField(
                  fields: 6,
                  onSubmit: (String pin) {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("Pin"),
                            content: Text('Pin entered is $pin'),
                          );
                        }); //end showDialog()
                  }, // end onSubmit
                ),
                RaisedButton(
                  onPressed: null,
                  child: Text('Next'),
                )
              ],
            ),
          ),
        ));
  }
}
