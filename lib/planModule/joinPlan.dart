import 'package:flutter/material.dart';


class JoinPlan extends StatefulWidget {
  @override
  _JoinPlanState createState() => _JoinPlanState();
}

class _JoinPlanState extends State<JoinPlan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Create Plan"),
        ),
        body: Container(
          child: Center(
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(20),
                  child: Image.network(
                      "https://cdn.dnaindia.com/sites/default/files/styles/full/public/2019/09/17/868494-carpooling-service-istock-091719.jpg"),
                ),
                Text(
                  "Kindly Enter Your Number",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                Center(
                  child: Row(
                    children: <Widget>[
                      MaterialButton(
                        height: 30.0,
                        minWidth: 30.0,
                        color: Theme.of(context).primaryColor,
                        textColor: Colors.white,
                        child: Text("+91"),
                        onPressed: () => {},
                        splashColor: Colors.redAccent,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 25, 0.0, 25),
                  child: RaisedButton(
                    onPressed: null,
                    child: Text('Next'),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}