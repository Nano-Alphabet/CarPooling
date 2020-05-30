import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:velocity_x/velocity_x.dart';
import 'dart:ui';

/*
  google_maps_flutter:
  geocoder: ^0.2.1
  geoflutterfire:
  geolocator: 5.1.5
*/

class LoadLocationMap extends StatefulWidget {
  final GeoPoint point;

  const LoadLocationMap({
    Key key,
    this.point,
  }) : super(key: key);
  @override
  _LoadLocationMapState createState() => _LoadLocationMapState();
}

class _LoadLocationMapState extends State<LoadLocationMap> {
  @override
  void initState() {
    super.initState();
    if (widget.point != null)
      center = LatLng(widget.point.latitude, widget.point.longitude);
    //TODO GET CURRENT LOCATION
  }

  GoogleMapController mapController;
  LatLng center = LatLng(22.528380, 75.920596);
  double zoom = 5;

  String searchAddress;
  TextEditingController conte = TextEditingController();

  List<Marker> markers = [];

  void _addMarkerFromCoord(GeoPoint point) {
    final MarkerId markerId = MarkerId(point.latitude.toString());
    LatLng _center = LatLng(point.latitude, point.longitude);

    if (_center == null) return;
    // creating a new MARKER
    final Marker marker = Marker(
      markerId: markerId,
      position: _center,
      icon: BitmapDescriptor.defaultMarker,
      infoWindow: InfoWindow(title: 'Your location'),
    );
    setState(() {
      markers.add(marker);
    });
  }

  bool isNormalMap = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          GoogleMap(
            onMapCreated: (controller) {
              setState(() {
                mapController = controller;
                /* mapController.animateCamera(CameraUpdate.newCameraPosition(
                    CameraPosition(target: center, zoom: zoom)));*/
              });
            },
            compassEnabled: true,
            mapToolbarEnabled: true,
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
            buildingsEnabled: true,
            padding: EdgeInsets.only(top: 100),
            markers: Set<Marker>.of([
              Marker(
                markerId: MarkerId('my location'),
                position: center,
                //LatLng(widget.point.latitude, widget.point.longitude),
                infoWindow: InfoWindow(title: 'Location'),
                icon: BitmapDescriptor.defaultMarker,
              )
            ]),
            indoorViewEnabled: true,
            mapType: isNormalMap ? MapType.normal : MapType.hybrid,
            onCameraMoveStarted: () {
              setState(() {
                markers = [];
              });
            },
            onCameraMove: (camPos) {
              setState(() {
                center = camPos.target;
              });
            },
            initialCameraPosition: CameraPosition(
              target: center,
              zoom: zoom,
            ),
          ),
          Positioned(
            child: SafeArea(
              child: Container(
                clipBehavior: Clip.hardEdge,
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TextField(
                  showCursor: true,
                  controller: conte,
                  style: TextStyle(fontSize: 15),
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: 'Enter Address',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(left: 10, top: 15),
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
                    navigateToAddress();
                  },
                  onChanged: (val) {
                    setState(() {
                      searchAddress = val;
                    });
                  },
                ),
              ),
            ),
          ),
          Positioned(
            top: 100,
            left: 10,
            child: IconButton(
              icon: Icon(
                Icons.map,
                color: isNormalMap ? Colors.green : Colors.white,
              ),
              onPressed: () {
                setState(() {
                  isNormalMap = !isNormalMap;
                });
              },
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: InkWell(
              onTap: () async {
                //TODO SET location
              },
              child: Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(
                  left: 50,
                  right: 50,
                  bottom: 20,
                ),
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.lightGreen),
                child: "SAVE".text.bold.white.make(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void navigateToAddress() {
    Geocoder.local.findAddressesFromQuery(conte.text).then((val) {
      mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
          target: LatLng(
              val.first.coordinates.latitude, val.first.coordinates.longitude),
          zoom: 16)));
    });
  }
}
