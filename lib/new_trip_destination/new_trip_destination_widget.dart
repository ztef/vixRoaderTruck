import '../components/trip_set_location_widget.dart';
import '../flutter_flow/flutter_flow_google_map.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_place_picker.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../flutter_flow/place.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NewTripDestinationWidget extends StatefulWidget {
  const NewTripDestinationWidget({Key key}) : super(key: key);

  @override
  _NewTripDestinationWidgetState createState() =>
      _NewTripDestinationWidgetState();
}

class _NewTripDestinationWidgetState extends State<NewTripDestinationWidget> {
  LatLng googleMapsCenter;
  final googleMapsController = Completer<GoogleMapController>();
  var placePickerValue = FFPlace();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40),
        child: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primaryColor,
          automaticallyImplyLeading: false,
          leading: FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30,
            borderWidth: 1,
            buttonSize: 60,
            icon: Icon(
              Icons.arrow_back_rounded,
              color: Colors.white,
              size: 30,
            ),
            onPressed: () {
              print('IconButton pressed ...');
            },
          ),
          actions: [],
          elevation: 2,
        ),
      ),
      backgroundColor: Color(0xFFEFEFEF),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Stack(
              children: [
                Container(
                  height: double.infinity,
                  decoration: BoxDecoration(),
                  child: FlutterFlowGoogleMap(
                    controller: googleMapsController,
                    onCameraIdle: (latLng) => googleMapsCenter = latLng,
                    initialLocation: googleMapsCenter ??=
                        placePickerValue.latLng,
                    markerColor: GoogleMarkerColor.violet,
                    mapType: MapType.normal,
                    style: GoogleMapStyle.standard,
                    initialZoom: 14,
                    allowInteraction: true,
                    allowZoom: true,
                    showZoomControls: true,
                    showLocation: true,
                    showCompass: false,
                    showMapToolbar: true,
                    showTraffic: true,
                    centerMapOnMarkerTap: true,
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(0, -0.99),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 0),
                    child: FlutterFlowPlacePicker(
                      iOSGoogleMapsApiKey:
                          'AIzaSyCoaT8QJJn6122A_tjUKsO9Z6WweDteELc',
                      androidGoogleMapsApiKey:
                          'AIzaSyDUrho1GLpeK0eF6X94sUxSz86NK72HbUg',
                      webGoogleMapsApiKey:
                          'AIzaSyBu2GzkodpROm87tn0F2y6ESCXSMh46HEE',
                      onSelect: (place) async {
                        setState(() => placePickerValue = place);
                        (await googleMapsController.future).animateCamera(
                            CameraUpdate.newLatLng(
                                place.latLng.toGoogleMaps()));
                      },
                      defaultText: 'Selecciona tu Destino',
                      icon: Icon(
                        Icons.search,
                        color: Colors.white,
                        size: 16,
                      ),
                      buttonOptions: FFButtonOptions(
                        width: double.infinity,
                        height: 40,
                        color: FlutterFlowTheme.of(context).primaryColor,
                        textStyle:
                            FlutterFlowTheme.of(context).subtitle2.override(
                                  fontFamily: 'Poppins',
                                  color: Colors.white,
                                ),
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                if (placePickerValue.name != null &&
                    placePickerValue.name != '')
                  Align(
                    alignment: AlignmentDirectional(0.02, -0.8),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                      child: FFButtonWidget(
                        onPressed: () async {
                          await googleMapsController.future.then(
                            (c) => c.animateCamera(
                              CameraUpdate.newLatLng(
                                  placePickerValue.latLng.toGoogleMaps()),
                            ),
                          );
                        },
                        text: 'Ver en el Mapa ',
                        icon: Icon(
                          Icons.remove_red_eye,
                          size: 15,
                        ),
                        options: FFButtonOptions(
                          width: double.infinity,
                          height: 40,
                          color: FlutterFlowTheme.of(context).primaryColor,
                          textStyle:
                              FlutterFlowTheme.of(context).subtitle2.override(
                                    fontFamily: 'Poppins',
                                    color: Colors.white,
                                  ),
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          if (placePickerValue.name != null && placePickerValue.name != '')
            Align(
              alignment: AlignmentDirectional(-0.8, 0.84),
              child: Container(
                width: double.infinity,
                height: 100,
                constraints: BoxConstraints(
                  maxWidth: double.infinity,
                  maxHeight: 100,
                ),
                decoration: BoxDecoration(
                  color: Color(0xFFEEEEEE),
                  borderRadius: BorderRadius.circular(7),
                  border: Border.all(
                    color: FlutterFlowTheme.of(context).primaryColor,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            placePickerValue.name,
                            style: FlutterFlowTheme.of(context).bodyText1,
                          ),
                          Text(
                            placePickerValue.address.maybeHandleOverflow(
                              maxChars: 30,
                              replacement: '…',
                            ),
                            maxLines: 2,
                            style: FlutterFlowTheme.of(context).bodyText1,
                          ),
                          Text(
                            placePickerValue.city,
                            style: FlutterFlowTheme.of(context).bodyText1,
                          ),
                        ],
                      ),
                    ),
                    if (placePickerValue.name != null &&
                        placePickerValue.name != '')
                      Align(
                        alignment: AlignmentDirectional(0.53, -0.7),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 20, 25, 0),
                          child: FlutterFlowIconButton(
                            borderColor: Colors.transparent,
                            borderRadius: 30,
                            borderWidth: 1,
                            buttonSize: 60,
                            fillColor:
                                FlutterFlowTheme.of(context).primaryColor,
                            icon: Icon(
                              Icons.done,
                              color: FlutterFlowTheme.of(context).white,
                              size: 30,
                            ),
                            onPressed: () async {
                              await showModalBottomSheet(
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                context: context,
                                builder: (context) {
                                  return Padding(
                                    padding: MediaQuery.of(context).viewInsets,
                                    child: TripSetLocationWidget(
                                      location: placePickerValue,
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
