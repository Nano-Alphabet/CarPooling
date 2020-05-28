import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uow/models/Cluster.dart';
import 'package:uow/provider/carPoolingProvider.dart';
import 'package:velocity_x/velocity_x.dart';

class JoinPlan extends StatelessWidget {
  // final Cluster cluster=Cluster(adminFirstName: "Hello",adminLastName: "Yo");
  // JoinPlan({this.cluster});

  @override
  Widget build(BuildContext context) {
    var plans = <Widget>[];

    Map clusters = Provider.of<CarPoolingProvider>(context).globalClustersMap;
    print(clusters.length);
    clusters.forEach((key, value) {
      plans.add(ClusterCard(cluster: value, clusterID: key));
    });
    clusters.forEach((key, value) {
      print(value.adminFirstName);
    });

    return Scaffold(
      appBar: AppBar(
        title: Text("JoinPlan"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: plans,
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        Provider.of<CarPoolingProvider>(context, listen: false)
            .loadGlobalClusterData(force: true);
      }),
    );
  }
}
