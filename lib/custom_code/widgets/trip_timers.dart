// Automatic FlutterFlow imports
import '../../backend/backend.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '../actions/index.dart'; // Imports custom actions
import '../../flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
import 'dart:async';

class TripTimers extends StatefulWidget {
  const TripTimers({
    Key key,
    this.width,
    this.height,
    this.tripLog,
  }) : super(key: key);

  final double width;
  final double height;
  final List<dynamic> tripLog;

  @override
  // ignore: library_private_types_in_public_api
  _TripTimersState createState() => _TripTimersState();
}

class _TripTimersState extends State<TripTimers> {
  //Trip thisTrip;

  /*@override
  void initState() {
    super.initState();
    //thisTrip =
    //    Trip(widget.tripLog); // Crea un Objeto TRIP a aprtir del LOG de eventos
  }*/

  @override
  Widget build(BuildContext context) {
    return Text('SI JALA');

    /*return Container(
      child: Column(
        children: [
          Text("Tiempo Transcurrido : ${thisTrip.totalTimes.pauseTime}"),
          thisTrip._subscribe((v) {
            return Text('${v.elapsedTime}');
          }),
          thisTrip._subscribe((v) {
            return Text('${v.pauseTime}');
          }),
        ],
      ),
    );*/
  }
}

class SimpleTimes {
  Duration pauseTime = const Duration(seconds: 0);
  Duration driveTime = const Duration(seconds: 0);
  Duration elapsedTime = const Duration(seconds: 0);
}

class TripTimes {
  Duration pauseTime = const Duration(seconds: 0);
  Duration driveTime = const Duration(seconds: 0);
  _incDrive(int inc) {
    driveTime = Duration(seconds: driveTime.inSeconds + inc);
  }

  _incPause(int inc) {
    pauseTime = Duration(seconds: pauseTime.inSeconds + inc);
  }
}

class Trip {
  DateTime snapTime = DateTime.now();
  TripTimes tripTimes = TripTimes();
  TripTimes acumTimes = TripTimes();
  TripTimes totalTimes = TripTimes();
  SimpleTimes outTimes = SimpleTimes();

  List tripLog;
  dynamic lastTimes;
  String lastStateType;
  String currentStateType;

  Timer tripTimer;

  ValueNotifier<SimpleTimes> tripNotifier =
      ValueNotifier<SimpleTimes>(SimpleTimes());

  Trip(List log) {
    tripLog = log;
    snapTime = DateTime.now();
    _parseLog();
    lastStateType = tripLog.first['status'];
    //tripTimes = TripTimes();

    // Esto debe arreglarse en la clase
    acumTimes.driveTime = const Duration(seconds: 0);
    acumTimes.pauseTime = const Duration(seconds: 0);
    totalTimes.driveTime = tripTimes.driveTime;
    totalTimes.pauseTime = tripTimes.pauseTime;
    outTimes.driveTime = totalTimes.driveTime;
    outTimes.pauseTime = totalTimes.pauseTime;

    tripTimer =
        Timer.periodic(const Duration(seconds: 1), (timer) => _updateTrip());
  }

  Widget _subscribe(Function resolve) {
    return ValueListenableBuilder<SimpleTimes>(
      builder: (BuildContext context, SimpleTimes value, Widget child) {
        return resolve(value);
      },
      valueListenable: tripNotifier,
    );
  }

  // ignore: unused_element
  _getXTime() {
    if (currentStateType == 'route') {
      return acumTimes.driveTime;
    } else {
      return acumTimes.pauseTime;
    }
  }

  _updateTrip() {
    _acumTimes('paused');
    tripNotifier.value = outTimes;
    tripNotifier.notifyListeners();
  }

  _acumTimes(String currentState) {
    currentStateType = currentState;
    // ignore: unused_local_variable
    Duration elapsed = DateTime.now().difference(snapTime);

    if (currentStateType == 'route') {
      acumTimes._incDrive(1); // Incrementa el Drive Time
      totalTimes._incDrive(1);
    }

    if (currentStateType == 'paused') {
      acumTimes._incPause(1); // Incrementa el Pause Time
      totalTimes._incPause(1);
    }

    outTimes.driveTime = totalTimes.driveTime;
    outTimes.pauseTime = totalTimes.pauseTime;
    outTimes.elapsedTime = _getXTime();

    if (currentStateType != lastStateType) {
      lastStateType = currentStateType;
      snapTime = DateTime.now();
    }
  }

  // ignore: unused_element
  _parseLog() {
    int i = tripLog.length - 1;

    DateTime _topTime = DateTime.now();
    DateTime _baseTime = DateTime.now();

    Duration elapsedTime = const Duration(seconds: 0);

    Duration driveTime = const Duration(seconds: 0);
    Duration pauseTime = const Duration(seconds: 0);

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
      driveTime =
          Duration(seconds: driveTime.inSeconds + elapsedTime.inSeconds);
    }
    // Si la ultima accion es P, acumula pauseTime hasta Now()
    if (baseAction == 'P') {
      elapsedTime = DateTime.now().difference(_baseTime);
      pauseTime =
          Duration(seconds: pauseTime.inSeconds + elapsedTime.inSeconds);
    }

    tripTimes.pauseTime = pauseTime;
    tripTimes.driveTime = driveTime;
  }
}
