import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uow/LocationModule/clusterLocationPage.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:provider/provider.dart';
import 'package:uow/loginModule/signuppage.dart';
import 'package:uow/models/request.dart';
import 'package:uow/profile/profile.dart';
import 'package:uow/provider/carPoolingProvider.dart';
import 'package:uow/temp/bottomButtons.dart';
import 'package:uow/tempNavigator.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/foundation.dart';
import 'package:uow/Notification/notificationpage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey _scaffoldKey = new GlobalKey();
  @override
  Widget build(BuildContext context) {
    var prov = Provider.of<CarPoolingProvider>(context, listen: false)
        .globalClustersMap;
    return Scaffold(
      /*appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: ListTile(
            leading: null,
            dense: true,
            contentPadding: EdgeInsets.all(0),
            title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(border: OutlineInputBorder()),
              ),
            ),
            trailing: Icon(Icons.search),
          ),
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
        ),*/
      key: _scaffoldKey,
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              height: 75.0,
              child: DrawerHeader(
                child: Center(
                  child: Text(
                    'MySelf',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
                decoration: BoxDecoration(color: Colors.blueGrey),
                margin: EdgeInsets.all(0.0),
                padding: EdgeInsets.all(0.0),
              ),
            ),
            ListTile(
              title: Text('Home'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Profile'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => ProfilePage()));
              },
            ),
            ListTile(
              title: Text('Sign Up'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => SignUp()));
              },
            ),
            ListTile(
              title: Text('Temp Page'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => TempNavigator()));
              },
            ),
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                "https://miro.medium.com/max/720/1*pCcEZ-0Hj6dp1jpCBZsJGg.jpeg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: <Widget>[
            ClusterLocationPage(),
            Positioned(
                top: 25,
                left: 0,
                right: 0,
                child: SearchBar(
                  scaffoldKey: _scaffoldKey,
                )),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: BottomButtons(),
              ),
            ),
          ],
        ),
      ),
      /* floatingActionButton: FloatingActionButton(onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => LoadLocationMap()));
      }),*/
    );
  }
}

final String server =
    debugDefaultTargetPlatformOverride == TargetPlatform.android
        ? "10.0.2.2"
        : "0.0.0.0";

Widget setUpAlertDialoadBox() {
  var requestsArray = <RequestCard>[];
  addRequests() {
    // clusters.add(cluster);
    requests.forEach((i) {
      requestsArray.add(RequestCard(request: i));
    });
    return requestsArray;
  }

  return Scrollbar(
    child: Container(
        height: 200,
        width: 60,
        child: ListView(
          children: addRequests(),
        )),
  );
}

Widget _dialogBuilder() {
  print('Hello');
  return SimpleDialog(
    contentPadding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 2.0),
    backgroundColor: Colors.blueGrey,
    children: [
      Padding(
        padding: const EdgeInsets.all(0),
        child: setUpAlertDialoadBox(),
      )
    ],
  );
}

class SearchBar extends StatefulWidget {
  final scaffoldKey;
  SearchBar({Key key, @required this.scaffoldKey}) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState(scaffoldKey);
}

class _SearchBarState extends State<SearchBar> {
  final _scaffoldKey;
  _SearchBarState(this._scaffoldKey);
  bool isReadOnly = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(10),
      alignment: Alignment.center,
      // width: MediaQuery.of(context).size.width * 0.1,
      child: FittedBox(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Material(
              color: Colors.indigo, // button color
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    bottomLeft: Radius.circular(50)),
              ),
              elevation: 5,
              child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: IconButton(
                    icon: Icon(
                      Icons.menu,
                      color: Colors.amberAccent,
                    ),
                    onPressed: () {
                      _scaffoldKey.currentState.openDrawer();
                    },
                  )),
            ),
            Material(
              elevation: 5,
              child: Container(
                  clipBehavior: Clip.hardEdge,
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width * 0.5,
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: "Unite On Wheels"
                      .text
                      .textStyle(GoogleFonts.balooDa(textStyle: TextStyle()))
                      .size(20)
                      .make()
                  /* TextField(
                  showCursor: true,
                  controller: TextEditingController(text: "Unite On Wheels"),
                  style: GoogleFonts.balooDa(textStyle: TextStyle()),
                  keyboardType: TextInputType.text,
                  autofocus: false,
                  maxLines: 1,
                  readOnly: true,
                  onTap: () {
                    print("object");
                    setState(() {
                      isReadOnly = !isReadOnly;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Enter Address',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(left: 10, top: 15),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {},
                      iconSize: 25,
                    ),
                  ),
                  onEditingComplete: () {},
                  onSubmitted: (val) {
                    setState(() {});
                  },
                  onChanged: (val) {
                    setState(() {});
                  },
                ),*/
                  ),
            ),
            Material(
              color: Colors.indigo, // button color
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(50),
                    bottomRight: Radius.circular(50)),
              ),
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: IconButton(
                  icon: Icon(
                    Icons.notification_important,
                    color: Colors.amberAccent,
                    size: 35,
                  ),
                  // onPressed: () => showDialog(
                  //   context: context,
                  //   child: _dialogBuilder(),
                  // ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => NotificationPage(),
                        ));
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
