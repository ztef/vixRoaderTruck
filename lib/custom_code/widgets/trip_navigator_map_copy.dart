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
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/location.dart';
import 'aux_classes.dart';
import 'map_bloc.dart';
import 'trip_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'dart:math';
import 'dart:async';

//import 'dart:math' as math;

class TripNavigatorMapCopy extends StatefulWidget {
  const TripNavigatorMapCopy({
    Key key,
    this.width,
    this.height,
    this.origin,
    this.destination,
    this.positionZero,
    this.usePositionZero,
    this.route,
    this.distance,
    this.location,
  }) : super(key: key);

  final double width;
  final double height;
  final LatLng origin;
  final LatLng destination;
  final LatLng positionZero;
  final bool usePositionZero;
  final String route;
  final double distance;
  final LatLng location;

  @override
  _TripNavigatorMapCopyState createState() => _TripNavigatorMapCopyState();
}

class _TripNavigatorMapCopyState extends State<TripNavigatorMapCopy> {
  Completer<gmaps.GoogleMapController> _controller = Completer();
  gmaps.GoogleMapController googleMapController;

  Map<gmaps.MarkerId, gmaps.Marker> markers = <gmaps.MarkerId, gmaps.Marker>{};
  PolylinePoints polylinePoints = PolylinePoints();
  Map<gmaps.PolylineId, gmaps.Polyline> polylines = {};
  List<gmaps.LatLng> polylineCoordinates = [];

  double totalDistance = 0.0;
  String distancia = "0";
  double _tilt = 45;
  bool _bearing = true;

  gmaps.LatLngBounds bounds;
  gmaps.LatLng _origin;
  LocationData currentLocation;
  var speed = 0;
  double p = 0.0;

  bool _isMapLoaded = false;

  @override
  void initState() {
    super.initState();
    _defineOrigin();
    _getRoute();
    _setMarkers();
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

    googleMapController = await _controller.future;

    location.onLocationChanged.listen(
      (newLoc) async {
        currentLocation = newLoc;
        p = currentLocation.speed / 100;
        _updateMarker(gmaps.MarkerId('current_pos'), newLoc);

        var actual_zoom = await googleMapController.getZoomLevel();

        if (actual_zoom < 10) {
          _bearing = false;
        } else {
          _bearing = true;
        }
        googleMapController.animateCamera(
          gmaps.CameraUpdate.newCameraPosition(
            gmaps.CameraPosition(
                target: loc2LatLng(currentLocation),
                zoom: actual_zoom,
                tilt: _tilt,
                bearing: _bearing ? currentLocation.heading : 0),
          ),
        );

        setState(() {});
      },
    );
  }

  _updatePosition(p) {
    if (_controller.isCompleted) {
      _updateMarker(gmaps.MarkerId('current_pos'), p);
      setState(() {});
      googleMapController
          .animateCamera(gmaps.CameraUpdate.newLatLng(loc2LatLng(p)));
    }
  }

  _zoomLevel(double _zoom) {
    if (_controller.isCompleted) {
      if (_zoom == 0.0) {
        gmaps.CameraUpdate u = gmaps.CameraUpdate.newLatLngBounds(bounds, 50);
        googleMapController.animateCamera(u);
      } else {
        googleMapController.animateCamera(
          gmaps.CameraUpdate.newCameraPosition(
            gmaps.CameraPosition(
                target: loc2LatLng(currentLocation),
                zoom: _zoom,
                tilt: _tilt,
                bearing: _bearing ? currentLocation.heading : 0),
          ),
        );
      }
    }
  }

  _tiltLevel(tilt) async {
    setState(() {
      _tilt = tilt;
    });
    if (_controller.isCompleted) {
      var actual_zoom = await googleMapController.getZoomLevel();
      googleMapController.animateCamera(
        gmaps.CameraUpdate.newCameraPosition(
          gmaps.CameraPosition(
              target: loc2LatLng(currentLocation),
              zoom: actual_zoom,
              tilt: _tilt,
              bearing: _bearing ? currentLocation.heading : 0),
        ),
      );
    }
  }

  loc2LatLng(loc) {
    return gmaps.LatLng(loc.latitude, loc.longitude);
  }

  void _defineOrigin() {
    if (widget.usePositionZero == true) {
      _origin = gmaps.LatLng(
          widget.positionZero.latitude, widget.positionZero.longitude);
    } else {
      _origin = gmaps.LatLng(widget.origin.latitude, widget.origin.longitude);
    }
  }

  void _setMarkers() {
    // Setea los Markers
    _setCurrentPosMarker();
    _setOriginMarker();
    _setDestinationMarker();

    // Calcula los bounds para que se vean todos los markers
    bounds = _boundsFromMarkers(markers);
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
      position: loc2LatLng(widget.location),
      infoWindow: gmaps.InfoWindow(
        title: 'Tu Posición Actual',
      ),
    );
    markers[gmaps.MarkerId('current_pos')] = marker;
  }

  _setDestinationMarker() {
    final marker = gmaps.Marker(
      markerId: gmaps.MarkerId('dest_pos'),
      position: loc2LatLng(widget.destination),
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

  _getRoute() {
    List<PointLatLng> result = polylinePoints.decodePolyline(widget.route);

    if (result.isNotEmpty) {
      result.forEach((PointLatLng point) {
        polylineCoordinates.add(gmaps.LatLng(point.latitude, point.longitude));
      });
      _setPolyLine();
    }
  }

  _setPolyLine() {
    polylines = {};
    gmaps.PolylineId id = gmaps.PolylineId("poly");
    gmaps.Polyline polyline = gmaps.Polyline(
        polylineId: id,
        color: Colors.red,
        points: polylineCoordinates,
        width: 3);

    polylines[id] = polyline;
  }

  @override
  Widget build(BuildContext context) {
    /*if (currentLocation == null) {
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
    */
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(
          "Pos: [Lat:${currentLocation.latitude} Long:${currentLocation.longitude}] Vel:${currentLocation.speed}",
          style: TextStyle(
            fontFamily: 'Lexend Deca',
            color: Colors.black,
            fontSize: 11,
            fontWeight: FontWeight.normal,
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Container(
            height: 10,
            width: 300,
            child: LinearProgressIndicator(
              value: p, // percent filled
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.orange),
              backgroundColor: const Color(0xFFFFDAB8),
            ),
          ),
        ),
        Text('Total a recorrer : ${widget.distance.round()} Km'),
        BlocListener(
          bloc: MapBlocContainer.getZoomCubit(),
          listener: (context, state) {
            _zoomLevel(state);
          },
          child: Container(),
        ),
        BlocListener(
          bloc: MapBlocContainer.getTiltCubit(),
          listener: (context, state) {
            _tiltLevel(state);
          },
          child: Container(),
        ),
        BlocListener(
          bloc: TripBlocContainer.getPositionCubit(),
          listener: (context, state) {
            _updatePosition(state);
          },
          child: Container(),
        ),
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
                      target: loc2LatLng(widget.location),
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
                    googleMapController = mapController;
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
