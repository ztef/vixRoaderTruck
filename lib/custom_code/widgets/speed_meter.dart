// Automatic FlutterFlow imports
import '../../backend/backend.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '../actions/index.dart'; // Imports custom actions
import '../../flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
import 'package:percent_indicator/percent_indicator.dart';
import 'trip_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SpeedMeter extends StatefulWidget {
  const SpeedMeter({
    Key key,
    this.width,
    this.height,
  }) : super(key: key);

  final double width;
  final double height;

  @override
  _SpeedMeterState createState() => _SpeedMeterState();
}

class _SpeedMeterState extends State<SpeedMeter> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: TripBlocContainer.getSpeedCubit(),
      builder: (context, double state) {
        int speed = state.round();
        return CircularPercentIndicator(
          percent: state / 150,
          radius: 35,
          lineWidth: 8,
          animation: false,
          progressColor: FlutterFlowTheme.of(context).primaryColor,
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          center: Text(
            '$speed km/h',
            style: FlutterFlowTheme.of(context).bodyText2.override(
                  fontFamily: 'Poppins',
                  fontSize: 10,
                ),
          ),
          startAngle: 180,
        );
      },
    );
  }
}
