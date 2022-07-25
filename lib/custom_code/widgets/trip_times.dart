// Automatic FlutterFlow imports
import '../../backend/backend.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '../actions/index.dart'; // Imports custom actions
import '../../flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
import 'dart:convert';
import 'dart:async';

class TripTimes extends StatefulWidget {
  const TripTimes({
    Key key,
    this.width,
    this.height,
    this.times,
  }) : super(key: key);

  final double width;
  final double height;
  final dynamic times;

  @override
  _TripTimesState createState() => _TripTimesState();
}

class _TripTimesState extends State<TripTimes> {
  List items;
  dynamic lastTimes;
  Timer timer;
  DateTime snap;
  String lastStateType;
  String currentStateType;

  Duration driveTime; // Tiempos Historicos (del log)
  Duration pauseTime;

  Duration adriveTime; // Tiempos Acumulados desde la creación del widget
  Duration apauseTime;

  Duration tdriveTime; // Tiempos Totales (Suma de los anteriores)
  Duration tpauseTime;

  Duration xTime; // Uso para el estado actual

  @override
  void initState() {
    super.initState();

    snap = DateTime.now(); //Hora de la foto
    //items = json.decode(widget.times);
    items = widget.times;
    lastStateType = items.first['status'];
    currentStateType = lastStateType;

    lastTimes = getAcumulatedDriveTime(items);
    driveTime = lastTimes['D'];
    pauseTime = lastTimes['P'];
    adriveTime = Duration(seconds: 0);
    apauseTime = Duration(seconds: 0);
    xTime = Duration(seconds: 0);
    tdriveTime = driveTime;
    tpauseTime = pauseTime;

    timer =
        Timer.periodic(const Duration(seconds: 1), (timer) => _refreshTime());
  }

  _refreshTime() {
    setState(() {
      Duration elapsed = DateTime.now().difference(snap);

      currentStateType = FFAppState().tripStatus['status'];

      if (currentStateType == 'route') {
        adriveTime = Duration(seconds: adriveTime.inSeconds + 1);
        tdriveTime =
            Duration(seconds: tdriveTime.inSeconds + adriveTime.inSeconds);
        xTime = adriveTime;
      }

      if (currentStateType == 'paused') {
        apauseTime = Duration(seconds: apauseTime.inSeconds + 1);
        tpauseTime =
            Duration(seconds: tpauseTime.inSeconds + apauseTime.inSeconds);
        xTime = apauseTime;
      }

      if (currentStateType != lastStateType) {
        lastStateType = currentStateType;
        snap = DateTime.now();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        Row(children: [
          const Text('=>:'),
          Text(timeFormat(xTime)),
        ]),
        Row(children: [
          const Text('D:'),
          Text(timeFormat(tdriveTime)),
          const Text('P:'),
          Text(timeFormat(tpauseTime)),
        ]),
      ]),
    );
  }
}

timeFormat(Duration d) => d.toString().split('.').first.padLeft(8, "0");

getAcumulatedDriveTime(List tripLog) {
  int i = tripLog.length - 1;

  DateTime _topTime = DateTime.now();
  DateTime _baseTime = DateTime.now();

  Duration elapsedTime = Duration(seconds: 0);

  Duration driveTime = Duration(seconds: 0);
  Duration pauseTime = Duration(seconds: 0);

  String baseAction = '';

  bool firstRecord = true;

  // Recorre eventos del Viaje en orden de Tiempo ;
  while ((i >= 0)) {
    var item = tripLog.elementAt(i);

    // Excepto el Primer Registro :
    if (firstRecord) {
      _baseTime = DateTime.parse(item['time']);
      firstRecord = false;
    } else {
      _topTime = DateTime.parse(item['time']);
      elapsedTime = _topTime.difference(_baseTime);
      if (baseAction == 'P') {
        // Acumula como Pausa
        pauseTime =
            Duration(seconds: pauseTime.inSeconds + elapsedTime.inSeconds);
      }
      if (baseAction == 'D') {
        // Acumula como Drive
        driveTime =
            Duration(seconds: driveTime.inSeconds + elapsedTime.inSeconds);
      }
      _baseTime = _topTime; // Ahora el Top es la base
    }

    if (i == (tripLog.length - 1)) {
      baseAction = 'P';
    }
    if (item['status'] == 'paused') {
      baseAction = 'P';
    }
    if (item['status'] == 'route') {
      baseAction = 'D';
    }

    i--;
  }
  // Si la ultima accion es D, acumula driveTime hasta Now()
  if (baseAction == 'D') {
    elapsedTime = DateTime.now().difference(_baseTime);
    driveTime = Duration(seconds: driveTime.inSeconds + elapsedTime.inSeconds);
  }
  // Si la ultima accion es P, acumula pauseTime hasta Now()
  if (baseAction == 'P') {
    elapsedTime = DateTime.now().difference(_baseTime);
    pauseTime = Duration(seconds: pauseTime.inSeconds + elapsedTime.inSeconds);
  }

  return {'D': driveTime, 'P': pauseTime};
}
