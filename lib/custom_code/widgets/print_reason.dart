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

class PrintReason extends StatefulWidget {
  const PrintReason({
    Key key,
    this.width,
    this.height,
    this.reason,
  }) : super(key: key);

  final double width;
  final double height;
  final String reason;

  @override
  _PrintReasonState createState() => _PrintReasonState();
}

class _PrintReasonState extends State<PrintReason> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
