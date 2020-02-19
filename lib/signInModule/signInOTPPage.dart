<<<<<<< HEAD
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
                Text("Kindly Enter the OTP received"),
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
=======
>>>>>>> e0dca313cae3e30cc2264109357954df2e88e940
