// Automatic FlutterFlow imports
import '../../backend/backend.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '../actions/index.dart'; // Imports custom actions
import '../../flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';

// Begin custom widget code
class TripStatusSelector extends StatefulWidget {
  const TripStatusSelector({Key key, this.width, this.height, this.tripStatus})
      : super(key: key);

  final double width;
  final double height;
  final dynamic tripStatus;

  @override
  _TripStatusSelectorState createState() => _TripStatusSelectorState();
}

class _TripStatusSelectorState extends State<TripStatusSelector> {
  @override
  Widget build(BuildContext context) {
    String tripID = widget.tripStatus['activeTripID'];
    String status = widget.tripStatus['status'];

    if (status == 'paused') {
      return TextButton(
        child: Text("PONER EN RUTA"),
      );
    }
    if (status == 'route') {
      return TextButton(
        child: Text("PAUSAR"),
      );
    }

    return Container();
  }
}
