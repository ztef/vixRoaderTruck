// Automatic FlutterFlow imports
import '../../backend/backend.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '../actions/index.dart'; // Imports custom actions
import '../../flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
import 'package:timer_builder/timer_builder.dart';

class TripTracker extends StatefulWidget {
  const TripTracker({
    Key key,
    this.width,
    this.height,
    this.trip,
  }) : super(key: key);

  final double width;
  final double height;
  final DocumentReference<TripsRecord> trip;

  @override
  _TripTrackerState createState() => _TripTrackerState();
}

class _TripTrackerState extends State<TripTracker> {
  @override
  Widget build(BuildContext context) {
    if (FFAppState().tripStatus['activeTripID'] != "0") {
      return _tripWidget(widget.trip);
    } else {
      return _noTripWidget();
    }
  }
}

_noTripWidget() {
  return _noTripLayout();
}

_tripWidget(DocumentReference<TripsRecord> trip) {
  return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    StreamBuilder<DocumentSnapshot<TripsRecord>>(
        stream: trip.snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Text('Leyendo Datos ...');
          }
          //final String registro = snapshot.data.get('destination');
          final registro = snapshot.data;
          return _tripLayout(registro);
        }),
  ]);
}

_tripLayout(registro) {
  return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white10,
        boxShadow: [
          BoxShadow(
            blurRadius: 3,
            color: Color(0x430F1113),
            offset: Offset(0, 1),
          )
        ],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(mainAxisSize: MainAxisSize.max, children: [
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(12, 4, 12, 4),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                child: Text(
                  'Viaje en Curso',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.blueAccent,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          width: 300,
          height: 1,
          decoration: BoxDecoration(
            color: Colors.lightBlue,
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(12, 4, 12, 4),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Icon(
                Icons.location_on_sharp,
                color: Colors.blueAccent,
                size: 20,
              ),
              Expanded(
                child: Text(
                  registro.get('destination'),
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.blueAccent,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(12, 4, 12, 4),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Icon(
                Icons.location_city,
                color: Colors.blueAccent,
                size: 20,
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                child: Text(
                  registro.get('customer'),
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.blueAccent,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(12, 4, 12, 4),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Icon(
                Icons.local_shipping,
                color: Colors.blueAccent,
                size: 20,
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                child: Text(
                  registro.get('unit'),
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.blueAccent,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(12, 4, 12, 4),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Icon(
                Icons.exit_to_app,
                color: Colors.blueAccent,
                size: 20,
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                child: Text(
                  registro.get('load'),
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.blueAccent,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
            padding: EdgeInsetsDirectional.fromSTEB(12, 4, 12, 8),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 4),
                  child: Icon(
                    Icons.calendar_today,
                    color: Colors.blueAccent,
                    size: 20,
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(4, 0, 0, 0),
                  child: Text(
                    DateFormat.yMMMd()
                        .add_jm()
                        .format(registro.get('date').toDate()),
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            )),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(12, 4, 12, 4),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Icon(
                Icons.schedule,
                color: Colors.blueAccent,
                size: 20,
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                child: Text(
                  'Tiempo total',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.blueAccent,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: AlignmentDirectional(1, 0),
                  child: TimerBuilder.periodic(Duration(seconds: 1),
                      builder: (context) {
                    return Text(
                      _elapsedTime(registro.get('date').toDate()),
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w600,
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ]));
}

_elapsedTime(time) {
  Duration tiempo = Duration(seconds: 0);
  tiempo = DateTime.now().difference(time);
  return timeFormat(tiempo);
}

// Formatea Duration como hh:mm:ss
timeFormat(Duration d) => d.toString().split('.').first.padLeft(8, "0");

_selectorButton() {}

_noTripLayout() {
  return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white10,
        boxShadow: [
          BoxShadow(
            blurRadius: 3,
            color: Color(0x430F1113),
            offset: Offset(0, 1),
          )
        ],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(12, 4, 12, 4),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                  child: Text(
                    'No Tienes Viaje en Curso',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 300,
            height: 1,
            decoration: BoxDecoration(
              color: Colors.lightBlue,
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(12, 4, 12, 4),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Text(
                    'No Tienes Viajes en Curso, Para Iniciar un Viaje presiona el botón de abajo… ',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ));
}
