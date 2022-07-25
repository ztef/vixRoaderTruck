import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';
import 'flutter_flow/lat_lng.dart';
import 'dart:convert';

class FFAppState {
  static final FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal() {
    initializePersistedState();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('ff_tripStatus')) {
      try {
        _tripStatus = jsonDecode(prefs.getString('ff_tripStatus'));
      } catch (e) {
        print("Can't decode persisted json. Error: $e.");
      }
    }

    _activeTrip = prefs.getString('ff_activeTrip')?.ref ?? _activeTrip;
    _tripLog = prefs.getStringList('ff_tripLog')?.map((x) {
          try {
            return jsonDecode(x);
          } catch (e) {
            print("Can't decode persisted json. Error: $e.");
            return {};
          }
        })?.toList() ??
        _tripLog;
    if (prefs.containsKey('ff_pauseOptions')) {
      try {
        _pauseOptions = jsonDecode(prefs.getString('ff_pauseOptions'));
      } catch (e) {
        print("Can't decode persisted json. Error: $e.");
      }
    }

    _elasticity = prefs.getInt('ff_elasticity') ?? _elasticity;
  }

  SharedPreferences prefs;

  dynamic _tripStatus =
      jsonDecode('{\"activeTripID\":\"0\",\"status\":\"ended\"}');
  dynamic get tripStatus => _tripStatus;
  set tripStatus(dynamic _value) {
    _tripStatus = _value;
    prefs.setString('ff_tripStatus', jsonEncode(_value));
  }

  DocumentReference selectedTrip;

  DocumentReference _activeTrip;
  DocumentReference get activeTrip => _activeTrip;
  set activeTrip(DocumentReference _value) {
    _activeTrip = _value;
    prefs.setString('ff_activeTrip', _value.path);
  }

  DocumentReference nullTrip;

  String aux = '';

  List<dynamic> _tripLog = [];
  List<dynamic> get tripLog => _tripLog;
  set tripLog(List<dynamic> _value) {
    _tripLog = _value;
    prefs.setStringList(
        'ff_tripLog', _value.map((x) => jsonEncode(x)).toList());
  }

  void addToTripLog(dynamic _value) {
    _tripLog.add(_value);
    prefs.setStringList(
        'ff_tripLog', _tripLog.map((x) => jsonEncode(x)).toList());
  }

  void removeFromTripLog(dynamic _value) {
    _tripLog.remove(_value);
    prefs.setStringList(
        'ff_tripLog', _tripLog.map((x) => jsonEncode(x)).toList());
  }

  dynamic _pauseOptions = jsonDecode(
      '[{\"motivo\":\"fuel\",\"desc\":\"Cargando Combustible\"},{\"motivo\":\"load\",\"desc\":\"Esperando Carga\"},{\"motivo\":\"loading\",\"desc\":\"Cargando\"},{\"motivo\":\"unloading\",\"desc\":\"Descargando\"},{\"motivo\":\"rest\",\"desc\":\"Descanso\"},{\"motivo\":\"food\",\"desc\":\"Alimentos\"},{\"motivo\":\"repair\",\"desc\":\"Reparando Avería\"},{\"motivo\":\"ret\",\"desc\":\"Retén\"},{\"motivo\":\"police\",\"desc\":\"Policía\"},{\"motivo\":\"\",\"desc\":\"Sin Motivo\"}]');
  dynamic get pauseOptions => _pauseOptions;
  set pauseOptions(dynamic _value) {
    _pauseOptions = _value;
    prefs.setString('ff_pauseOptions', jsonEncode(_value));
  }

  String currentGeoData = '';

  int _elasticity = 0;
  int get elasticity => _elasticity;
  set elasticity(int _value) {
    _elasticity = _value;
    prefs.setInt('ff_elasticity', _value);
  }

  bool onRoute = false;

  bool onTrip = false;
}

LatLng _latLngFromString(String val) {
  if (val == null) {
    return null;
  }
  final split = val.split(',');
  final lat = double.parse(split.first);
  final lng = double.parse(split.last);
  return LatLng(lat, lng);
}
