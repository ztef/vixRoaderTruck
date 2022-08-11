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
import 'package:google_maps_flutter/google_maps_flutter.dart' as gmaps;
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'dart:math';

class TripBloc extends StatefulWidget {
  const TripBloc({
    Key key,
    this.width,
    this.height,
  }) : super(key: key);

  final double width;
  final double height;

  @override
  _TripBlocState createState() => _TripBlocState();
}

class _TripBlocState extends State<TripBloc> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class TraveledDistance extends Cubit<double> {
  TraveledDistance() : super(0.0);

  void setValue(double d) {
    emit(d);
  }

  void acumValue(double d) {
    emit(state + d);
  }

  void setSpeed(double speed) {}
}

class Speed extends Cubit<double> {
  Speed() : super(0.0);

  void setValue(double s) {
    emit(s);
  }
}

class GPSPoint {
  double latitude;
  double longitude;
  double heading;
  double speed;
  double altitude;
  GPSPoint(
      this.latitude, this.longitude, this.heading, this.speed, this.altitude);
}

class Position extends Cubit<GPSPoint> {
  Position() : super(GPSPoint(0.0, 0.0, 0.0, 0.0, 0.0));

  void setValue(
      double lat, double long, double head, double speed, double alt) {
    emit(GPSPoint(lat, long, head, speed, alt));
  }
}

class TripBlocContainer {
  static TraveledDistance distance;
  static Speed speed;
  static Position position;

  static TraveledDistance getTraveledDistanceCubit() {
    if (distance == null) {
      distance = TraveledDistance();
    }
    return distance;
  }

  static Speed getSpeedCubit() {
    if (speed == null) {
      speed = Speed();
    }
    return speed;
  }

  static Position getPositionCubit() {
    if (position == null) {
      position = Position();
    }
    return position;
  }
}

class RouteManager {
  static PolylinePoints polylinePoints = PolylinePoints();
  static String route = '';
  static String elapsedRoute = '';
  static List<gmaps.LatLng> polylineCoordinates = [];
  static List<gmaps.LatLng> polylineCoordinatesTraveled = [];
  static int lastPoint = 0;
  static String debugStr = 'debug, route manager 0';
  static double traveledDistance = 0.0;

  static setRoute(String r) {
    route = r;
    polylineCoordinates = _parseRoute(route);
  }

  static setElapsedRoute(r) {
    elapsedRoute = r;
    polylineCoordinatesTraveled = _parseRoute(elapsedRoute);
  }

  static List<gmaps.LatLng> getRoute() {
    return polylineCoordinates;
  }

  static List<gmaps.LatLng> getTraveledRoute() {
    return polylineCoordinatesTraveled;
  }

  static double getDistance() {
    return traveledDistance;
  }

  // logica al tener nueva posición
  static setLocation(lat, long) {
    int newPoint = closestRoutePointToLocation(lat, long);
    if (newPoint != lastPoint) {
      polylineCoordinatesTraveled = _getNPoints(polylineCoordinates, newPoint);
      lastPoint = newPoint;
    }
  }

  static String getDebugStr() {
    return debugStr;
  }

  static List<gmaps.LatLng> _parseRoute(string_route) {
    List<gmaps.LatLng> polylineCoord = [];
    List<PointLatLng> result = polylinePoints.decodePolyline(string_route);

    if (result.isNotEmpty) {
      result.forEach((PointLatLng point) {
        polylineCoord.add(gmaps.LatLng(point.latitude, point.longitude));
      });
    }
    return polylineCoord;
  }

  static int closestRoutePointToLocation(_lat, _long) {
    int closest = 0;
    double dMin = 0.0;
    int pos = 0;

    polylineCoordinates.forEach((gmaps.LatLng point) {
      var dist =
          _coordinateDistance(_lat, _long, point.latitude, point.longitude);
      if ((dist < dMin) || (pos == 0)) {
        closest = pos;
        dMin = dist;
      }
      pos++;
    });

    return closest;
  }

  static List<gmaps.LatLng> _getNPoints(List<gmaps.LatLng> poly, int points) {
    List<gmaps.LatLng> outPolyline = [];
    double distance = 0.0;

    for (int i = 0; i < points - 1; i++) {
      outPolyline.add(gmaps.LatLng(poly[i].latitude, poly[i].longitude));
      distance += _coordinateDistance(
        poly[i].latitude,
        poly[i].longitude,
        poly[i + 1].latitude,
        poly[i + 1].longitude,
      );
    }
    outPolyline
        .add(gmaps.LatLng(poly[points].latitude, poly[points].longitude));

    TripBlocContainer.getTraveledDistanceCubit().setValue(distance);

    traveledDistance = distance;

    return outPolyline;
  }

  static double _coordinateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }
}
