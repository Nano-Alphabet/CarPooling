import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uow/models/Cluster.dart';
import 'package:uow/provider/carPoolingProvider.dart';
import 'package:velocity_x/velocity_x.dart';

class JoinPlan extends StatelessWidget {
  // final Cluster cluster=Cluster(adminFirstName: "Hello",adminLastName: "Yo");
  // JoinPlan({this.cluster});

  var plans = <ClusterCard>[];
  addPlans() {
    // clusters.add(cluster);
    clusters.forEach((i) {
      plans.add(ClusterCard(cluster: i));
    });
    return plans;
  }

  @override
  Widget build(BuildContext context) {
    Map clusters = Provider.of<CarPoolingProvider>(context).clustersMap;
    clusters.forEach((key, value) {
      plans.add(ClusterCard(cluster: value));
    });

    return Scaffold(
        appBar: AppBar(
          title: Text("JoinPlan"),
        ),
        body: ListView(
          padding: const EdgeInsets.all(8),
          children: addPlans(),
        ));
  }
}
