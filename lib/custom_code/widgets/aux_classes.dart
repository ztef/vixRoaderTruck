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
import 'package:native_dialog/native_dialog.dart';
import 'package:google_polyline_algorithm/google_polyline_algorithm.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as gmaps;
import 'package:flutter/services.dart';

import 'dart:convert';

class AuxClasses extends StatefulWidget {
  const AuxClasses({
    Key key,
    this.width,
    this.height,
  }) : super(key: key);

  final double width;
  final double height;

  @override
  _AuxClassesState createState() => _AuxClassesState();
}

class _AuxClassesState extends State<AuxClasses> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class TripInformer {
  static void inform(_tripRef, _locationData, List<gmaps.LatLng> _traveledR,
      double _traveledD) {
    _tripRef.update({
      'position': GeoPoint(_locationData.latitude, _locationData.longitude),
      'speed': _locationData.speed,
      'positionTime': DateTime.now(),
      'traveledRoute': _encodePolyline(_traveledR),
      'traveledDistance': _traveledD,
    });
  }

  static String _encodePolyline(List<gmaps.LatLng> _traveledR) {
    List<List<num>> outRoute = [];

    _traveledR.forEach((gmaps.LatLng point) {
      outRoute.add([point.latitude, point.longitude]);
    });

    String s = encodePolyline(outRoute);
    return s;
  }
}

class DeviceLocation {
  static Location location;

  static Location getLocation() {
    if (location == null) {
      location = Location();
      //location.changeSettings(accuracy: LocationAccuracy.high, interval: 1000, distanceFilter: 5.0);
      location.enableBackgroundMode(enable: true);
    }
    return location;
  }
}

class SpeedMonitor {
  static int samples = 0;
  static int maxSamples = 15;
  static int maxSamplesTrip = 60;
  static int maxSamplesPause = 15;
  static dynamic lastStatus;

  static bool _isPaused = false;
  static bool _isRouted = true;

  static bool _sustainedSpeed = false;
  static bool _sustainedPause = false;
  static bool _enoughSamples = false;

  static int routeSpeed = 0;
  static int pauseSpeed = 0;

  static var _trip;

  static setTripDoc(tr) {
    _trip = tr;
  }

  static watchSpeed(tripStatus, speed, Function callBack) {
    routeSpeed = FFAppState().routeSpeed;
    maxSamplesTrip = FFAppState().routeTime * 60;
    pauseSpeed = FFAppState().pauseSpeed;
    maxSamplesPause = FFAppState().pauseTime * 60;

    callBack(samples);

    if (tripStatus == _isPaused) {
      //Si
      maxSamples = maxSamplesPause;
      // Checa si se ha mantenido velocidad sostenida
      if (speed > pauseSpeed) {
        //si
        _sustainedSpeed = true; //si
        samples = samples + 1;
      } else {
        _sustainedSpeed = false;
        samples = 0;
      }
    }
    if (tripStatus == _isRouted) {
      //
      maxSamples = maxSamplesTrip;
      // Checa si se ha parado la velocidad
      if (speed < routeSpeed) {
        _sustainedPause = true;
        samples = samples + 1;
      } else {
        _sustainedPause = false; //
        samples = 0;
      }
    }

    if (samples > maxSamples) {
      _enoughSamples = true;
    } else {
      _enoughSamples = false; //
    }

    if ((_sustainedSpeed == true) &&
        (tripStatus == _isPaused) &&
        (_enoughSamples == true)) {
      samples = 0;
      _setAutoRoute();
      _alert('R');
    }

    if ((_sustainedPause == true) &&
        (tripStatus == _isRouted) &&
        (_enoughSamples == true)) {
      _setAutoPause();
      _alert('P');
      samples = 0;
    }
  }

  static void _alert(tipo) async {
    try {
      String s = (tipo == 'P')
          ? "No se detecta movimiento, se activará una PAUSA automática. Por favor registra el motivo."
          : "Se detectó movimiento, el dispositivo se pondrá en RUTA automáticamente.";
      await NativeDialog.alert(s);
    } on PlatformException {
      // Ignore error
    }
  }

  static _setAutoRoute() {
    var d = _trip.log;
    List<dynamic> log = [];
    log = jsonListParser(d);

    var tripStatus = {
      'time': DateTime.now().toString(),
      'status': 'route',
      'reason': '',
      'desc': 'Mov Detectado'
    };

    log.insert(0, tripStatus);
    _trip.reference.update({
      'onRoute': true,
      'log': jsonEncode(log),
      'lastStatus': jsonEncode(tripStatus),
    });
  }

  static _setAutoPause() {
    var d = _trip.log;
    List<dynamic> log = [];
    log = jsonListParser(d);
    var tripStatus = {
      'time': DateTime.now().toString(),
      'status': 'paused',
      'reason': 'auto',
      'desc': 'Pausa Detectada'
    };
    log.insert(0, tripStatus);
    _trip.reference.update({
      'onRoute': false,
      'log': jsonEncode(log),
      'lastStatus': jsonEncode(tripStatus),
    });
  }
}
