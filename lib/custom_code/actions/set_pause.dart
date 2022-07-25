// Automatic FlutterFlow imports
import '../../backend/backend.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '../../flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
import 'dart:convert';

Future setPause(dynamic reason) async {
  String tripID = FFAppState().tripStatus['activeTripID'];

  FFAppState().tripStatus = {
    'activeTripID': tripID,
    'status': 'paused',
    'reason': reason['motivo'],
    'desc': reason['desc']
  };

  Future<DocumentSnapshot> ff = FFAppState().activeTrip.get();
  ff.then((DocumentSnapshot value) {
    var d = value.get('log');

    List<dynamic> log = [];
    log = jsonListParser(d);

    log.insert(0, {
      'time': DateTime.now().toString(),
      'status': 'paused',
      'reason': reason['motivo'],
      'desc': reason['desc']
    });

    FFAppState().activeTrip.update({
      'onRoute': false,
      'log': jsonEncode(log),
      'lastStatus': jsonEncode(FFAppState().tripStatus)
    });

    FFAppState().onRoute = false;
  });
}

/* List<dynamic> log = [];
  Future<DocumentSnapshot<TripsRecord>> ftripRecord = FFAppState().activeTrip.get();
  	ftripRecord.then((DocumentSnapshot<TripsRecord> value) {
    TripsRecord data = value.data();
      
    
    /*
    List<dynamic> log = [];  
    log = jsonListParser(data.log);
   
    log.insert(0, {
      'time': '',             // DateTime.now().toString(),
      'status': 'paused',
      'reason': reason['motivo'],
      'desc': reason['desc']
    });

    FFAppState().activeTrip.update({
      'onRoute': false,
      'log': jsonEncode(log),
      'lastStatus': jsonEncode(FFAppState().tripStatus)
    });
    */
  }).catchError((e) {
      String ee = e.toString();
      FFAppState().activeTrip.update({
      'error': 'Error Cachado $ee',
     });
   });
   */

//NoSuchMethodError: method not found: 'toString' on null
//Error Cachado NoSuchMethodError: method not found: 'j' (s.b.j is not a function)
