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
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_beep/flutter_beep.dart';
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

class PositionInformer {
  static void inform(_appState, _locationData) {
    if (_appState.tripStatus['activeTripID'] != "0") {
      _appState.activeTrip.update({
        'position': GeoPoint(_locationData.latitude, _locationData.longitude),
        //'lat': _locationData.latitude,
        //'long': _locationData.longitude,
        'speed': _locationData.speed,
        'positionTime': DateTime.now(),
      });
    }
  }
}

class DeviceLocation {
  static Location location;

  static Location getLocation() {
    if (location == null) {
      location = Location();
    }
    return location;
  }
}

class SpeedMonitor {
  //pt = pausedTrip
  static DateTime dtref;
  static Duration elapsed;
  static bool dtFlag = false;
  static DateTime dtnow;
  static bool firePause = false;

  static Widget printSpeed(rt, pt, context, v, p) {
    if (pt) {
      dtFlag = false;
      if (v > 10) {
        // Pone en RUTA automatica
        _setAutoRoute();
        _showSpeedDialog(context);
      }
    }
    if (rt) {
      if (v < 3) {
        if (!dtFlag) {
          dtref = DateTime.now();
          dtFlag = true;
          firePause = false;
        } else {
          dtnow = DateTime.now();
          elapsed = dtnow.difference(dtref);
          if (elapsed.inMinutes > 5) {
            firePause = true;
            _setAutoPause();
            _showPauseDialog(context);
            firePause = false;
            dtFlag = false;
          }
        }
      }
    }

    return Row(children: [
      //Text(firePause.toString()),
      ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Container(
          height: 10,
          width: 300,
          child: LinearProgressIndicator(
            value: p, //Porcentaje
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.orange),
            backgroundColor: const Color(0xFFFFDAB8),
          ),
        ),
      ),
      Text(v.toString()),
      const Text('km/h'),
    ]);
  }

  static _setAutoRoute() {
    String tripID = FFAppState().tripStatus['activeTripID'];

    FFAppState().tripStatus = {
      'activeTripID': tripID,
      'status': 'route',
      'reason': '',
      'desc': 'Mov detectado'
    };

    FFAppState().onRoute = true;
    Future<DocumentSnapshot> ff = FFAppState().activeTrip.get();
    ff.then((DocumentSnapshot value) {
      var d = value.get('log');

      List<dynamic> log = [];
      log = jsonListParser(d);

      log.insert(0, {
        'time': DateTime.now().toString(),
        'status': 'route',
        'reason': '',
        'desc': 'Mov detectado'
      });

      FFAppState().activeTrip.update({
        'onRoute': true,
        'log': jsonEncode(log),
        'lastStatus': jsonEncode(FFAppState().tripStatus)
      });

      FFAppState().onRoute = true;
    });
  }

  static _setAutoPause() {
    String tripID = FFAppState().tripStatus['activeTripID'];

    FFAppState().tripStatus = {
      'activeTripID': tripID,
      'status': 'paused',
      'reason': 'auto',
      'desc': 'Pausa detectada'
    };

    FFAppState().onRoute = false;
    Future<DocumentSnapshot> ff = FFAppState().activeTrip.get();
    ff.then((DocumentSnapshot value) {
      var d = value.get('log');

      List<dynamic> log = [];
      log = jsonListParser(d);

      log.insert(0, {
        'time': DateTime.now().toString(),
        'status': 'paused',
        'reason': 'auto',
        'desc': 'Pausa detectada'
      });

      FFAppState().activeTrip.update({
        'onRoute': false,
        'log': jsonEncode(log),
        'lastStatus': jsonEncode(FFAppState().tripStatus)
      });

      FFAppState().onRoute = false;
    });
  }

  static _showSpeedDialog(context) {
    FlutterBeep.playSysSound(41);
    Fluttertoast.showToast(
        msg: "Moviminto detctado, en RUTA Automática",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static _showPauseDialog(context) {
    FlutterBeep.playSysSound(41);
    Fluttertoast.showToast(
        msg: "Moviminto no detctado, en PAUSA Automática",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
