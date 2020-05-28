import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uow/models/Cluster.dart';
import 'package:uow/models/currentUser.dart';
import 'package:uow/models/request.dart';

class CarPoolingProvider with ChangeNotifier {
  //
  //VARIABLES -------------------------
  CurrentUser currentUser;
  


  /*
  *CLUSTERS key: unique cluster ID
  *this will help us in accessing clusters more effectively*/
  Map<String, Cluster> globalClustersMap = {};
  Map<String, Cluster> myClustersHistoryMap = {};
  Map<String, Request> requestsMap = {};
  Map<String, Request> myRequestHistoryMap = {};


  //
  //INIT -----------------------------
  CarPoolingProvider() {
    
    loadGlobalClusterData(force: true);
    loadMyClustersHistoryData(force: true);
  }

  //
  //LOADERS --------------------------

  Future<String> loadGlobalClusterData({bool force = false}) async {
    if (force || globalClustersMap.length == 0)
      await Firestore.instance
          .collection("clusters")
          .where("leavingTime",
              isGreaterThan: DateTime.now()
                  .subtract(Duration(hours: 3))
                  .millisecondsSinceEpoch)
          .getDocuments()
          .then((value) {
        value.documents.forEach((element) {
          globalClustersMap.addAll({
            element.documentID: Cluster.fromMap(element.data),
          });
          // clusters.add(Cluster.fromMap(element.data)); //TODO remove
          notifyListeners();
        });
      });
    print("Data Loaded from firebase");
    return "done";
  }

  Future<String> loadMyClustersHistoryData({bool force = false}) async {
    currentUser.uid="A12";
    currentUser.userFirstName="myFirstName";
    currentUser.userLastName="myLastName";
    if (force || myClustersHistoryMap.length == 0)
      await Firestore.instance
          .collection("clusters")
          .where("adminUserID", isEqualTo: currentUser.uid)
          .getDocuments()
          .then((value) {
        value.documents.forEach((element) {
          myClustersHistoryMap.addAll({
            element.documentID: Cluster.fromMap(element.data),
          });
          clusters.add(Cluster.fromMap(element.data)); //TODO remove
          notifyListeners();
        });
      });
    print("Data Loaded from firebase");
    return "done";
  }

  // Future<String> loadRequestData({String clusterId, bool force = false}) async {
  //   if (force || myClustersHistoryMap[clusterId] != null)
  //     await Firestore.instance
  //         .collection("clusters")
  //         .document(clusterId)
  //         .get()
  //         .then((value) {
  //       myClustersHistoryMap.addAll({
  //         value.documentID: Cluster.fromMap(value.data),
  //       });
  //       notifyListeners();
  //     });
  //   print("Data Loaded from firebase");
  //   return "done";
  // }

  //Using other version of loadRequestData

  Future<String> loadRequestData({String clusterId, bool force = false}) async {
    if (force || myClustersHistoryMap[clusterId] != null)
      await Firestore.instance
          .collection("request")
          .getDocuments()
          .then((value) {
        value.documents.forEach((element) {
          requestsMap.addAll({
            element.documentID: Request.fromMap(element.data),
          });

          notifyListeners();
        });
      });
    print("Requests Loaded from firebase");
    return "done";
  }

  //
  //SETERS ---------------------------

  //createClusterData you need not to send admin Id, phone no etc
  Future<String> createClusterData(Cluster cluster) async {
    cluster.adminFirstName = currentUser.userFirstName;
    cluster.adminLastName = currentUser.userLastName;
    cluster.adminUserID = currentUser.uid;
    cluster.phoneNo = currentUser.phoneNo;
    DocumentReference docRef = await Firestore.instance
        .collection("clusters")
        .add(cluster.toMap())
        .catchError(onError);
    myClustersHistoryMap[docRef.documentID] = cluster;
    globalClustersMap[docRef.documentID] = cluster;
    notifyListeners();
    print("Data uploaded to firebase");
    return "done";
  }

  // Future<String> createClusterJoinRequest(
  //     {@required Request request, @required String clusterID}) async {
  //   await Firestore.instance
  //       .collection("clusters")
  //       .document(clusterID)
  //       .setData({
  //     "requests": {currentUser.uid: request.toMap()}
  //   }, merge: true).catchError(onError);
  //   notifyListeners();
  //   print("Data uploaded to firebase");
  //   return "done";
  // }

  // other version with separate request table
  Future<String> createClusterJoinRequest(
      {Request request}) async {
    DocumentReference docRef = await Firestore.instance
        .collection("request")
        .add(request.toMap())
        .catchError(onError);

    myRequestHistoryMap[docRef.documentID] = request;
    // globalClustersMap[docRef.documentID] = cluster;
    notifyListeners();
    print("Request uploaded to firebase");
    return "done";
  }

  //
  //VALIDATORS -----------------------

  //
  //USER ----------------------------
  Future<String> signUpUser({@required CurrentUser user}) async {
    DocumentReference docRef = await Firestore.instance
        .collection("users")
        .add(user.toMap())
        .catchError(onError);
    currentUser = user;
    currentUser.uid = docRef.documentID;
    await currentUser.setCurrentData();
    notifyListeners();

    print("Sign up to firebase");
    return "done";
  }

  Future<bool> signInUser({@required CurrentUser user}) async {
    QuerySnapshot docRef = await Firestore.instance
        .collection("users")
        .where("phoneNo", isEqualTo: user.phoneNo)
        .where("password", isEqualTo: user.password)
        .getDocuments()
        .catchError((err) {
      onError(err);
      return false;
    });
    if (docRef.documents.length == 0) {
      onError("No user Found!");
      return false;
    }
    currentUser = CurrentUser.fromMap(docRef.documents[0].data);
    currentUser.uid = docRef.documents[0].documentID;
    await currentUser.setCurrentData();
    notifyListeners();
    return true;
  }

  Future<String> updateUser({@required CurrentUser user}) async {
    await Firestore.instance
        .collection("users")
        .document(user.uid)
        .setData(user.toMap(), merge: true)
        .catchError(onError);
    currentUser = user;
    await currentUser.setCurrentData();
    notifyListeners();

    print("Data Loaded from firebase");
    return "done";
  }

  //
  //ERROR Handling --------------------------
  void onError(dynamic err) {
    Fluttertoast.showToast(msg: err.toString());
  }
}
