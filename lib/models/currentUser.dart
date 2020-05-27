import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CurrentUser {
  String userFirstName;
  String userLastName;
  String password;
  String uid; //unique ID
  String phoneNo;
  double lat;
  double lng;

  void getCurrentUser() async {
    var spfs = await SharedPreferences.getInstance();
    this.userFirstName = spfs.getString("userFirstName");
    this.userLastName = spfs.getString("userLastName");
    this.password = spfs.getString("password");
    this.uid = spfs.getString("uid");
    this.phoneNo = spfs.getString("phoneNo");
    this.lat = spfs.getDouble("lat");
    this.lng = spfs.getDouble("lng");
  }

  Future<void> setCurrentData() async {
    var spfs = await SharedPreferences.getInstance();
    spfs.setString("userFirstName", userFirstName).catchError((err) {
      Fluttertoast.showToast(msg: "Error setting user name");
    });
    spfs.setString("userLastName", userLastName).catchError((err) {
      Fluttertoast.showToast(msg: "Error setting user name");
    });
    spfs.setString("phoneNo", phoneNo).catchError((err) {
      Fluttertoast.showToast(msg: "Error setting user name");
    });
    spfs.setString("password", password).catchError((err) {
      Fluttertoast.showToast(msg: "Error setting user name");
    });
    spfs.setString("uid", uid).catchError((err) {
      Fluttertoast.showToast(msg: "Error setting user name");
    });
    spfs.setDouble("lat", lat).catchError((err) {
      Fluttertoast.showToast(msg: "Error setting user name");
    });
    spfs.setDouble("lng", lng).catchError((err) {
      Fluttertoast.showToast(msg: "Error setting user name");
    });
  }

  CurrentUser.fromMap(Map data) {
    this.userFirstName = data["userFirstName"] ?? "";
    this.userLastName = data["userLastName"] ?? "";
    this.password = data["password"] ?? "";
    this.uid = data["uid"] ?? "";
    this.phoneNo = data["phoneNo"] ?? "";
    this.lat = data["lat"] ?? 0;
    this.lng = data["lng"] ?? 0;
  }

  Map toMap() {
    return {
      "userFirstName": userFirstName,
      "userLastName": userLastName,
      "password": password,
      "uid": uid,
      "phoneNo": phoneNo,
      "lat": lat,
      "lng": lng,
    };
  }
}
