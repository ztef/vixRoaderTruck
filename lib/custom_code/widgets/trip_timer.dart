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

class TripTimer extends StatefulWidget {
  const TripTimer({
    Key key,
    this.width,
    this.height,
    this.log,
  }) : super(key: key);

  final double width;
  final double height;
  final List<dynamic> log;

  @override
  _TripTimerState createState() => _TripTimerState();
}

class _TripTimerState extends State<TripTimer> {
  Trip thisTrip;

  @override
  void initState() {
    super.initState();
    thisTrip =
        Trip(widget.log); // Crea un Objeto TRIP a aprtir del LOG de eventos
  }

  /*
 thisTrip._subscribe((v) {return Text('${v.elapsedTime}');})
 */

  @override
  Widget build(BuildContext context) {
    return // Generated code for this ContainerTime Widget...
        Padding(
      padding: EdgeInsetsDirectional.fromSTEB(3, 3, 9, 3),
      child: Material(
        color: Colors.transparent,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Container(
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
            color: Color(0xFFD2D2D2),
            boxShadow: [
              BoxShadow(
                color: Colors.white,
              )
            ],
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: Colors.white,
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(10, 5, 10, 5),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 100,
                        height: 50,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFF0000),
                          borderRadius: BorderRadius.circular(8),
                          shape: BoxShape.rectangle,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(5, 5, 0, 0),
                              child: thisTrip._subscribe((v) {
                                return Text(
                                  '${v.pauseTime}',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyText1
                                      .override(
                                        fontFamily: 'Poppins',
                                        color:
                                            FlutterFlowTheme.of(context).white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.normal,
                                      ),
                                );
                              }),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                        child: Icon(
                          Icons.timer,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      Container(
                        width: 100,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(8),
                          shape: BoxShape.rectangle,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(5, 5, 0, 0),
                              child: thisTrip._subscribe((v) {
                                return Text(
                                  '${v.driveTime}',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyText1
                                      .override(
                                        fontFamily: 'Poppins',
                                        color:
                                            FlutterFlowTheme.of(context).white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.normal,
                                      ),
                                );
                              }),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SimpleTimes {
  String pauseTime = "00:00:00";
  String driveTime = "00:00:00";
  String elapsedTime = "00:00:00";
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
  String currentStateType = 'paused';

  Timer tripTimer;

  ValueNotifier<SimpleTimes> tripNotifier =
      ValueNotifier<SimpleTimes>(SimpleTimes());

  Trip(List log) {
    tripLog = log;
    snapTime = DateTime.now();
    _parseLog();
    lastStateType = tripLog.first['status'];
    currentStateType = lastStateType;

    //tripTimes = TripTimes();

    // Esto debe arreglarse en la clase
    acumTimes.driveTime = const Duration(seconds: 0);
    acumTimes.pauseTime = const Duration(seconds: 0);
    totalTimes.driveTime = tripTimes.driveTime;
    totalTimes.pauseTime = tripTimes.pauseTime;
    outTimes.driveTime = timeFormat(totalTimes.driveTime);
    outTimes.pauseTime = timeFormat(totalTimes.pauseTime);

    tripTimer =
        Timer.periodic(const Duration(seconds: 1), (timer) => _updateTrip());
  }

  // Formatea Duration como hh:mm:ss
  timeFormat(Duration d) => d.toString().split('.').first.padLeft(8, "0");

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
    currentStateType = FFAppState().tripStatus['status'];
    _acumTimes(currentStateType);
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

    outTimes.driveTime = timeFormat(totalTimes.driveTime);
    outTimes.pauseTime = timeFormat(totalTimes.pauseTime);
    outTimes.elapsedTime = timeFormat(_getXTime());

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
