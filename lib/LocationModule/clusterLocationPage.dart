import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uow/models/Cluster.dart';
import 'package:uow/models/currentUser.dart';

import 'dart:async';

import 'package:uow/provider/carPoolingProvider.dart';

//---------------- NOTE NOTE NOTE ---------------
//-----------------------------------------------
//--THIS FILE IS UNDER PRODUCTION----------------
//--IT WILL BE USED FOR DISPLAYING CLUSTERS ON---
//--GOOGLE MAP-----------------------------------
//-----------------------------------------------

class ClusterLocationPage extends StatefulWidget {
  const ClusterLocationPage({
    Key key,
  }) : super(key: key);
  @override
  _ClusterLocationPageState createState() => _ClusterLocationPageState();
}

class _ClusterLocationPageState extends State<ClusterLocationPage> {
  @override
  void initState() {
    super.initState();
    _getLocation();
    _setMarkers();
  }

  GoogleMapController mapController;
  LatLng center = LatLng(22.528380, 75.920596);
  String searchAddress;
  bool isNormalMap = true;
  TextEditingController conte = TextEditingController();

  List<Marker> markers = [];

  _setMarkers() async {
    //widget.shopList.forEach((element) {
    //  _add(element);
    //});
    //TODO init markers
  }

  Future<Position> _getLocation() async {
    Position pos;
    SharedPreferences spfs = await SharedPreferences.getInstance();
    double lat = spfs.getDouble('myLat');
    double lng = spfs.getDouble('myLng');
    if (lat == null && await Geolocator().isLocationServiceEnabled()) {
      pos = await Geolocator().getCurrentPosition();
    } else {
      pos = await Geolocator().getLastKnownPosition(
          desiredAccuracy: LocationAccuracy.best,
          locationPermissionLevel: GeolocationPermission.location);
    }
    pos = Position(latitude: lat, longitude: lng);
    if (pos.latitude != null)
      setState(() {
        center = LatLng(pos.latitude, pos.longitude);
      });
    return pos;
  }

  void _add(Cluster cluster) async {
    final MarkerId markerId = MarkerId(cluster.clusterID);
    //print(address);
    LatLng center =
        LatLng(cluster.geoPoint.latitude, cluster.geoPoint.longitude);

    if (center == null) return;
    // creating a new MARKER
    final Marker marker = Marker(
      onTap: () {
        mapController.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(target: center, zoom: 16)));
      },
      markerId: markerId,
      icon: BitmapDescriptor.defaultMarker,
      position: center,
      infoWindow: InfoWindow(
          title: cluster.finalLocation,
          snippet: cluster.adminFirstName.toString(),
          onTap: () {
            //TODO Navigate to DEtails page
          }),
    );

    setState(() {
      markers.add(marker);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          GoogleMap(
            onMapCreated: (controller) async {
              setState(() {
                mapController = controller;
              });

              CurrentUser _user = Provider.of<CarPoolingProvider>(context).user;
              setState(() {
                markers.add(Marker(
                  onTap: () {
                    mapController.animateCamera(CameraUpdate.newCameraPosition(
                        CameraPosition(
                            target: LatLng(_user.lat, _user.lng), zoom: 16)));
                  },
                  markerId: MarkerId(_user.userName),
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                      BitmapDescriptor.hueBlue),
                  position: LatLng(_user.lat, _user.lng),
                  infoWindow: InfoWindow(
                    title: _user.userName,
                  ),
                ));
                mapController.animateCamera(CameraUpdate.newCameraPosition(
                    CameraPosition(
                        target: LatLng(_user.lat, _user.lng), zoom: 16)));
              });
            },
            compassEnabled: true,
            mapToolbarEnabled: true,
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
            buildingsEnabled: true,
            //padding: EdgeInsets.only(top: 50),
            markers: Set<Marker>.of(markers),
            mapType: isNormalMap ? MapType.normal : MapType.hybrid,
            onCameraMove: (camPos) {
              setState(() {
                center = camPos.target;
              });
            },

            // onTap: (latLng0) {
            //   Geocoder.local
            //       .findAddressesFromCoordinates(
            //           Coordinates(center.latitude, center.longitude))
            //       .then((val) {
            //     setState(() {
            //       searchAddress = val.first.addressLine;
            //       conte.text = val.first.addressLine;
            //     });
            //   }
            //   );
            // },
            initialCameraPosition: CameraPosition(target: center, zoom: 13),
          ),
          Positioned(
              child: IconButton(
                  icon: Icon(
                    Icons.map,
                    color: isNormalMap ? Colors.green : Colors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      isNormalMap = !isNormalMap;
                    });
                  }))
          /*Positioned(
            child: Container(
              height: 40,
              width: double.infinity,
              clipBehavior: Clip.hardEdge,
              margin: EdgeInsets.only(top: 15, left: 15, right: 15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.white),
              child: TextField(
                showCursor: true,
                controller: conte,
                style: TextStyle(fontSize: 10),
                decoration: InputDecoration(
                  hintText: 'Enter Address',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.only(left: 15, top: 15),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: navigateToAddress,
                    iconSize: 25,
                  ),
                ),
                onEditingComplete: () {
                  navigateToAddress();
                },
                onSubmitted: (val) {
                  setState(() {
                    searchAddress = val;
                  });
                },
                onChanged: (val) {
                  setState(() {
                    searchAddress = val;
                  });
                },
              ),
            ),
          ),*/
        ],
      ),
    );
  }

  void navigateToAddress() {
    Geolocator().placemarkFromAddress(conte.text).then((val) {
      mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
          target:
              LatLng(val.first.position.latitude, val.first.position.longitude),
          zoom: 14)));
    });
  }
}
