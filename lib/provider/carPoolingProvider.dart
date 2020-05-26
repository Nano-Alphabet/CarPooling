import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:uniteonwheels/models/Cluster.dart';
import 'package:uniteonwheels/models/currentUser.dart';

class CarPoolingProvider with ChangeNotifier {
  //
  //VARIABLES -------------------------
  CurrentUser user;
  /*
  *CLUSTERS key: unique cluster ID
  *this will help us in accessing clusters more effectively*/
  Map<String, Cluster> clustersMap;

  //
  //INIT -----------------------------
  CarPoolingProvider() {
    loadClusterData();
  }

  //
  //LOADERS --------------------------

  Future<String> loadClusterData() async {
    await Firestore.instance
        .collection("clusters")
        .getDocuments()
        .then((value) {
      value.documents.forEach((element) {
        clustersMap.addAll({
          element.documentID: Cluster.fromMap(element.data),
        });

        clusters.add(Cluster.fromMap(element.data));
      });
    });
    return "done";
  }

  //
  //SETERS ---------------------------
  Future<String> setData(Cluster cluster) async {
    await Firestore.instance.collection("clusters").add(cluster.toMap());

    return "done";
  }
  //
  //VALIDATORS -----------------------
}
