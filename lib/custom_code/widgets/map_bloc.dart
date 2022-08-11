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
import 'package:flutter_bloc/flutter_bloc.dart';

class MapBloc extends StatefulWidget {
  const MapBloc({
    Key key,
    this.width,
    this.height,
  }) : super(key: key);

  final double width;
  final double height;

  @override
  _MapBlocState createState() => _MapBlocState();
}

class _MapBlocState extends State<MapBloc> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class ZoomLevel extends Cubit<double> {
  ZoomLevel() : super(10.0);

  void setValue(double z) {
    emit(z);
  }
}

class TiltLevel extends Cubit<double> {
  TiltLevel() : super(45.0);

  void setValue(double t) {
    emit(t);
  }
}

class MapBlocContainer {
  static ZoomLevel zoom;
  static TiltLevel tilt;

  static ZoomLevel getZoomCubit() {
    if (zoom == null) {
      zoom = ZoomLevel();
    }
    return zoom;
  }

  static TiltLevel getTiltCubit() {
    if (tilt == null) {
      tilt = TiltLevel();
    }
    return tilt;
  }
}
