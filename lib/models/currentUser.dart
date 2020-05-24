import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CurrentUser {
  String userName;
  String password;

  String uid; //unique ID
  String phoneNo;
  double lat;
  double lng;

  void getCurrentUser() async {
    var spfs = await SharedPreferences.getInstance();
    this.userName = spfs.getString("userName");
    this.password = spfs.getString("password");
    this.uid = spfs.getString("uid");
    this.phoneNo = spfs.getString("phoneNo");
  }

  //TODO write setter functions for each variable
  //Example

  Future<void> setUserName(String _userName) async {
    var spfs = await SharedPreferences.getInstance();
    spfs.setString("userName", _userName).catchError((err) {
      Fluttertoast.showToast(msg: "Error setting user name");
    });
  }
}
