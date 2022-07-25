import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../new_trip_destination/new_trip_destination_widget.dart';
import '../flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NewTripButtonWidget extends StatefulWidget {
  const NewTripButtonWidget({Key key}) : super(key: key);

  @override
  _NewTripButtonWidgetState createState() => _NewTripButtonWidgetState();
}

class _NewTripButtonWidgetState extends State<NewTripButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: !(functions.isActiveTrip(FFAppState().tripStatus)) ?? true,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(15, 0, 15, 0),
              child: FFButtonWidget(
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NewTripDestinationWidget(),
                    ),
                  );
                },
                text: 'Iniciar Viaje',
                options: FFButtonOptions(
                  width: 130,
                  height: 40,
                  color: FlutterFlowTheme.of(context).primaryColor,
                  textStyle: FlutterFlowTheme.of(context).subtitle2.override(
                        fontFamily: 'Poppins',
                        color: Colors.white,
                      ),
                  borderSide: BorderSide(
                    color: Colors.transparent,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
