// Automatic FlutterFlow imports
import '../../backend/backend.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '../../flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
import 'dart:convert';

Future setEnd(BuildContext context) async {
  String tripID = FFAppState().tripStatus['activeTripID'];

  FFAppState().tripStatus = {
    'activeTripID': tripID,
    'status': 'ended',
    'reason': '',
    'desc': ''
  };

  Future<DocumentSnapshot> ff = FFAppState().activeTrip.get();
  ff.then((DocumentSnapshot value) {
    var d = value.get('log');

    List<dynamic> log = [];
    log = jsonListParser(d);

    log.insert(0, {
      'time': DateTime.now().toString(),
      'status': 'ended',
      'reason': '',
      'desc': ''
    });

    FFAppState().activeTrip.update({
      'onRoute': false,
      'log': jsonEncode(log),
      'lastStatus': jsonEncode(FFAppState().tripStatus)
    });

    FFAppState().onRoute = false;
    FFAppState().onTrip = false;
  });
}
