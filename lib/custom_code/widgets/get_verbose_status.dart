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

class GetVerboseStatus extends StatefulWidget {
  const GetVerboseStatus({
    Key key,
    this.width,
    this.height,
    this.status,
  }) : super(key: key);

  final double width;
  final double height;
  final String status;

  @override
  _GetVerboseStatusState createState() => _GetVerboseStatusState();
}

class _GetVerboseStatusState extends State<GetVerboseStatus> {
  @override
  Widget build(BuildContext context) {
    var o = json.decode(widget.status);
    if (o['status'] == 'paused') {
      var d = o['desc'];
      return Text('En Pausa : $d');
    } else if (o['status'] == 'route') {
      return const Text('En Ruta');
    }
    return Container();
  }
}
