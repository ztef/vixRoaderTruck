// Automatic FlutterFlow imports
import '../../backend/backend.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '../actions/index.dart'; // Imports custom actions
import '../../flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
import 'package:location/location.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:convert';
import 'aux_classes.dart';

class GetPos extends StatefulWidget {
  const GetPos({
    Key key,
    this.width,
    this.height,
  }) : super(key: key);

  final double width;
  final double height;

  @override
  _GetPosState createState() => _GetPosState();
}

class _GetPosState extends State<GetPos> {
  Location location = DeviceLocation.getLocation();
  LocationData currentLocation;
  LocationData _refLocation;

  int elasticity = FFAppState().elasticity;
  var d = 0.0;
  var speed = 0.0;

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  _getDistance(a, b) {
    return Geolocator.distanceBetween(
        a.latitude, a.longitude, b.latitude, b.longitude);
  }

  void getCurrentLocation() async {
    Location location = DeviceLocation.getLocation();

    location.getLocation().then(
      (location) {
        setState(() {
          currentLocation = location;
          _refLocation = location;
          PositionInformer.inform(FFAppState(), currentLocation);
        });
      },
    );

    location.onLocationChanged.listen((LocationData _currentLocation) {
      setState(() {
        currentLocation = _currentLocation;
        d = _getDistance(currentLocation, _refLocation);
        if (d > elasticity) {
          _refLocation = currentLocation;
          PositionInformer.inform(FFAppState(), currentLocation);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (currentLocation == null) {
      return const Text('Esperando ...');
    }

    return _widget();
  }

  _widget() {
    var v = (currentLocation.speed * 3600 / 1000).toInt();
    var p = v / 100;
    var onPausedTrip = FFAppState().onTrip && !FFAppState().onRoute;
    var onRouteTrip = FFAppState().onTrip && FFAppState().onRoute;

    return Container(
      child: Column(children: [
        Row(children: [
          Text('Lat :'),
          Text(currentLocation.latitude.toString()),
          Text('Long :'),
          Text(currentLocation.longitude.toString()),
          Icon(Icons.location_on, color: Colors.green, size: 30),
        ]),
        SpeedMonitor.printSpeed(onRouteTrip, onPausedTrip, context, v, p),
      ]),
    );
  }
}
