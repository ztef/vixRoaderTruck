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

class ElapsedTime extends StatefulWidget {
  const ElapsedTime({
    Key key,
    this.width,
    this.height,
    this.fecha,
  }) : super(key: key);

  final double width;
  final double height;
  final DateTime fecha;

  @override
  _ElapsedTimeState createState() => _ElapsedTimeState();
}

class _ElapsedTimeState extends State<ElapsedTime> {
  Timer timer;

  @override
  void initState() {
    super.initState();
    timer =
        Timer.periodic(const Duration(seconds: 1), (timer) => _refreshTime());
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _elapsedTime(widget.fecha),
      style: FlutterFlowTheme.of(context).bodyText1.override(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
          ),
    );
  }

  _refreshTime() {
    setState(() {});
  }

  _elapsedTime(time) {
    //Duration tiempo = Duration(seconds: 0);
    Duration tiempo = DateTime.now().difference(time);
    return timeFormat(tiempo);
  }

  timeFormat(Duration d) => d.toString().split('.').first.padLeft(8, "0");
}
