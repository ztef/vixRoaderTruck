// Automatic FlutterFlow imports
import '../../backend/backend.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '../../flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code

Future updateRemoteLog() async {
  //final tripsUpdateData = createTripsRecordData(
  //   log: functions.packLog(FFAppState().tripLog.toList()),
  // );

  // await liminado para funcionar offline.
  FFAppState().activeTrip.update({'log': 'SI JALA'});
}
