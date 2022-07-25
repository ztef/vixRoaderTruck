// Automatic FlutterFlow imports
import '../../backend/backend.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '../../flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
import 'dart:convert';

Future setRoute(BuildContext context, List<dynamic> log) async {
  String tripID = FFAppState().tripStatus['activeTripID'];

  FFAppState().tripStatus = {
    'activeTripID': tripID,
    'status': 'route',
    'reason': '',
    'desc': ''
  };

  FFAppState().onRoute = true;

  log.insert(0, {
    'time': DateTime.now().toString(),
    'status': 'route',
    'reason': '',
    'desc': ''
  });

  FFAppState().activeTrip.update({
    'onRoute': true,
    'log': jsonEncode(log),
    'lastStatus': jsonEncode(FFAppState().tripStatus)
  });
}
