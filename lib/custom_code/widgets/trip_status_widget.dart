// Automatic FlutterFlow imports
import '../../backend/backend.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '../actions/index.dart'; // Imports custom actions
import '../../flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';

// Begin custom widget code
class TripStatusWidget extends StatefulWidget {
  const TripStatusWidget({
    Key key,
    this.width,
    this.height,
    this.trip,
  }) : super(key: key);

  final double width;
  final double height;
  final TripsRecord trip;

  @override
  _TripStatusWidgetState createState() => _TripStatusWidgetState();
}

class _TripStatusWidgetState extends State<TripStatusWidget> {
  @override
  Widget build(BuildContext context) {
    String _status = '';
    Color _color = Colors.blue;

    String id = FFAppState().tripStatus['activeTripID'];
    if (widget.trip.tripId == id) {
      _status = "EN CURSO";
      _color = Colors.red;
    }

    return Text(_status,
        style: TextStyle(
          fontFamily: 'Poppins',
          color: Colors.red,
          fontWeight: FontWeight.w600,
        ));
  }
}
