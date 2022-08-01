import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../custom_code/widgets/index.dart' as custom_widgets;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TripNavigatorWidget extends StatefulWidget {
  const TripNavigatorWidget({Key key}) : super(key: key);

  @override
  _TripNavigatorWidgetState createState() => _TripNavigatorWidgetState();
}

class _TripNavigatorWidgetState extends State<TripNavigatorWidget> {
  LatLng currentUserLocationValue;

  @override
  void initState() {
    super.initState();
    getCurrentUserLocation(defaultLocation: LatLng(0.0, 0.0), cached: true)
        .then((loc) => setState(() => currentUserLocationValue = loc));
  }

  @override
  Widget build(BuildContext context) {
    if (currentUserLocationValue == null) {
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
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(20, 8, 20, 0),
      child: AuthUserStreamWidget(
        child: StreamBuilder<TripsRecord>(
          stream: TripsRecord.getDocument(currentUserDocument?.trip),
          builder: (context, snapshot) {
            // Customize what your widget looks like when it's loading.
            if (!snapshot.hasData) {
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
            final columnTripsRecord = snapshot.data;
            return Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 4, 5, 0),
                        child: Text(
                          'Viaje',
                          style: FlutterFlowTheme.of(context).title2,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  width: double.infinity,
                  height: 500,
                  child: custom_widgets.TripNavigatorMap(
                    width: double.infinity,
                    height: 500,
                    usePositionZero: columnTripsRecord.usePositionZero,
                    origin: columnTripsRecord.positionOrig,
                    destination: columnTripsRecord.positionDest,
                    positionZero: columnTripsRecord.postitionZero,
                    route: columnTripsRecord.route,
                    distance: columnTripsRecord.distance,
                    location: currentUserLocationValue,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
