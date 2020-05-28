import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:provider/provider.dart';
import 'package:uow/models/Cluster.dart';
import 'package:uow/planModule/joinPlan.dart';
import 'package:uow/provider/carPoolingProvider.dart';
import 'datetimepicker.dart';
class CreatePlan extends StatefulWidget {
  @override
  _CreatePlanState createState() => _CreatePlanState();
}

class _CreatePlanState extends State<CreatePlan> {
  final _formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Create Plan"),
        ),
        body: CreatePlanForm());
  }
}

class CreatePlanForm extends StatefulWidget {
  @override
  _CreatePlanFormState createState() => _CreatePlanFormState();
}

class _CreatePlanFormState extends State<CreatePlanForm> {
  //  user defined function
  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Success!"),
          content: new Text("Plan created successfully"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  final _formKey = GlobalKey<FormState>();
  Cluster cluster = Cluster();
  DateTime _date;
  String _datestring;
  String _timestring;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        children: <Widget>[
          //TODO! remove firstName, LastName, phoneNo, adminID they are handeled in provider
          FormField(
            labelText: "First Name",
            initVal: cluster.adminFirstName,
            validator: (String value) {
              if (value.isEmpty) {
                return 'Please enter your name';
              }
              return null;
            },
            onSaved: (String value) {
              cluster.adminFirstName = value;
            },
          ),
          FormField(
            labelText: "Last Name",
            validator: (String value) {},
            onSaved: (String value) {
              cluster.adminLastName = value;
            },
          ),
          FormField(
            labelText: "Pickup Point",
            validator: (String value) {},
            onSaved: (String value) {
              cluster.initialLocation =
                  value; //TODO NAvigate to Slect Location Page
            },
          ),
          FormField(
            labelText: "Drop Point",
            validator: (String value) {},
            onSaved: (String value) {
              cluster.finalLocation = value;
            },
          ),
          FormField(
            labelText: "Phone No",
            validator: (String value) {},
            onSaved: (String value) {
              cluster.phoneNo = value;
            },
          ),
          FormField(
            labelText: "Cost",
            validator: (String value) {},
            onSaved: (String value) {
              cluster.cost = value;
            },
          ),
          FormField(
            labelText: "Number of Passengers",
            validator: (String value) {},
            onSaved: (String value) {
              cluster.noOfPassengers = int.parse(value);
            },
          ),
          FormField(
            labelText: "Car Number",
            validator: (String value) {},
            onSaved: (String value) {
              cluster.carNo = value;
            },
          ),
          FormField(
            labelText: "Car Type",
            validator: (String value) {},
            onSaved: (String value) {
              cluster.carType = value;
            },
          ),
          DateTimePicker(
            onSaved: (DateTime date) {
                  _date=date;
                  setState((){});
            },
            onSaved2: (DateTime time) {
                  _date=DateTime(_date.year,_date.month,_date.day,time.hour,time.minute,time.second);
                  setState(() {});
            },
            ),
          FormField(
            labelText: "Admin User Id",
            validator: (String value) {},
            onSaved: (String value) {
              cluster.adminUserID = value;
            },
          ),
          RaisedButton(
            color: Colors.blueAccent,
            onPressed: () {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                cluster.leavingTime=_date.millisecondsSinceEpoch;
                Provider.of<CarPoolingProvider>(context, listen: false)
                    .createClusterData(cluster);
                // clusters.add(cluster);
                _showDialog();
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => JoinPlan(cluster: this.cluster)));
              }
            },
            child: Text(
              'Create Plan',
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class FormField extends StatelessWidget {
  final String labelText;
  final Function validator;
  final Function onSaved;
  final String initVal;

  FormField({
    this.labelText,
    this.validator,
    this.onSaved,
    this.initVal,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: TextFormField(
        cursorColor: Colors.teal,
        initialValue: "",
        style: TextStyle(fontSize: 20),
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: GoogleFonts.montserrat(
            textStyle: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.teal),
          ),
        ),
        validator: validator,
        onSaved: onSaved,
      ),
    );
  }
}

// class FormField extends StatefulWidget {
//   final label;
//   FormField({Key key, @required this.label}) : super(key: key);
//   @override
//   _FormFieldState createState() => _FormFieldState(label);
// }

// class _FormFieldState extends State<FormField> {
//   final label;
//   _FormFieldState(this.label);
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
//       child: TextFormField(
//         cursorColor: Colors.greenAccent,
//         style: TextStyle(fontSize: 20),
//         decoration: InputDecoration(
//           labelText: label,
//           labelStyle: GoogleFonts.montserrat(
//             textStyle: TextStyle(
//               fontSize: 16,
//               color: Colors.grey,
//             ),
//           ),
//           focusedBorder: UnderlineInputBorder(
//             borderSide: BorderSide(color: Colors.green),
//           ),
//         ),
//         onSaved: (String value) {
//           // This optional block of code can be used to run
//           // code when the user saves the form.
//         },
//         validator: (String value) {
//           // print("The value is"+value);
//         },
//       ),
//     );
//   }
// }
