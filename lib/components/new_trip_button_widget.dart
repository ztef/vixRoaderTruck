import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../set_origin_dest/set_origin_dest_widget.dart';
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
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Row(
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
                        builder: (context) => SetOriginDestWidget(),
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
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
          child: Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            color: FlutterFlowTheme.of(context).gray200,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
              child: Text(
                'Al Iniciar un nuevo viaje vixRoaderTruck recopila los datos de tu ubicación incluso cuando la App esté cerrada o no esté en uso. \n\nSi es así, tu ubicación se compartirá con quien especifiques en COMPARTIR VIAJE.',
                maxLines: 8,
                style: FlutterFlowTheme.of(context).bodyText1.override(
                      fontFamily: 'Poppins',
                      color: Colors.black,
                      fontWeight: FontWeight.w300,
                    ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
