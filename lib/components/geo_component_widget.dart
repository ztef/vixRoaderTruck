import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GeoComponentWidget extends StatefulWidget {
  const GeoComponentWidget({
    Key key,
    this.posit,
  }) : super(key: key);

  final String posit;

  @override
  _GeoComponentWidgetState createState() => _GeoComponentWidgetState();
}

class _GeoComponentWidgetState extends State<GeoComponentWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 100,
      decoration: BoxDecoration(
        color: Color(0xFFEEEEEE),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 15, 0),
                child: Text(
                  'Pos',
                  style: FlutterFlowTheme.of(context).bodyText1,
                ),
              ),
              Expanded(
                child: Text(
                  widget.posit,
                  style: FlutterFlowTheme.of(context).bodyText1,
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  'Velocidad',
                  style: FlutterFlowTheme.of(context).bodyText1,
                ),
                Text(
                  'Hello World',
                  style: FlutterFlowTheme.of(context).bodyText1,
                ),
              ],
            ),
          ),
          Icon(
            Icons.location_on,
            color: FlutterFlowTheme.of(context).customColor1,
            size: 30,
          ),
        ],
      ),
    );
  }
}
