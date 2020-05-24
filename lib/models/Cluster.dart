import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

var clusters = <Cluster>[Cluster(adminFirstName: "Hello",adminLastName: "Yo")];

class Cluster {
  String adminFirstName;
  String adminLastName;
  String initialLocation;
  String finalLocation;
  String phoneNo;
  double cost;
  int noOfPassengers;
  String carNo;
  String carType;
  String time;
  String adminUserID;

  Cluster(
      {this.adminFirstName,
      this.adminLastName,
      this.initialLocation,
      this.finalLocation,
      this.phoneNo,
      this.cost,
      this.noOfPassengers,
      this.carNo,
      this.carType,
      this.time,
      this.adminUserID});
}

class ClusterCard extends StatelessWidget {
  final Cluster cluster;
  ClusterCard({this.cluster});

  @override
  Widget build(BuildContext context) {
    return Text(cluster.adminFirstName)
        .card
        .white
        .shadowColor(Colors.red)
        .roundedLg
        .make();
  }
}

// class ClusterCard extends StatefulWidget {
//   @override
//   _ClusterCardState createState() => _ClusterCardState();
// }

// class _ClusterCardState extends State<ClusterCard> {
//   Cluster cluster;
//   _ClusterCard(this.cluster);
//   @override
//   Widget build(BuildContext context) {
//     return Container(

//     );
//   }
// }
