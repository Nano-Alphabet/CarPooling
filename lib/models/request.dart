import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uow/models/Cluster.dart';
import 'package:uow/planModule/viewPlan.dart';
import 'package:velocity_x/velocity_x.dart';

var requests = <Request>[
  Request(
    requestUserID: "12345",
    clusterID: "",
    isAccepted: false,
    phoneNo: "1234567890",
  ),
  Request(
    requestUserID: "12345",
    clusterID: "",
    isAccepted: false,
    phoneNo: "1234567890",
  ),
  Request(
    requestUserID: "12345",
    clusterID: "",
    isAccepted: false,
    phoneNo: "1234567890",
  ),
];

class Request {
  //  For the time being, I am keeping all of these as strings
  String clusterID;
  String phoneNo;
  String requestUserID;
  String requestUserName;
  bool isAccepted;

  Request({this.requestUserID, this.clusterID, this.isAccepted, this.phoneNo});

  Request.fromMap(Map data) {
    this.requestUserID = data["requestUserID"] ?? "";
    this.clusterID = data["clusterID"] ?? "";
    this.isAccepted = data["isAccepted"] ?? false;
    this.phoneNo = data["phoneNo"] ?? "";
    this.requestUserName = data["requestUserName"] ?? "";
  }

  Map<String, dynamic> toMap() {
    return {
      "adminUserID": requestUserID,
      "requestUserName": requestUserName,
      "clusterID": clusterID,
      "isAccepted": isAccepted,
      "phoneNo": phoneNo,
    };
  }
}

class ClusterCard extends StatelessWidget {
  final Cluster cluster;
  ClusterCard({this.cluster});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 25, 10, 4),
      decoration: BoxDecoration(
          border: Border(
        bottom: BorderSide(width: 1.0, color: Colors.black),
      )),
      child: IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: SizedBox(
                  // height: 75.0,
                  width: 170.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        cluster.date,
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Text(
                          cluster.initialLocation,
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
                  width: 170.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        cluster.leavingTime.toString(),
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Text(
                          cluster.finalLocation,
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
            FlatButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            ViewPlan(cluster: cluster)));
              },
              child: Icon(
                Icons.info,
                color: Colors.green,
                // size: 30.0,
              ),
            )
          ],
        ),
      ),
    );
  }
}
