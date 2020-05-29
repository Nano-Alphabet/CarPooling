import 'package:flutter/material.dart';
// import 'package:flutter_for_web/cupertino.dart';
import 'package:velocity_x/velocity_x.dart';

// import 'dart:html' as html;
class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: choices.length,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.indigoAccent,
            title: Text('Requests'),
            centerTitle: true,
            bottom: TabBar(
              isScrollable: true,
              tabs: choices.map((Choice choice) {
                return Tab(
                  text: choice.title,
                  // icon: Icon(choice.icon),
                );
              }).toList(),
            ),
          ),
          body: TabBarView(
            children: tabwidgets.map((Widget tabwidget) {
              return Padding(
                padding: const EdgeInsets.all(5.0),
                child: tabwidget,
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class Choice {
  const Choice({this.title});

  final String title;
}

const List<Choice> choices = const <Choice>[
  const Choice(title: 'MY REQUESTS'),
  const Choice(title: 'JOIN REQUESTS'),
];
List<Widget> tabwidgets = [MyReq(), JoinReq()];

class Entry {
  Entry(
      {this.carNumber,
      this.cost,
      this.finLoc,
      this.firstName,
      this.initLoc,
      this.secondName,
      this.isApproved,
      this.phone});
  String firstName;
  String secondName;
  String initLoc;
  String finLoc;
  int cost;
  String carNumber;
  int phone;
  bool isApproved;
}

List<Entry> entries = <Entry>[
  Entry(
    firstName: 'Ruchir',
    secondName: 'Mehta',
    carNumber: 'XY123',
    cost: 211,
    finLoc: 'Dagla',
    initLoc: 'Kheda',
    isApproved: true,
  ),
  Entry(
    firstName: 'Ruchir',
    secondName: 'Mehta',
    carNumber: 'XY123',
    cost: 211,
    finLoc: 'Dagla',
    initLoc: 'Kheda',
    isApproved: true,
  ),
  Entry(
    firstName: 'Ruchir',
    secondName: 'Mehta',
    carNumber: 'XY123',
    cost: 211,
    finLoc: 'Dagla',
    initLoc: 'Kheda',
    isApproved: false,
  ),
  Entry(
    firstName: 'Ruchir',
    secondName: 'Mehta',
    carNumber: 'XY123',
    cost: 211,
    finLoc: 'Dagla',
    initLoc: 'Kheda',
    isApproved: false,
  ),
  Entry(
    firstName: 'Ruchir',
    secondName: 'Mehta',
    carNumber: 'XY123',
    cost: 211,
    finLoc: 'Dagla',
    initLoc: 'Kheda',
    isApproved: true,
  ),
];

class EntryCard extends StatefulWidget {
  final Entry entry;
  const EntryCard({this.entry});
  @override
  _EntryCardState createState() => _EntryCardState(entry: entry);
}

class _EntryCardState extends State<EntryCard> {
  Entry entry;
  _EntryCardState({this.entry});
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 50,
      shadowColor: Colors.black,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        entry.firstName + " " + entry.secondName,
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Car No : ${entry.carNumber}",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("From: ${entry.initLoc}",
                          style: TextStyle(fontSize: 15)),
                      Text("To: ${entry.finLoc}",
                          style: TextStyle(fontSize: 15)),
                      SizedBox(
                        height: 3,
                      ),
                      Text("Rs: ${entry.cost}", style: TextStyle(fontSize: 32)),
                    ],
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  RaisedButton(
                    onPressed: () {},
                    color: Colors.green,
                    child: Row(
                      children: <Widget>[
                        Text('WhatsApp ',style: TextStyle(color: Colors.black)),
                        Icon(
                          Icons.call_made,
                          color: Colors.white,
                        )
                      ],
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                  ),
                  entry.isApproved
                      ? FlatButton(
                          onPressed: () {},
                          child: Row(children: <Widget>[
                            Text("Completed "),
                            Icon(Icons.done_all,color:Colors.black)
                          ],),
                          color: Colors.grey,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                        )
                      : FlatButton(
                          onPressed: () {},
                          child: Row(
                            children: <Widget>[
                              Text('Approve',style: TextStyle(color: Colors.white)),
                              Icon(Icons.time_to_leave,color: Colors.white),
                            ],
                          ),
                          color: Colors.blue,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)))),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MyReq extends StatefulWidget {
  @override
  _MyReqState createState() => _MyReqState();
}

class _MyReqState extends State<MyReq> {
  @override
  Widget build(BuildContext context) {
    var entriesArray = <EntryCard>[];

    addEntries() {
      entries.forEach((i) {
        entriesArray.add(EntryCard(entry: i));
      });
      return entriesArray;
    }

    return Scrollbar(
      child: Container(
        color: Colors.blueAccent,
        child: ListView(
          children: addEntries(),
        ),
      ),
    );
  }
}

class JoinReq extends StatefulWidget {
  @override
  _JoinReqState createState() => _JoinReqState();
}

class _JoinReqState extends State<JoinReq> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
    );
  }
}
