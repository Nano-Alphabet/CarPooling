import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uow/errorHandlerModule/errorDialouges.dart';

class ForgotPasswordDialog extends StatefulWidget {
  @override
  ForgotPasswordDialogState createState() => ForgotPasswordDialogState();
}

class ForgotPasswordDialogState extends State<ForgotPasswordDialog> {
  TextEditingController emailController = TextEditingController();

  Future<bool> _changePassword() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text);
      return true;
    } catch (e) {
      errorDialog(
          context: context, title: 'Error Occured', body: e.message.toString());
      return false;
    }
  }

  void _changePasswordDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter Email Address'),
          content: ListView(
            shrinkWrap: true,
            children: <Widget>[
              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {},
                decoration: InputDecoration(hintText: 'Email'),
              ),
              Text(
                  '\nYou can recover your password from the link which will be sent to your email ID')
            ],
          ),
          contentPadding: EdgeInsets.all(10.0),
          actions: <Widget>[
            FlatButton(
              child: Text('Close'),
              onPressed: () async {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('Send'),
              onPressed: () async {
                if (await _changePassword()) {
                  Fluttertoast.showToast(
                      msg: 'Please check your email to reset password');
                }
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _changePasswordDialog(context);
      },
      child: Text(
        'forget password',
        style: TextStyle(color: Colors.blue),
      ),
    );
  }
}
