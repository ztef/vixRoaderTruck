import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../main/main_widget.dart';
import '../custom_code/actions/index.dart' as actions;
import '../custom_code/widgets/index.dart' as custom_widgets;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PauseReasonSelectorWidget extends StatefulWidget {
  const PauseReasonSelectorWidget({Key key}) : super(key: key);

  @override
  _PauseReasonSelectorWidgetState createState() =>
      _PauseReasonSelectorWidgetState();
}

class _PauseReasonSelectorWidgetState extends State<PauseReasonSelectorWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
              child: Text(
                'Motivo de la Pausa',
                textAlign: TextAlign.center,
                style: FlutterFlowTheme.of(context).bodyText1.override(
                      fontFamily: 'Poppins',
                      fontSize: 18,
                    ),
              ),
            ),
          ),
          Expanded(
            child: Builder(
              builder: (context) {
                final opciones = getJsonField(
                  FFAppState().pauseOptions,
                  r'''$''',
                ).toList();
                return ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: opciones.length,
                  itemBuilder: (context, opcionesIndex) {
                    final opcionesItem = opciones[opcionesIndex];
                    return Container(
                      width: 100,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: InkWell(
                        onTap: () async {
                          await actions.setPause(
                            getJsonField(
                              opcionesItem,
                              r'''$''',
                            ),
                          );
                          Navigator.pop(context);
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              child: custom_widgets.GetPauseIcon(
                                width: 40,
                                height: 40,
                                reason: getJsonField(
                                  opcionesItem,
                                  r'''$.motivo''',
                                ).toString(),
                              ),
                            ),
                            Text(
                              getJsonField(
                                opcionesItem,
                                r'''$.desc''',
                              ).toString(),
                              style: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Poppins',
                                    color: Colors.black,
                                  ),
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
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 20),
            child: FFButtonWidget(
              onPressed: () async {
                await actions.setEnd(
                  context,
                );

                final usersUpdateData = createUsersRecordData(
                  onTrip: false,
                );
                await currentUserReference.update(usersUpdateData);
                await actions.setActiveTripID(
                  context,
                  '0',
                );
                setState(() => FFAppState().tripLog = []);
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MainWidget(),
                  ),
                );
              },
              text: 'Terminar Viaje',
              options: FFButtonOptions(
                width: double.infinity,
                height: 60,
                color: FlutterFlowTheme.of(context).customColor3,
                textStyle: FlutterFlowTheme.of(context).subtitle2.override(
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
        ],
      ),
    );
  }
}
