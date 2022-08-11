// Automatic FlutterFlow imports
import '../../backend/backend.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '../actions/index.dart'; // Imports custom actions
import '../../flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
//import 'package:flutter_platform_alert/flutter_platform_alert.dart';

import 'package:location/location.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:convert';
import 'aux_classes.dart';
import 'trip_bloc.dart';
import 'dart:async';

class GetPos extends StatefulWidget {
  const GetPos({
    Key key,
    this.width,
    this.height,
    this.trip,
  }) : super(key: key);

  final double width;
  final double height;
  final TripsRecord trip;

  @override
  _GetPosState createState() => _GetPosState();
}

class _GetPosState extends State<GetPos> {
  Location location = DeviceLocation.getLocation();
  LocationData currentLocation;
  LocationData _refLocation;

  var d = 0.0;
  double speed = 0.0;
  bool workingFlash = false;
  String alert = "";
  Timer timer;
  IconData supervision_icon = Icons.pan_tool;
  bool supervision_timer = false;

  @override
  void initState() {
    super.initState();

    RouteManager.setRoute(widget.trip.route);
    getCurrentLocation();
    SpeedMonitor.setTripDoc(widget.trip);
    timer = Timer.periodic(
        const Duration(seconds: 1), (timer) => _speedSupervision());
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  _getDistance(a, b) {
    return Geolocator.distanceBetween(
        a.latitude, a.longitude, b.latitude, b.longitude);
  }

  void getCurrentLocation() async {
    //Location location = DeviceLocation.getLocation();

    location.getLocation().then(
      (_ldata) {
        setState(() {
          currentLocation = _ldata;
          _refLocation = _ldata;

          TripBlocContainer.getPositionCubit().setValue(
              _ldata.latitude, _ldata.longitude, _ldata.heading, 0.0, 0.0);

          RouteManager.setLocation(_ldata.latitude, _ldata.longitude);

          TripInformer.inform(widget.trip.reference, _ldata,
              RouteManager.getTraveledRoute(), RouteManager.getDistance());
        });
      },
    );

    location.onLocationChanged.listen((LocationData _ldata) {
      setState(() {
        workingFlash = !workingFlash;

        currentLocation = _ldata;
        d = _getDistance(currentLocation, _refLocation);

        speed = _ldata.speed * 3600 / 1000;
        TripBlocContainer.getPositionCubit().setValue(
            _ldata.latitude, _ldata.longitude, _ldata.heading, speed, 0.0);

        TripBlocContainer.getSpeedCubit().setValue(speed);

        RouteManager.setLocation(_ldata.latitude, _ldata.longitude);

        if (d > FFAppState().elasticity) {
          _refLocation = _ldata;

          TripBlocContainer.getTraveledDistanceCubit().setSpeed(speed);

          TripInformer.inform(widget.trip.reference, _ldata,
              RouteManager.getTraveledRoute(), RouteManager.getDistance());
        }
      });
    });
  }

  _speedSupervision() {
    SpeedMonitor.watchSpeed(widget.trip.onRoute, speed, _force);
  }

  _force(int t) {
    setState(() {
      if ((widget.trip.onRoute == true) && (t == 0)) {
        supervision_icon = Icons.speed;
        supervision_timer = false;
      }
      if ((widget.trip.onRoute == true) && (t != 0)) {
        supervision_icon = Icons.pan_tool;
        supervision_timer = true;
      }
      if ((widget.trip.onRoute == false) && (t == 0)) {
        supervision_icon = Icons.pan_tool;
        supervision_timer = false;
      }
      if ((widget.trip.onRoute == false) && (t != 0)) {
        supervision_icon = Icons.speed;
        supervision_timer = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (workingFlash) {
      return Row(
        children: [
          Icon(Icons.location_on, color: Colors.green, size: 20),
          Icon(supervision_icon, color: Colors.green, size: 15),
          supervision_timer
              ? Icon(Icons.timer, color: Colors.greenAccent, size: 15)
              : Container(),
        ],
      );
    } else {
      return Row(
        children: [
          Icon(Icons.location_on_outlined, color: Colors.green, size: 20),
          Icon(supervision_icon, color: Colors.green, size: 15),
          supervision_timer
              ? Icon(Icons.timer_sharp, color: Colors.green, size: 15)
              : Container(),
        ],
      );
    }
  }
}
