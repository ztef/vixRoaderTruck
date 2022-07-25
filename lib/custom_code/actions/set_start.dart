// Automatic FlutterFlow imports
import '../../backend/backend.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '../../flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
import 'dart:convert';

Future setStart(DocumentReference trip) async {
  String tripID = FFAppState().tripStatus['activeTripID'];

  FFAppState().tripStatus = {
    'activeTripID': tripID,
    'status': 'paused',
    'reason': 'init',
    'desc': 'Viaje Iniciado'
  };

  FFAppState().tripLog.insert(0, {
    'time': DateTime.now().toString(),
    'status': 'paused',
    'reason': 'init',
    'desc': 'Viaje Iniciado'
  });

  trip.update({
    'onRoute': false,
    'log': jsonEncode(FFAppState().tripLog),
    'lastStatus': jsonEncode(FFAppState().tripStatus)
  });

  FFAppState().onRoute = false;
  FFAppState().onTrip = true;
}
