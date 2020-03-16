import 'package:flutter/material.dart';

class BottomButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Opacity(
            opacity: 0.8,
            child: RaisedButton(
              onPressed: () {
                print("This is a print()");
              },
              shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(25.0),
                      bottomLeft: Radius.circular(25.0))),
              color:Colors.indigo ,
              child: Text(
                "Join",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Opacity(
            opacity: 0.8,
            child: RaisedButton(
              onPressed: () {
                print("This is a print()");
              },
              shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.blueAccent),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25.0),
                      bottomRight: Radius.circular(25.0))),
              child: Text(
                "Create",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
