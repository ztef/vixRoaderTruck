import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../custom_code/widgets/index.dart' as custom_widgets;
import '../flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TripLogViewWidget extends StatefulWidget {
  const TripLogViewWidget({Key key}) : super(key: key);

  @override
  _TripLogViewWidgetState createState() => _TripLogViewWidgetState();
}

class _TripLogViewWidgetState extends State<TripLogViewWidget> {
  @override
  Widget build(BuildContext context) {
    return AuthUserStreamWidget(
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
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(7, 0, 7, 0),
                child: Container(
                  width: double.infinity,
                  height: 30,
                  decoration: BoxDecoration(),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(10, 10, 0, 0),
                    child: Text(
                      'Bitácora:',
                      textAlign: TextAlign.start,
                      style: FlutterFlowTheme.of(context).bodyText1.override(
                            fontFamily: 'Poppins',
                            color: Colors.black,
                          ),
                    ),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                height: 300,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                ),
                child: Builder(
                  builder: (context) {
                    final lista = functions
                        .jsonListParser(columnTripsRecord.log)
                        .map((e) => getJsonField(
                              e,
                              r'''$''',
                            ))
                        .toList();
                    return ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: lista.length,
                      itemBuilder: (context, listaIndex) {
                        final listaItem = lista[listaIndex];
                        return Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(7, 0, 7, 0),
                          child: Card(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            color: Color(0xFFFCFCFC),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  dateTimeFormat(
                                      'd/M/y',
                                      functions.string2Date(getJsonField(
                                        listaItem,
                                        r'''$.time''',
                                      ).toString())),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyText1
                                      .override(
                                        fontFamily: 'Poppins',
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal,
                                      ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10, 0, 0, 0),
                                  child: Text(
                                    dateTimeFormat(
                                        'jm',
                                        functions.string2Date(getJsonField(
                                          listaItem,
                                          r'''$.time''',
                                        ).toString())),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: 'Poppins',
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal,
                                        ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10, 0, 0, 0),
                                  child: Container(
                                    width: 25,
                                    height: 25,
                                    child: custom_widgets.GetPauseIcon(
                                      width: 25,
                                      height: 25,
                                      reason: getJsonField(
                                        listaItem,
                                        r'''$.reason''',
                                      ).toString(),
                                    ),
                                  ),
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      functions
                                          .verboseStringStatus(getJsonField(
                                        listaItem,
                                        r'''$.status''',
                                      ).toString()),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'Poppins',
                                            color: Colors.black,
                                            fontWeight: FontWeight.normal,
                                          ),
                                    ),
                                    Align(
                                      alignment: AlignmentDirectional(-0.05, 0),
                                      child: Text(
                                        getJsonField(
                                          listaItem,
                                          r'''$.desc''',
                                        ).toString(),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyText1
                                            .override(
                                              fontFamily: 'Poppins',
                                              color: Colors.black,
                                              fontWeight: FontWeight.normal,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
