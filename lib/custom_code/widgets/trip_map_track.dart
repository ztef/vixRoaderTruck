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
import 'package:location/location.dart';
import 'aux_classes.dart';
import 'dart:async';

//import 'dart:math' as math;

class TripMapTrack extends StatefulWidget {
  const TripMapTrack({
    Key key,
    this.width,
    this.height,
  }) : super(key: key);

  final double width;
  final double height;

  @override
  _TripMapTrackState createState() => _TripMapTrackState();
}

class _TripMapTrackState extends State<TripMapTrack> {
  Completer<gmaps.GoogleMapController> _controller = Completer();

  Map<gmaps.MarkerId, gmaps.Marker> markers = <gmaps.MarkerId, gmaps.Marker>{};

  LocationData currentLocation;
  var speed = 0;
  double p = 0.0;

  @override
  void initState() {
    getCurrentLocation();
    super.initState();
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

    location.onLocationChanged.listen(
      (newLoc) async {
        currentLocation = newLoc;
        p = currentLocation.speed / 100;
        _updateMarker(gmaps.MarkerId('current_pos'), newLoc);

        var actual_zoom = await googleMapController.getZoomLevel();
        googleMapController.animateCamera(
          gmaps.CameraUpdate.newCameraPosition(
            gmaps.CameraPosition(
                target: loc2LatLng(currentLocation),
                zoom: actual_zoom,
                tilt: 45,
                bearing: currentLocation.heading),
          ),
        );

        setState(() {});
      },
    );
  }

  loc2LatLng(loc) {
    return gmaps.LatLng(loc.latitude, loc.longitude);
  }

  void _setInitialMarkers() {
    final marker = gmaps.Marker(
      markerId: gmaps.MarkerId('current_pos'),
      position: loc2LatLng(currentLocation),
      infoWindow: gmaps.InfoWindow(
        title: 'Tu Posición Actual',
        //snippet: 'address',
      ),
    );

    setState(() {
      markers[gmaps.MarkerId('current_pos')] = marker;
    });
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
        Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.5,
          decoration: BoxDecoration(
            color: Color(0xFFEEEEEE),
          ),
          child: Column(
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
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(Colors.orange),
                    backgroundColor: const Color(0xFFFFDAB8),
                  ),
                ),
              ),
              Expanded(
                child: gmaps.GoogleMap(
                  initialCameraPosition: gmaps.CameraPosition(
                      target: loc2LatLng(currentLocation),
                      zoom: 11.0,
                      tilt: 45,
                      bearing: 0),
                  markers: markers.values.toSet(),
                  myLocationEnabled: true,
                  onMapCreated: (mapController) {
                    _controller.complete(mapController);
                    _setInitialMarkers();
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
