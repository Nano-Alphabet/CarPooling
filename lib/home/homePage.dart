import 'package:flutter/material.dart';
import 'package:uniteonwheels/temp/bottomButtons.dart';
import 'package:uniteonwheels/tempNavigator.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter/foundation.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey _scaffoldKey = new GlobalKey();
  @override
  Widget build(BuildContext context) {
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
                title: Text('History'),
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
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Settings'),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Temp Page'),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
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
              Positioned(
                  top: 25,
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
        ));
  }
}

class Customer {
  const Customer({this.name, this.phone});
  final String name;
  final int phone;
}

final String server =
    debugDefaultTargetPlatformOverride == TargetPlatform.android
        ? "10.0.2.2"
        : "0.0.0.0";

final List<Customer> customers = <Customer>[
  Customer(name: 'Ruchir', phone: 6377414790),
  Customer(name: 'Sreeharsh', phone: 6303073463),
  Customer(name: 'Ubaid', phone: 8149943088),
  Customer(name: 'Adarsh', phone: 6265252766)
];
Widget _listItemBuilder(BuildContext context, int index) {
  return Container(
    color: Colors.blue[50],
    padding: const EdgeInsets.only(right: 20.0),
    alignment: Alignment.center,
    child: Text(
      customers[index].name,
      style: Theme.of(context)
          .textTheme
          .headline
          .apply(color: Colors.indigo[700], backgroundColor: Colors.purple[50]),
    ),
  );
}

Widget _dialogBuilder() {
  print('Hello');
  return SimpleDialog(
    contentPadding: EdgeInsets.zero,
    children: [
      ListView.builder(
          itemCount: customers.length,
          itemExtent: 40.0,
          itemBuilder: _listItemBuilder),
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

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Flex(
        direction: Axis.horizontal,
        children: <Widget>[
          IconButton(
            icon: Icon(
              Icons.menu,
              color: Colors.black,
            ),
            onPressed: () {
              _scaffoldKey.currentState.openDrawer();
            },
          ),
          Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(4),
                width: MediaQuery.of(context).size.width * 0.7,
                height: 40,
                child: TextFormField(
                  decoration: InputDecoration(border: OutlineInputBorder()),
                ),
              ),
              Container(
                padding: EdgeInsets.all(8),
                width: MediaQuery.of(context).size.width * 0.7,
                height: 40,
                child: TextFormField(
                  decoration: InputDecoration(border: OutlineInputBorder()),
                ),
              ),
            ],
          ),
          6.widthBox,
          ClipOval(
            child: Material(
              color: Colors.purple[200], // button color
              child: InkWell(
                splashColor: Colors.green, // inkwell color
                child: SizedBox(
                  width: 40,
                  height: 40,
                  child: Icon(
                    Icons.notification_important,
                    color: Colors.amberAccent,
                    size: 40,
                  ),
                ),
                onTap: () => showDialog(
                  context: context,
                  child: _dialogBuilder(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
