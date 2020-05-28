import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:provider/provider.dart';
import 'package:uow/provider/carPoolingProvider.dart';
import 'widgets/phoneVerificationPopup.dart';
import 'package:velocity_x/velocity_x.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    Key key,
  }) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // to hold values of phone no. input
  TextEditingController userPhoneConte = TextEditingController();

  // to notify errors in phone no. input
  bool hasError = false;

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
    if (userPhoneConte.text == "" || userPhoneConte.text.length < 10) {
      setState(() {
        hasError = true;
      });
      Fluttertoast.showToast(msg: 'Please provide a phone number');
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

    // found user in response
    if (_response != null) {
      // save the current user in memory and current state
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
      body: Flex(
        // to scale items according to screen size; is used to make responsive layouts
        direction: Axis.vertical,
        children: <Widget>[
          // TODO add logo
          Expanded(flex: 3, child: Placeholder()),
          Divider(),
          // Expanded is used to define the % portion of screen the perticular widget should take
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.only(left: 10, top: 10, right: 10),
              margin: EdgeInsets.only(left: 10, right: 10),
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(15)),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Enter Phone Number'.toUpperCase(),
                    ).text.bold.blue300.make(),
                    PinCodeTextField(
                      autofocus: false,
                      controller: userPhoneConte,
                      hideCharacter: false,
                      highlight: true,
                      highlightColor: Colors.blue,
                      defaultBorderColor: Colors.black,
                      hasTextBorderColor: Colors.green,
                      maxLength: 10,
                      pinBoxWidth: MediaQuery.of(context).size.width * 0.05,
                      pinBoxHeight: MediaQuery.of(context).size.width * 0.1,
                      hasError: false,
                      pinBoxOuterPadding: EdgeInsets.all(3),
                      onDone: (text) {
                        setState(() {});
                        print("DONE $text");
                        // TODO entered otp :: code
                      },
                      keyboardType: TextInputType.phone,

                      // pinCodeTextFieldLayoutType: PinCodeTextFieldLayoutType.AUTO_ADJUST_WIDTH,
                      wrapAlignment: WrapAlignment.center,
                      pinBoxDecoration:
                          ProvidedPinBoxDecoration.underlinedPinBoxDecoration,
                      pinTextStyle: TextStyle(fontSize: 15.0),
                      pinTextAnimatedSwitcherTransition:
                          ProvidedPinBoxTextAnimation.scalingTransition,
                      pinTextAnimatedSwitcherDuration:
                          Duration(milliseconds: 200),
                    ),
                  ]),
            ),
          ),

          Divider(),

          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, right: 20.0, bottom: 10),
                    child: GestureDetector(
                      onTap: () async {
                        _performSignIn();
                      },
                      child: Container(
                          alignment: Alignment.center,
                          height: 60.0,
                          decoration: BoxDecoration(
                              color: Color(0xFF18D191),
                              borderRadius: BorderRadius.circular(35.0)),
                          child: Text("Login",
                              style: TextStyle(
                                  fontSize: 20.0, color: Colors.white))),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
