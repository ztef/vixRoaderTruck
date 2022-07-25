import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../trip_detail/trip_detail_widget.dart';
import '../flutter_flow/custom_functions.dart' as functions;
import '../flutter_flow/random_data_util.dart' as random_data;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TripSetLocationWidget extends StatefulWidget {
  const TripSetLocationWidget({
    Key key,
    this.location,
  }) : super(key: key);

  final FFPlace location;

  @override
  _TripSetLocationWidgetState createState() => _TripSetLocationWidgetState();
}

class _TripSetLocationWidgetState extends State<TripSetLocationWidget> {
  TripsRecord newlyCreatedTrip;
  LatLng currentUserLocationValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 280,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
        boxShadow: [
          BoxShadow(
            blurRadius: 5,
            color: Color(0x3B1D2429),
            offset: Offset(0, -3),
          )
        ],
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(0),
          bottomRight: Radius.circular(0),
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              widget.location.city,
              style: FlutterFlowTheme.of(context).subtitle1,
            ),
            Text(
              widget.location.address,
              style: FlutterFlowTheme.of(context).bodyText1,
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
                  destination: widget.location.name,
                  date: functions.ahora(),
                  uid: currentUserUid,
                  customer: '',
                  load: '',
                  unit: '',
                  shareWith: currentUserDocument?.shareTripsWith,
                  active: false,
                  status: 'new',
                  position: currentUserLocationValue,
                  positionDest: widget.location.latLng,
                  onRoute: false,
                );
                var tripsRecordReference = TripsRecord.collection.doc();
                await tripsRecordReference.set(tripsCreateData);
                newlyCreatedTrip = TripsRecord.getDocumentFromData(
                    tripsCreateData, tripsRecordReference);
                setState(
                    () => FFAppState().activeTrip = newlyCreatedTrip.reference);
                setState(() =>
                    FFAppState().selectedTrip = newlyCreatedTrip.reference);
                setState(() => FFAppState().tripLog = []);

                final usersUpdateData = createUsersRecordData(
                  onTrip: true,
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
              text: 'Seleccionar',
              options: FFButtonOptions(
                width: double.infinity,
                height: 60,
                color: FlutterFlowTheme.of(context).primaryColor,
                textStyle: FlutterFlowTheme.of(context).subtitle2.override(
                      fontFamily: 'Lexend Deca',
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
                borderSide: BorderSide(
                  color: Colors.transparent,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(40),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
              child: FFButtonWidget(
                onPressed: () async {
                  Navigator.pop(context);
                },
                text: 'Cancelar',
                options: FFButtonOptions(
                  width: double.infinity,
                  height: 60,
                  color: FlutterFlowTheme.of(context).primaryBackground,
                  textStyle: FlutterFlowTheme.of(context).subtitle2,
                  borderSide: BorderSide(
                    color: Colors.transparent,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(40),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
