import '../components/preview_trip_widget.dart';
import '../flutter_flow/flutter_flow_place_picker.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../flutter_flow/place.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SetOriginDestWidget extends StatefulWidget {
  const SetOriginDestWidget({Key key}) : super(key: key);

  @override
  _SetOriginDestWidgetState createState() => _SetOriginDestWidgetState();
}

class _SetOriginDestWidgetState extends State<SetOriginDestWidget> {
  bool origenActualValue;
  var originPlaceValue = FFPlace();
  var destinationPlaceValue = FFPlace();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).primaryColor,
        automaticallyImplyLeading: true,
        actions: [],
        centerTitle: true,
        elevation: 4,
      ),
      backgroundColor: Color(0xFFEFEFEF),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
            child: Container(
              width: double.infinity,
              height: 250,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryBackground,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Align(
                    alignment: AlignmentDirectional(-1, 0),
                    child: Text(
                      'Origen de tu Viaje',
                      style: FlutterFlowTheme.of(context).bodyText1.override(
                            fontFamily: 'Poppins',
                            color: FlutterFlowTheme.of(context).grayIcon,
                          ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
                    child: Theme(
                      data: ThemeData(
                        unselectedWidgetColor: Color(0xFF95A1AC),
                      ),
                      child: CheckboxListTile(
                        value: origenActualValue ??= false,
                        onChanged: (newValue) =>
                            setState(() => origenActualValue = newValue),
                        title: Text(
                          'Comenzar en mi ubicación actual :',
                          style: FlutterFlowTheme.of(context).bodyText1,
                        ),
                        tileColor: Color(0xFFF5F5F5),
                        activeColor: FlutterFlowTheme.of(context).primaryColor,
                        dense: false,
                        controlAffinity: ListTileControlAffinity.trailing,
                      ),
                    ),
                  ),
                  if (!origenActualValue ?? true)
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                      child: FlutterFlowPlacePicker(
                        iOSGoogleMapsApiKey:
                            'AIzaSyCoaT8QJJn6122A_tjUKsO9Z6WweDteELc',
                        androidGoogleMapsApiKey:
                            'AIzaSyDUrho1GLpeK0eF6X94sUxSz86NK72HbUg',
                        webGoogleMapsApiKey:
                            'AIzaSyBu2GzkodpROm87tn0F2y6ESCXSMh46HEE',
                        onSelect: (place) async {
                          setState(() => originPlaceValue = place);
                        },
                        defaultText: 'Selecciona el Origen',
                        icon: Icon(
                          Icons.place,
                          color: Colors.white,
                          size: 16,
                        ),
                        buttonOptions: FFButtonOptions(
                          width: double.infinity,
                          height: 40,
                          color: FlutterFlowTheme.of(context).primaryColor,
                          textStyle:
                              FlutterFlowTheme.of(context).subtitle2.override(
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
                  if (!origenActualValue ?? true)
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
                            child: Card(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              color: Color(0xFFF5F5F5),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        10, 0, 10, 0),
                                    child: Text(
                                      originPlaceValue.name,
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        10, 0, 10, 0),
                                    child: Text(
                                      originPlaceValue.address,
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1,
                                    ),
                                  ),
                                  Text(
                                    originPlaceValue.city,
                                    style:
                                        FlutterFlowTheme.of(context).bodyText1,
                                  ),
                                  Text(
                                    originPlaceValue.state,
                                    style:
                                        FlutterFlowTheme.of(context).bodyText1,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
            child: Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryBackground,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Align(
                    alignment: AlignmentDirectional(-1, 0),
                    child: Text(
                      'Destino de tu Viaje',
                      style: FlutterFlowTheme.of(context).bodyText1.override(
                            fontFamily: 'Poppins',
                            color: FlutterFlowTheme.of(context).grayIcon,
                          ),
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional(0, -0.99),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 0),
                      child: FlutterFlowPlacePicker(
                        iOSGoogleMapsApiKey:
                            'AIzaSyCoaT8QJJn6122A_tjUKsO9Z6WweDteELc',
                        androidGoogleMapsApiKey:
                            'AIzaSyDUrho1GLpeK0eF6X94sUxSz86NK72HbUg',
                        webGoogleMapsApiKey:
                            'AIzaSyBu2GzkodpROm87tn0F2y6ESCXSMh46HEE',
                        onSelect: (place) async {
                          setState(() => destinationPlaceValue = place);
                        },
                        defaultText: 'Selecciona tu Destino',
                        icon: Icon(
                          Icons.place,
                          color: Colors.white,
                          size: 16,
                        ),
                        buttonOptions: FFButtonOptions(
                          width: double.infinity,
                          height: 40,
                          color: FlutterFlowTheme.of(context).primaryColor,
                          textStyle:
                              FlutterFlowTheme.of(context).subtitle2.override(
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
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                          child: Card(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            color: Color(0xFFF5F5F5),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10, 0, 10, 0),
                                  child: Text(
                                    destinationPlaceValue.name,
                                    style:
                                        FlutterFlowTheme.of(context).bodyText1,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10, 0, 10, 0),
                                  child: Text(
                                    destinationPlaceValue.address,
                                    style:
                                        FlutterFlowTheme.of(context).bodyText1,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10, 0, 10, 0),
                                  child: Text(
                                    destinationPlaceValue.city,
                                    style:
                                        FlutterFlowTheme.of(context).bodyText1,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10, 0, 10, 0),
                                  child: Text(
                                    destinationPlaceValue.state,
                                    style:
                                        FlutterFlowTheme.of(context).bodyText1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          if ((destinationPlaceValue.name != null &&
              destinationPlaceValue.name != ''))
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(30, 30, 30, 30),
              child: FFButtonWidget(
                onPressed: () async {
                  await showModalBottomSheet(
                    isScrollControlled: true,
                    backgroundColor:
                        FlutterFlowTheme.of(context).primaryBackground,
                    context: context,
                    builder: (context) {
                      return Padding(
                        padding: MediaQuery.of(context).viewInsets,
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.8,
                          child: PreviewTripWidget(
                            origin: originPlaceValue,
                            destination: destinationPlaceValue,
                            origenActual: origenActualValue,
                          ),
                        ),
                      );
                    },
                  );
                },
                text: 'Continuar',
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
        ],
      ),
    );
  }
}
