import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GeoDataWidget extends StatefulWidget {
  const GeoDataWidget({Key key}) : super(key: key);

  @override
  _GeoDataWidgetState createState() => _GeoDataWidgetState();
}

class _GeoDataWidgetState extends State<GeoDataWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 30,
      decoration: BoxDecoration(
        color: Color(0xFFEEEEEE),
      ),
      child: Text(
        functions.verboseGeodata(FFAppState().currentGeoData),
        style: FlutterFlowTheme.of(context).bodyText1,
      ),
    );
  }
}
