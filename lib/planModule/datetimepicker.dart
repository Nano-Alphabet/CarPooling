import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter/material.dart';

class DateTimePicker extends StatefulWidget {
  final Function onSaved;
  final Function onSaved2;
  DateTime _date;
  DateTime _time;
  String _datestring;
  String _timestring;
  DateTimePicker({this.onSaved, this.onSaved2});
  @override
  _DateTimePickerState createState() => _DateTimePickerState(
      onSaved: onSaved,
      date: _date,
      time: _time,
      datestring: _datestring,
      timestring: _timestring,
      onSaved2: onSaved2);
}

class _DateTimePickerState extends State<DateTimePicker> {
  Function onSaved;
  DateTime date;
  DateTime time;
  String datestring;
  String timestring;
  Function onSaved2;
  _DateTimePickerState(
      {this.onSaved,
      this.date,
      this.datestring,
      this.time,
      this.timestring,
      this.onSaved2});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.2,
      width: MediaQuery.of(context).size.width * 0.8,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            elevation: 4.0,
            onPressed: onSaved,
            child: Container(
              alignment: Alignment.center,
              height: 50.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.date_range,
                              size: 18.0,
                              color: Colors.teal,
                            ),
                            Text(
                              "$datestring",
                              style: TextStyle(
                                color: Colors.teal,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Text(
                    " Change",
                    style: TextStyle(
                      color: Colors.teal,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                ],
              ),
            ),
            color: Colors.white,
          ),
          SizedBox(
            height: 20.0,
          ),
          RaisedButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
            elevation: 4.0,
            onPressed: onSaved2,
            child: Container(
              alignment: Alignment.center,
              height: 50.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.access_time,
                              size: 18.0,
                              color: Colors.teal,
                            ),
                            Text("$timestring",
                                style: TextStyle(
                                  color: Colors.teal,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0,
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Text(
                    " Change",
                    style: TextStyle(
                        color: Colors.teal,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0),
                  ),
                ],
              ),
            ),
            color: Colors.white,
          )
        ],
      ),
    );
  }
}
