// Automatic FlutterFlow imports
import '../../backend/backend.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '../actions/index.dart'; // Imports custom actions
import '../../flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
import 'package:google_maps_flutter/google_maps_flutter.dart' as gmaps;
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_polyline_algorithm/google_polyline_algorithm.dart';
import 'package:location/location.dart';
import 'aux_classes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'dart:math';
import 'dart:async';

//import 'dart:math' as math;

class PreViewTripMap extends StatefulWidget {
  const PreViewTripMap({
    Key key,
    this.width,
    this.height,
    this.origin,
    this.destination,
    this.origenActual,
  }) : super(key: key);

  final double width;
  final double height;
  final FFPlace origin;
  final FFPlace destination;
  final bool origenActual;

  @override
  _PreViewTripMapState createState() => _PreViewTripMapState();
}

class _PreViewTripMapState extends State<PreViewTripMap> {
  Completer<gmaps.GoogleMapController> _controller = Completer();

  Map<gmaps.MarkerId, gmaps.Marker> markers = <gmaps.MarkerId, gmaps.Marker>{};
  PolylinePoints polylinePoints = PolylinePoints();
  Map<gmaps.PolylineId, gmaps.Polyline> polylines = {};
  List<gmaps.LatLng> polylineCoordinates = [];
  double totalDistance = 0.0;
  String distancia = "0";
  gmaps.LatLngBounds bounds;

  gmaps.LatLng _origin;
  LocationData currentLocation;

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  void getCurrentLocation() async {
    Location location = DeviceLocation.getLocation();

    location.getLocation().then(
      (location) {
        setState(() {
          currentLocation = location;
        });
      },
    );

    gmaps.GoogleMapController googleMapController = await _controller.future;
  }

  loc2LatLng(loc) {
    return gmaps.LatLng(loc.latitude, loc.longitude);
  }

  void _defineOrigin() {
    // Establece en _origin el origen correcto

    setState(() {
      distancia = "00";

      if (widget.origenActual == true) {
        distancia = "origen";
        _origin =
            gmaps.LatLng(currentLocation.latitude, currentLocation.longitude);
      } else {
        distancia = "seleccionada";
        _origin = gmaps.LatLng(
            widget.origin.latLng.latitude, widget.origin.latLng.longitude);
      }
    });
  }

  void _setMarkers() {
    // Setea los Markers
    _setCurrentPosMarker();
    _setOriginMarker();
    _setDestinationMarker();

    // Calcula los bounds para que se vean todos los markers
    bounds = _boundsFromMarkers(markers);
  }

  void _updateMap(gmaps.GoogleMapController _controller) {
    // Crea un CamaraUpdate
    gmaps.CameraUpdate u = gmaps.CameraUpdate.newLatLngBounds(bounds, 50);

    // Animate the camera to update
    //gmaps.GoogleMapController googleMapController = await _controller.future;
    _controller.animateCamera(u);

    setState(() {});
  }

  gmaps.LatLngBounds _boundsFromMarkers(
      Map<gmaps.MarkerId, gmaps.Marker> markers) {
    assert(markers.isNotEmpty);
    double x0, x1, y0, y1;
    markers.forEach((id, marker) {
      gmaps.Marker m = marker;
      if (x0 == null) {
        // Valor inicial
        x0 = x1 = m.position.latitude;
        y0 = y1 = m.position.longitude;
      } else {
        if (m.position.latitude > (x1 ?? 0)) x1 = m.position.latitude;
        if (m.position.latitude < x0) x0 = m.position.latitude;
        if (m.position.longitude > (y1 ?? 0)) y1 = m.position.longitude;
        if (m.position.longitude < (y0 ?? double.infinity))
          y0 = m.position.longitude;
      }
    });
    return gmaps.LatLngBounds(
      northeast: gmaps.LatLng(x1 ?? 0, y1 ?? 0),
      southwest: gmaps.LatLng(x0 ?? 0, y0 ?? 0),
    );
  }

  _setCurrentPosMarker() {
    final marker = gmaps.Marker(
      markerId: gmaps.MarkerId('current_pos'),
      position: loc2LatLng(currentLocation),
      infoWindow: gmaps.InfoWindow(
        title: 'Tu Posición Actual',
      ),
    );
    markers[gmaps.MarkerId('current_pos')] = marker;
  }

  _setDestinationMarker() {
    final marker = gmaps.Marker(
      markerId: gmaps.MarkerId('dest_pos'),
      position: loc2LatLng(widget.destination.latLng),
      infoWindow: gmaps.InfoWindow(
        title: 'Destino',
      ),
    );
    markers[gmaps.MarkerId('dest_pos')] = marker;
  }

  _setOriginMarker() {
    final marker = gmaps.Marker(
      markerId: gmaps.MarkerId('orig_pos'),
      position: loc2LatLng(_origin),
      infoWindow: gmaps.InfoWindow(
        title: 'Origen',
      ),
    );
    markers[gmaps.MarkerId('orig_pos')] = marker;
  }

  _updateMarker(id, loc) {
    final marker =
        markers.values.toList().firstWhere((item) => item.markerId == id);

    gmaps.Marker _marker = gmaps.Marker(
      markerId: marker.markerId,
      //onTap: () {
      //  print("tapped");
      //},
      position: loc2LatLng(loc),
      //icon: marker.icon,
      infoWindow: gmaps.InfoWindow(title: 'Tu ubicación en Tiempo Real'),
    );

    //setState(() {
    markers[id] = _marker;
    //});
  }

  _getRoute() async {
    distancia = "0";

    List<List<num>> outRoute = [];

    var result = await polylinePoints?.getRouteBetweenCoordinates(
      "AIzaSyBQNLamEhl38teT0vijHoKKTyu88-d6Ais",
      PointLatLng(_origin.latitude, _origin.longitude),
      PointLatLng(widget.destination.latLng.latitude,
          widget.destination.latLng.longitude),
      travelMode: TravelMode.driving,
    );

    distancia = result.errorMessage;

    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(gmaps.LatLng(point.latitude, point.longitude));
        outRoute.add([point.latitude, point.longitude]);
      });
      _calcDistance();
      _setPolyLine();
      _keepRoute(outRoute);
    }
  }

  _keepRoute(List<List<num>> p) {
    String s = encodePolyline(p);
    FFAppState().route = s;
  }

  _calcDistance() {
    for (int i = 0; i < polylineCoordinates.length - 1; i++) {
      totalDistance += _coordinateDistance(
        polylineCoordinates[i].latitude,
        polylineCoordinates[i].longitude,
        polylineCoordinates[i + 1].latitude,
        polylineCoordinates[i + 1].longitude,
      );
    }

    distancia = "Distancia a destino (km): " + totalDistance.round().toString();
    FFAppState().distance = totalDistance;
  }

  double _coordinateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  _setPolyLine() {
    polylines = {};
    gmaps.PolylineId id = gmaps.PolylineId("poly");
    gmaps.Polyline polyline = gmaps.Polyline(
        polylineId: id,
        color: Colors.red,
        points: polylineCoordinates,
        width: 3);

    setState(() {
      polylines[id] = polyline;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (currentLocation == null) {
      return Center(
        child: SizedBox(
          width: 50,
          height: 50,
          child: CircularProgressIndicator(
            color: FlutterFlowTheme.of(context).primaryColor,
          ),
        ),
      );
    }
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        /*
        TextButton(
          onPressed: () {
            _defineOrigin();
          },
          child: const Text("VER RUTA"),
        ),

        Text(_origin.toString()),
        */
        Text(distancia),
        Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.5,
          decoration: BoxDecoration(
            color: Color(0xFFEEEEEE),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: gmaps.GoogleMap(
                  initialCameraPosition: gmaps.CameraPosition(
                      target: loc2LatLng(currentLocation),
                      zoom: 11.0,
                      tilt: 45,
                      bearing: 0),
                  markers: markers.values.toSet(),
                  polylines: Set<gmaps.Polyline>.of(polylines.values),
                  gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
                    new Factory<OneSequenceGestureRecognizer>(
                      () => new EagerGestureRecognizer(),
                    ),
                  ].toSet(),
                  myLocationEnabled: true,
                  onMapCreated: (mapController) {
                    _controller.complete(mapController);
                    _defineOrigin();
                    _setMarkers();
                    _updateMap(mapController);
                    _getRoute();
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
