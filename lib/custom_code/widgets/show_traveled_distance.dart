// Automatic FlutterFlow imports
import '../../backend/backend.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '../actions/index.dart'; // Imports custom actions
import '../../flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
import 'trip_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ShowTraveledDistance extends StatefulWidget {
  const ShowTraveledDistance({
    Key key,
    this.width,
    this.height,
    this.totalDistance,
  }) : super(key: key);

  final double width;
  final double height;
  final double totalDistance;

  @override
  _ShowTraveledDistanceState createState() => _ShowTraveledDistanceState();
}

class _ShowTraveledDistanceState extends State<ShowTraveledDistance> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: TripBlocContainer.getTraveledDistanceCubit(),
      builder: (context, double state) {
        var traveled = state; // en km
        var traveledS = traveled.toStringAsFixed(2);

        double p = 0.0;
        String ps = "0.0";

        if (widget.totalDistance > 0) {
          p = traveled / widget.totalDistance;
          ps = (p * 100).toStringAsFixed(2);
          if (p >= 1) {
            p = 1;
          }
        }
        String total = widget.totalDistance.toStringAsFixed(2);
        return LinearPercentIndicator(
          width: 150.0,
          animation: false,
          animationDuration: 1000,
          lineHeight: 20.0,
          leading: Text("$traveledS km"),
          trailing: Text("$total km"),
          percent: p,
          center: Text("$ps %"),
          linearStrokeCap: LinearStrokeCap.butt,
          progressColor: Colors.green,
        );
      },
    );
  }
}
