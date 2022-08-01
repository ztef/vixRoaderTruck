import '../backend/backend.dart';
import '../flutter_flow/flutter_flow_animations.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../custom_code/widgets/index.dart' as custom_widgets;
import '../flutter_flow/custom_functions.dart' as functions;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';

class CurrentTripWidget extends StatefulWidget {
  const CurrentTripWidget({
    Key key,
    this.trip,
  }) : super(key: key);

  final DocumentReference trip;

  @override
  _CurrentTripWidgetState createState() => _CurrentTripWidgetState();
}

class _CurrentTripWidgetState extends State<CurrentTripWidget>
    with TickerProviderStateMixin {
  final animationsMap = {
    'containerOnPageLoadAnimation': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      duration: 600,
      hideBeforeAnimating: false,
      fadeIn: true,
      initialState: AnimationState(
        offset: Offset(0, 50),
        scale: 1,
        opacity: 0,
      ),
      finalState: AnimationState(
        offset: Offset(0, 0),
        scale: 1,
        opacity: 1,
      ),
    ),
    'progressBarOnPageLoadAnimation': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      duration: 600,
      hideBeforeAnimating: false,
      fadeIn: true,
      initialState: AnimationState(
        offset: Offset(0, 0),
        scale: 0.4,
        opacity: 0,
      ),
      finalState: AnimationState(
        offset: Offset(0, 0),
        scale: 1,
        opacity: 1,
      ),
    ),
  };

  @override
  void initState() {
    super.initState();
    startPageLoadAnimations(
      animationsMap.values
          .where((anim) => anim.trigger == AnimationTrigger.onPageLoad),
      this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(3, 0, 3, 12),
      child: StreamBuilder<TripsRecord>(
        stream: TripsRecord.getDocument(widget.trip),
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
          final dashboardProgressCardTripsRecord = snapshot.data;
          return Container(
            width: double.infinity,
            height: 170,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).secondaryBackground,
              boxShadow: [
                BoxShadow(
                  blurRadius: 5,
                  color: Color(0x44111417),
                  offset: Offset(0, 2),
                )
              ],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(15, 10, 15, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 12, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    dateTimeFormat('d/M/y',
                                        dashboardProgressCardTripsRecord.date),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyText2
                                        .override(
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w500,
                                        ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        5, 0, 0, 0),
                                    child: Text(
                                      dateTimeFormat(
                                          'jm',
                                          dashboardProgressCardTripsRecord
                                              .date),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w500,
                                          ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        5, 0, 0, 0),
                                    child: FaIcon(
                                      FontAwesomeIcons.history,
                                      color: Colors.black,
                                      size: 24,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        5, 0, 0, 0),
                                    child: Container(
                                      width: 80,
                                      height: 24,
                                      child: custom_widgets.ElapsedTime(
                                        width: 80,
                                        height: 24,
                                        fecha: dashboardProgressCardTripsRecord
                                            .date,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                dashboardProgressCardTripsRecord.destination,
                                style: FlutterFlowTheme.of(context).title3,
                              ),
                              Container(
                                width: 200,
                                height: 33,
                                child: custom_widgets.GetVerboseStatus(
                                  width: 200,
                                  height: 33,
                                  status: valueOrDefault<String>(
                                    dashboardProgressCardTripsRecord.lastStatus,
                                    'Sin Estatus',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      CircularPercentIndicator(
                        percent: 0.45,
                        radius: 35,
                        lineWidth: 8,
                        animation: true,
                        progressColor:
                            FlutterFlowTheme.of(context).primaryColor,
                        backgroundColor:
                            FlutterFlowTheme.of(context).primaryBackground,
                        center: Text(
                          '45%',
                          style: FlutterFlowTheme.of(context)
                              .bodyText1
                              .override(
                                fontFamily: 'Poppins',
                                color: FlutterFlowTheme.of(context).primaryText,
                              ),
                        ),
                      ).animated(
                          [animationsMap['progressBarOnPageLoadAnimation']]),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                  child: Container(
                    width: 300,
                    height: 40,
                    child: custom_widgets.TripTimer(
                      width: 300,
                      height: 40,
                      log: functions
                          .jsonListParser(dashboardProgressCardTripsRecord.log)
                          .toList(),
                    ),
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [],
                ),
              ],
            ),
          ).animated([animationsMap['containerOnPageLoadAnimation']]);
        },
      ),
    );
  }
}
