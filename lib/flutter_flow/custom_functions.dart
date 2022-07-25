import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import '../backend/backend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../auth/auth_util.dart';

DateTime ahora() {
  // Add your function code here!
  return DateTime.now();
}

dynamic setActiveTrip(String activeTripID) {
  return ({'activeTripID': activeTripID});
}

dynamic clearActiveTrip() {
  return ({'activeTripID': 0});
}

bool isActiveTripID(
  TripsRecord currentTrip,
  String activeID,
) {
  return currentTrip.tripId == activeID;
}

DocumentReference getNullTrip() {
  DocumentReference trip_nulo;

  return trip_nulo;
}

String verboseStatus(dynamic status) {
  String _out = 'No estas en Viaje';
  if (status['activeTripID'] != '0') {
    if (status['status'] == 'paused') {
      _out = 'En Pausa';
    }
    if (status['status'] == 'route') {
      _out = 'En Ruta';
    }
    return _out;
  }
  return _out;
}

String verboseStringStatus(String status) {
  String _out = '';

  if (status == 'paused') {
    _out = 'En Pausa';
  }
  if (status == 'route') {
    _out = 'En Ruta';
  }
  return _out;
}

String nextStatusText(dynamic status) {
  String _out = 'Iniciar un Viaje';
  if (status['activeTripID'] != '0') {
    if (status['status'] == 'paused') {
      _out = 'Poner en Ruta';
    }
    if (status['status'] == 'route') {
      _out = 'Pausar Viaje';
    }
  }
  return _out;
}

bool isActiveTrip(dynamic status) {
  return status['activeTripID'] != '0';
}

String verboseDetail(dynamic statusRecord) {
  String _out = '';
  if (statusRecord['status'] == 'paused') {
    _out = 'En Pausa';
  }
  if (statusRecord['status'] == 'route') {
    _out = 'En Ruta';
  }
  return _out;
}

bool isTripPaused(dynamic tripStatus) {
  return tripStatus['status'] == 'paused';
}

String verboseReason(
  String reason,
  dynamic options,
) {
  //Map<String, dynamic> user = jsonDecode(options);

  return "";
}

String packLog(List<dynamic> log) {
  return log.toString();
}

String getLat(LatLng pos) {
  return pos.latitude.toString();
}

String getLong(LatLng pos) {
  return pos.longitude.toString();
}

dynamic prubeba() {
  String x = "xxxx";
  return {'campo': x};
}

String verboseGeodata(String geodata) {
  return geodata;
}

List<dynamic> jsonListParser(String oo) {
  List<dynamic> salida = [];

  String ss;
  ss = oo.replaceAllMapped(RegExp(r'\[|]'), (m) => "");
  ss = ss.replaceAllMapped(RegExp(",(?={)"), (m) => "\$");
  ss = ss.replaceAll("null", '""');
  List registros = ss.split("\$"); // Primer Split {}
  registros.forEach((element) {
    element = element.replaceAllMapped(RegExp(r'{|}'), (m) => "");
    element = element.replaceAllMapped(RegExp(',(?=")'), (m) => "\$");
    List campos = element.split("\$");

    Map registro = {};

    campos.forEach((element) {
      List k_v = element.split(RegExp(r':(?=")'));
      String k = k_v[0];
      String v = k_v[1];
      k = k.replaceAllMapped(RegExp('"|{'), (m) => "");
      v = v.replaceAll('"', '');

      registro[k] = v;
    });

    salida.add(registro);
  });

  return salida;
}

DateTime string2Date(String stringDate) {
  return DateTime.parse(stringDate);
}
