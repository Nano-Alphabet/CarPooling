import 'package:flutter/material.dart';
import 'package:uow/models/Cluster.dart';

class ViewPlan extends StatelessWidget {
  final Cluster cluster;
  ViewPlan({this.cluster});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: FlatButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: SizedBox(
            width: 350.0,
            height: 550.0,
            // isCornerRounded: true,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.white,
              ),
              padding: const EdgeInsets.all(20.0),
              // color: Colors.white,
              child: ListView(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: 120.0,
                        height: 25.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.0),
                          border: Border.all(width: 1.0, color: Colors.green),
                        ),
                        child: Center(
                          child: Text(
                            cluster.adminUserID,
                            style: TextStyle(color: Colors.green),
                          ),
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            'SLM',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Icon(
                              Icons.directions_car,
                              color: Colors.pink,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              'BTL',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Text(
                      'Journey Details',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25.0),
                    child: Column(
                      children: <Widget>[
                        ticketDetailsWidget(
                            'First Name',
                            cluster.adminFirstName,
                            'Last name',
                            cluster.adminLastName),
                        Padding(
                          padding: const EdgeInsets.only(top: 12.0),
                          child: ticketDetailsWidget(
                              'Date', cluster.date, 'time', cluster.time),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 12.0),
                          child: ticketDetailsWidget('Car No', cluster.carNo,
                              'Pick Up', cluster.initialLocation),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 12.0),
                          child: ticketDetailsWidget(
                              'Car type',
                              cluster.carType,
                              'Drop Point',
                              cluster.finalLocation),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 80.0, left: 30.0, right: 30.0),
                    child: Container(
                        width: 250.0,
                        height: 60.0,
                        child: RaisedButton(
                          onPressed: () {
                            print("Send chat message on whatsapp no " +
                                cluster.phoneNo);
                          },
                          child: Text("Send join request"),
                        )),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(
                  //       top: 10.0, left: 75.0, right: 75.0),
                  //   child: Text(
                  //     '9824 0972 1742 1298',
                  //     style: TextStyle(
                  //       color: Colors.black,
                  //     ),
                  //   ),
                  // )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget ticketDetailsWidget(String firstTitle, String firstDesc,
      String secondTitle, String secondDesc) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: SizedBox(
                // height: 75.0,
                width: 120.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      firstTitle,
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text(
                        firstDesc,
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: SizedBox(
                // height: 75.0,
                width: 120.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      secondTitle,
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text(
                        secondDesc,
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
