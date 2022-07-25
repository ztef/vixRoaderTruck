// Automatic FlutterFlow imports
import '../../backend/backend.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '../actions/index.dart'; // Imports custom actions
import '../../flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';

// Begin custom widget code
class TripMap extends StatefulWidget {
  const TripMap({
    Key key,
    this.width,
    this.height,
  }) : super(key: key);

  final double width;
  final double height;

  @override
  _TripMapState createState() => _TripMapState();
}

class _TripMapState extends State<TripMap> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(children: [
        Text('POS :'),
        StreamBuilder<TripsRecord>(
            stream: TripsRecord.getDocument(FFAppState().activeTrip),
            builder: (BuildContext context, snapshot) {
              if (!snapshot.hasData) {
                return (Text('NO hay Datos'));
              }
              var tripDocument = snapshot.data;
              return Text('SALIDA ${tripDocument.lastStatus}');
            }),
      ]),
    );
  }
}
