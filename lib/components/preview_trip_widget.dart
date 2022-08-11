import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../trip_detail/trip_detail_widget.dart';
import '../custom_code/widgets/index.dart' as custom_widgets;
import '../flutter_flow/custom_functions.dart' as functions;
import '../flutter_flow/random_data_util.dart' as random_data;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PreviewTripWidget extends StatefulWidget {
  const PreviewTripWidget({
    Key key,
    this.origin,
    this.destination,
    this.origenActual,
  }) : super(key: key);

  final FFPlace origin;
  final FFPlace destination;
  final bool origenActual;

  @override
  _PreviewTripWidgetState createState() => _PreviewTripWidgetState();
}

class _PreviewTripWidgetState extends State<PreviewTripWidget> {
  LatLng currentUserLocationValue;
  TripsRecord newlyCreatedTrip;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(20, 8, 20, 0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 4, 5, 0),
                child: Text(
                  'Viaje',
                  style: FlutterFlowTheme.of(context).title2,
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
            child: Container(
              width: double.infinity,
              height: 400,
              child: custom_widgets.PreViewTripMap(
                width: double.infinity,
                height: 400,
                origin: widget.origin,
                destination: widget.destination,
                origenActual: widget.origenActual,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 15, 0, 10),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                FFButtonWidget(
                  onPressed: () async {
                    Navigator.pop(context);
                  },
                  text: 'Cancelar',
                  options: FFButtonOptions(
                    width: 150,
                    height: 50,
                    color: FlutterFlowTheme.of(context).alternate,
                    textStyle: FlutterFlowTheme.of(context).subtitle2,
                    elevation: 2,
                    borderSide: BorderSide(
                      color: Colors.transparent,
                      width: 1,
                    ),
                  ),
                ),
                FFButtonWidget(
                  onPressed: () async {
                    currentUserLocationValue = await getCurrentUserLocation(
                        defaultLocation: LatLng(0.0, 0.0));

                    final tripsCreateData = createTripsRecordData(
                      tripId: random_data.randomString(
                        1,
                        10,
                        true,
                        false,
                        false,
                      ),
                      destination: widget.destination.name,
                      date: functions.ahora(),
                      uid: currentUserUid,
                      customer: '',
                      load: '',
                      unit: '',
                      shareWith: currentUserDocument?.shareTripsWith,
                      active: false,
                      status: 'new',
                      position: currentUserLocationValue,
                      positionDest: widget.destination.latLng,
                      onRoute: false,
                      positionOrig: widget.origin.latLng,
                      postitionZero: currentUserLocationValue,
                      usePositionZero: widget.origenActual,
                      route: FFAppState().route,
                      distance: FFAppState().distance,
                    );
                    var tripsRecordReference = TripsRecord.collection.doc();
                    await tripsRecordReference.set(tripsCreateData);
                    newlyCreatedTrip = TripsRecord.getDocumentFromData(
                        tripsCreateData, tripsRecordReference);
                    setState(() =>
                        FFAppState().activeTrip = newlyCreatedTrip.reference);
                    setState(() =>
                        FFAppState().selectedTrip = newlyCreatedTrip.reference);
                    setState(() => FFAppState().tripLog = []);

                    final usersUpdateData = createUsersRecordData(
                      onTrip: true,
                      trip: newlyCreatedTrip.reference,
                    );
                    await currentUserReference.update(usersUpdateData);
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TripDetailWidget(),
                      ),
                    );

                    setState(() {});
                  },
                  text: 'Continuar',
                  options: FFButtonOptions(
                    width: 150,
                    height: 50,
                    color: FlutterFlowTheme.of(context).primaryColor,
                    textStyle: FlutterFlowTheme.of(context).subtitle2.override(
                          fontFamily: 'Lexend Deca',
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                        ),
                    elevation: 2,
                    borderSide: BorderSide(
                      color: Colors.transparent,
                      width: 1,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
