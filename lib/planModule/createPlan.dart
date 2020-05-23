import 'package:flutter/material.dart';

class CreatePlan extends StatefulWidget {
  @override
  _CreatePlanState createState() => _CreatePlanState();
}

class _CreatePlanState extends State<CreatePlan> {
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
  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          FormField(label: "Name"),
        ]);
  }
}

class FormField extends StatefulWidget {
  final label;
  FormField({Key key, @required this.label}) : super(key: key);
  @override
  _FormFieldState createState() => _FormFieldState(label);
}

class _FormFieldState extends State<FormField> {
  final label;
  _FormFieldState(this.label);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              //  padding: EdgeInsets.all(20.0),
              margin: EdgeInsets.all(5),
              child: Text(
                label,
                style: TextStyle(
                    fontSize: 18.0,
                    color: const Color(0xFF000000),
                    fontWeight: FontWeight.w300,
                    fontFamily: "Roboto"),
              ),
            ),
            Flexible(
              fit: FlexFit.loose,
              child: TextField(
                style: TextStyle(
                    fontSize: 18.0,
                    color: const Color(0xFF000000),
                    fontWeight: FontWeight.w200,
                    fontFamily: "Roboto"),
              ),
            )
          ]),
    );
  }
}
