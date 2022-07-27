import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../components/current_trip_widget.dart';
import '../components/new_trip_button_widget.dart';
import '../components/trip_log_view_widget.dart';
import '../components/trip_options_buttons_widget.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../main_map/main_map_widget.dart';
import '../my_trips_screen/my_trips_screen_widget.dart';
import '../profile_screen/profile_screen_widget.dart';
import '../share_with_settings/share_with_settings_widget.dart';
import '../sstart_screen/sstart_screen_widget.dart';
import '../custom_code/widgets/index.dart' as custom_widgets;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class MainWidget extends StatefulWidget {
  const MainWidget({Key key}) : super(key: key);

  @override
  _MainWidgetState createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UsersRecord>(
      stream: UsersRecord.getDocument(currentUserReference),
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
        final mainUsersRecord = snapshot.data;
        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            backgroundColor: FlutterFlowTheme.of(context).primaryColor,
            automaticallyImplyLeading: true,
            title: Text(
              'vix Roader ',
              style: FlutterFlowTheme.of(context).title2.override(
                    fontFamily: 'Poppins',
                    color: Colors.white,
                    fontSize: 22,
                  ),
            ),
            actions: [],
            centerTitle: false,
            elevation: 2,
          ),
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          drawer: Drawer(
            elevation: 16,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Image.asset(
                  'assets/images/unnamed.png',
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
                Align(
                  alignment: AlignmentDirectional(-0.95, 0),
                  child: Text(
                    'vixRoaderTruck 0.3',
                    style: TextStyle(
                      color: FlutterFlowTheme.of(context).grayIcon,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyTripsScreenWidget(),
                      ),
                    );
                  },
                  child: ListTile(
                    title: Text(
                      'Mis Viajes',
                      style: FlutterFlowTheme.of(context).title3.override(
                            fontFamily: 'Poppins',
                            color: Colors.black,
                          ),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: Color(0xFF303030),
                      size: 20,
                    ),
                    tileColor: Color(0xFFF5F5F5),
                    dense: false,
                  ),
                ),
                InkWell(
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfileScreenWidget(),
                      ),
                    );
                  },
                  child: ListTile(
                    title: Text(
                      'Mis Datos',
                      style: FlutterFlowTheme.of(context).title3.override(
                            fontFamily: 'Poppins',
                            color: Colors.black,
                          ),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: Color(0xFF303030),
                      size: 20,
                    ),
                    tileColor: Color(0xFFF5F5F5),
                    dense: false,
                  ),
                ),
                InkWell(
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ShareWithSettingsWidget(),
                      ),
                    );
                  },
                  child: ListTile(
                    title: Text(
                      'Compartir Viajes',
                      style: FlutterFlowTheme.of(context).title3.override(
                            fontFamily: 'Poppins',
                            color: Colors.black,
                          ),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: Color(0xFF303030),
                      size: 20,
                    ),
                    tileColor: Color(0xFFF5F5F5),
                    dense: false,
                  ),
                ),
                Divider(),
                InkWell(
                  onTap: () async {
                    await signOut();
                    await Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SstartScreenWidget(),
                      ),
                      (r) => false,
                    );
                  },
                  child: ListTile(
                    title: Text(
                      'Salir',
                      style: FlutterFlowTheme.of(context).title3.override(
                            fontFamily: 'Poppins',
                            color: Colors.black,
                          ),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: Color(0xFF303030),
                      size: 20,
                    ),
                    tileColor: Color(0xFFF5F5F5),
                    dense: false,
                  ),
                ),
                Divider(),
                ListTile(
                  title: Text(
                    'Configuración',
                    style: FlutterFlowTheme.of(context).title3,
                  ),
                  subtitle: Text(
                    'Configuración y Privacidad',
                    style: FlutterFlowTheme.of(context).bodyText2,
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Color(0xFF303030),
                    size: 20,
                  ),
                  tileColor: Color(0xFFF5F5F5),
                  dense: false,
                ),
              ],
            ),
          ),
          body: SafeArea(
            child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(10, 5, 10, 5),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (!(mainUsersRecord.onTrip) ?? true)
                            Container(
                              width: 100,
                              height: 25,
                              decoration: BoxDecoration(
                                color: Colors.red,
                              ),
                              child: Text(
                                'Sin Viaje',
                                style: FlutterFlowTheme.of(context).bodyText1,
                              ),
                            ),
                          if (mainUsersRecord.onTrip ?? true)
                            Container(
                              width: 100,
                              height: 25,
                              decoration: BoxDecoration(
                                color:
                                    FlutterFlowTheme.of(context).customColor1,
                              ),
                              child: Text(
                                'En Viaje',
                                style: FlutterFlowTheme.of(context).bodyText1,
                              ),
                            ),
                          FlutterFlowIconButton(
                            borderColor: Colors.transparent,
                            borderRadius: 30,
                            borderWidth: 1,
                            buttonSize: 40,
                            icon: FaIcon(
                              FontAwesomeIcons.mapMarkedAlt,
                              color: FlutterFlowTheme.of(context).primaryText,
                              size: 30,
                            ),
                            onPressed: () async {
                              await Navigator.push(
                                context,
                                PageTransition(
                                  type: PageTransitionType.bottomToTop,
                                  duration: Duration(milliseconds: 300),
                                  reverseDuration: Duration(milliseconds: 300),
                                  child: MainMapWidget(),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 10),
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        child: custom_widgets.GetPos(
                          width: double.infinity,
                          height: 50,
                        ),
                      ),
                    ),
                    if (mainUsersRecord.onTrip ?? true)
                      CurrentTripWidget(
                        trip: FFAppState().activeTrip,
                      ),
                    if (!(mainUsersRecord.onTrip) ?? true)
                      NewTripButtonWidget(),
                    if (mainUsersRecord.onTrip ?? true)
                      TripOptionsButtonsWidget(),
                    if (mainUsersRecord.onTrip ?? true)
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                        child: TripLogViewWidget(),
                      ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
