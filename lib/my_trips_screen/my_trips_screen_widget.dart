import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../main/main_widget.dart';
import '../set_origin_dest/set_origin_dest_widget.dart';
import '../trip_detail/trip_detail_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTripsScreenWidget extends StatefulWidget {
  const MyTripsScreenWidget({Key key}) : super(key: key);

  @override
  _MyTripsScreenWidgetState createState() => _MyTripsScreenWidgetState();
}

class _MyTripsScreenWidgetState extends State<MyTripsScreenWidget> {
  TextEditingController searchFieldController;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    searchFieldController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).primaryColor,
        automaticallyImplyLeading: false,
        leading: FlutterFlowIconButton(
          borderColor: Colors.transparent,
          borderRadius: 30,
          borderWidth: 1,
          buttonSize: 60,
          icon: Icon(
            Icons.arrow_back_rounded,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MainWidget(),
              ),
            );
          },
        ),
        title: Text(
          'Mis Viajes',
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
      floatingActionButton: Visibility(
        visible: !valueOrDefault<bool>(currentUserDocument?.onTrip, false),
        child: AuthUserStreamWidget(
          child: FloatingActionButton.extended(
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SetOriginDestWidget(),
                ),
              );
            },
            backgroundColor: FlutterFlowTheme.of(context).primaryColor,
            icon: FaIcon(
              FontAwesomeIcons.plus,
            ),
            elevation: 5,
            label: Text(
              'Iniciar Nuevo',
              style: FlutterFlowTheme.of(context).bodyText1.override(
                    fontFamily: 'Poppins',
                    color: FlutterFlowTheme.of(context).white,
                  ),
            ),
          ),
        ),
      ),
      drawer: Drawer(
        elevation: 16,
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Material(
                color: Colors.transparent,
                elevation: 0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 4,
                        color: Color(0x430F1113),
                        offset: Offset(0, 2),
                      )
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 6, 20, 4),
                    child: TextFormField(
                      controller: searchFieldController,
                      obscureText: false,
                      decoration: InputDecoration(
                        labelText: 'Buscar...',
                        hintStyle: FlutterFlowTheme.of(context).bodyText2,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color:
                                FlutterFlowTheme.of(context).primaryBackground,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color:
                                FlutterFlowTheme.of(context).primaryBackground,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        prefixIcon: Icon(
                          Icons.search_rounded,
                          color: Color(0xFF95A1AC),
                        ),
                      ),
                      style: FlutterFlowTheme.of(context).bodyText1,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: StreamBuilder<List<TripsRecord>>(
              stream: queryTripsRecord(
                queryBuilder: (tripsRecord) => tripsRecord
                    .where('uid', isEqualTo: currentUserUid)
                    .orderBy('date', descending: true),
              ),
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
                List<TripsRecord> listViewTripsRecordList = snapshot.data;
                return ListView.builder(
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.vertical,
                  itemCount: listViewTripsRecordList.length,
                  itemBuilder: (context, listViewIndex) {
                    final listViewTripsRecord =
                        listViewTripsRecordList[listViewIndex];
                    return Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(16, 6, 16, 0),
                      child: Container(
                        width: double.infinity,
                        height: 144,
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: Image.asset(
                              'assets/images/trailer_fondo_blur.png',
                            ).image,
                          ),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 3,
                              color: Color(0x33000000),
                              offset: Offset(0, 2),
                            )
                          ],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Container(
                          width: 100,
                          height: 80,
                          decoration: BoxDecoration(
                            color: Color(0x00090F13),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16, 16, 16, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        listViewTripsRecord.destination,
                                        style: FlutterFlowTheme.of(context)
                                            .subtitle1,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (valueOrDefault<bool>(
                                  currentUserDocument?.onTrip, false))
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      16, 4, 16, 0),
                                  child: AuthUserStreamWidget(
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        if ((listViewTripsRecord.reference ==
                                            currentUserDocument?.trip))
                                          Text(
                                            'En Curso',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyText1
                                                .override(
                                                  fontFamily: 'Poppins',
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .customColor3,
                                                ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      16, 4, 16, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      FFButtonWidget(
                                        onPressed: () async {
                                          setState(() => FFAppState()
                                                  .selectedTrip =
                                              listViewTripsRecord.reference);
                                          await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  TripDetailWidget(),
                                            ),
                                          );
                                        },
                                        text: 'Detalles',
                                        icon: Icon(
                                          Icons.featured_play_list,
                                          color: Colors.white,
                                          size: 15,
                                        ),
                                        options: FFButtonOptions(
                                          width: 120,
                                          height: 40,
                                          color: Color(0xFF252EDC),
                                          textStyle: GoogleFonts.getFont(
                                            'Lexend Deca',
                                            color: Colors.white,
                                            fontSize: 14,
                                          ),
                                          elevation: 3,
                                          borderSide: BorderSide(
                                            color: Colors.transparent,
                                            width: 1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0, 0, 0, 4),
                                              child: Text(
                                                dateTimeFormat('Hm',
                                                    listViewTripsRecord.date),
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .title3
                                                        .override(
                                                          fontFamily:
                                                              'Lexend Deca',
                                                          color: Colors.black,
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                              ),
                                            ),
                                            Text(
                                              dateTimeFormat('d/M/y',
                                                  listViewTripsRecord.date),
                                              textAlign: TextAlign.end,
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyText1
                                                  .override(
                                                    fontFamily: 'Lexend Deca',
                                                    color: Color(0xB4000000),
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
