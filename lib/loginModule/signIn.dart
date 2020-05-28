import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uow/errorHandlerModule/errorDialouges.dart';
import 'package:uow/provider/carPoolingProvider.dart';

import 'widgets/forgotPasswordDialog.dart';

class Authentication extends StatefulWidget {
  final Function toggleView;
  Authentication({this.toggleView});

  @override
  _AuthenticationPageState createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<Authentication> {
  String email;
  String password;
  bool showPassword = false;
  final _formkey = GlobalKey<FormState>();

  FirebaseAuth _auth = FirebaseAuth.instance;
  SharedPreferences sharedPreferences;

  signInwithEmailAndPassword() async {
    try {
      // try sign in using firebase auth
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      final FirebaseUser currentUser =
          await Provider.of<CarPoolingProvider>(context, listen: false)
              .currentUser
              .getCurrentUser();

      assert(user.uid == currentUser.uid);
      await Provider.of<CarPoolingProvider>(context, listen: false)
          .currentUser
          .storeUserInMemory(user);

      // Navigate to App Screen -- User is loged IN,
      _setRoute();
      return true;
    } catch (e) {
      print(e.toString());
      errorDialog(
          context: context, title: 'Error Occured', body: e.message.toString());
      return false;
    }
  }

  void _setRoute() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    print('user :' + user.uid);
    if (user != null) {
      Navigator.of(context).pushReplacementNamed('/home');
    } else {
      await FirebaseAuth.instance.signOut();
      Navigator.of(context).pushReplacementNamed('/sign');
      errorDialog(
          context: context,
          title: 'User not found',
          body: 'You are not added as an user');
    }
  }

  bool validateStructure(String value) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      drawer: null,
      body: Container(
        width: double.infinity,
        child: Form(
          key: _formkey,
          child: Flex(
            direction: Axis.vertical,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                //mainAxisAlignment: MainAxisAlignment.center,
                //children: <Widget>[
                flex: 3,
                child: Center(
                  child: Text(
                    "Hexanovate",
                    style: TextStyle(fontSize: 30.0),
                  ),
                ),
                //],
              ),
              Expanded(
                flex: 1,
                child: SizedBox(
                  height: 10,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(labelText: 'Email'),
                  validator: (val) => val.isEmpty ? 'Enter an Email' : null,
                  onChanged: (val) {
                    setState(() => email = val);
                  },
                  onSaved: (val) => email = val,
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
                child: TextFormField(
                  obscureText: !showPassword,
                  decoration: InputDecoration(
                      labelText: 'Password',
                      suffixIcon: IconButton(
                          icon: Icon(
                            Icons.remove_red_eye,
                            color: showPassword ? Colors.indigo : Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              showPassword = !showPassword;
                            });
                          })),
                  /*validator: (val) => val.length < 8 && !validateStructure(val)
                      ? 'Password must have Length 8+, Uppercase, Number and Special Character'
                      : null,*/
                  onChanged: (val) {
                    setState(() => password = val);
                  },
                  onSaved: (val) => password = val,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12.0, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[ForgotPasswordDialog()],
                ),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 20.0, right: 20.0, bottom: 10),
                            child: GestureDetector(
                              onTap: () async {
                                if (_formkey.currentState.validate()) {
                                  dynamic result =
                                      await signInwithEmailAndPassword();
                                  if (result == null) {
                                    errorDialog(
                                        context: context,
                                        title: 'Error',
                                        body: 'error occured');
                                  } else {
                                    final form = _formkey.currentState;
                                    form.save();
                                    //CHANGES MADE
                                    Navigator.popAndPushNamed(context, '/home');
                                  }
                                }
                              },
                              child: Container(
                                  alignment: Alignment.center,
                                  height: 60.0,
                                  decoration: BoxDecoration(
                                      color: Color(0xFF18D191),
                                      borderRadius:
                                          BorderRadius.circular(35.0)),
                                  child: Text("Login",
                                      style: TextStyle(
                                          fontSize: 20.0,
                                          color: Colors.white))),
                            ),
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      child: Text("Sign Up Options",
                          style: TextStyle(
                              fontSize: 20.0,
                              color: Color(0xFF18D191),
                              fontWeight: FontWeight.bold)),
                      onTap: () {
                        widget.toggleView();
                      },
                    )
                  ],
                ),
              ),
              Expanded(
                child: Divider(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
