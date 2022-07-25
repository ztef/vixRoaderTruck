// Automatic FlutterFlow imports
import '../../backend/backend.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '../actions/index.dart'; // Imports custom actions
import '../../flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';

// Begin custom widget code
class GetPauseIcon extends StatefulWidget {
  const GetPauseIcon({
    Key key,
    this.width,
    this.height,
    this.reason,
  }) : super(key: key);

  final double width;
  final double height;
  final String reason;

  @override
  _GetPauseIconState createState() => _GetPauseIconState();
}

class _GetPauseIconState extends State<GetPauseIcon> {
  static Map iconos = {
    '': Icons.circle,
    'fuel': Icons.ev_station,
    'load': Icons.access_time,
    'loading': Icons.arrow_circle_up,
    'unloading': Icons.arrow_circle_down,
    'rest': Icons.hotel,
    'food': Icons.restaurant,
    'repair': Icons.bus_alert,
    'ret': Icons.dangerous,
    'police': Icons.local_police,
  };

  @override
  Widget build(BuildContext context) {
    return Icon(iconos[widget.reason]);
  }
}

/*
[{"motivo":"fuel","desc":"Cargando Combustible"},{"motivo":"load","desc":"Esperando Carga"},{"motivo":"loading","desc":"Cargando"},{"motivo":"unloading","desc":"Descargando"},{"motivo":"rest","desc":"Descanso"},{"motivo":"food","desc":"Alimentos"},{"motivo":"ret","desc":"Retén"},{"motivo":"police","desc":"Policía"},{"motivo":"","desc":"Sin Motivo"}]
*/

/*
switch (widget.reason) {
      case 'gas':
        return const Icon(Icons.access_alarm_sharp);
      break;
      case 'repair': 
        return const Icon(Icons.build_sharp);
      break;
        
      case 'break': 
        return const Icon(Icons.accessibility_outlined);
      break;  
      case 'break': 
        return const Icon(Icons.accessibility_outlined);
      break;
         case 'break': 
        return const Icon(Icons.accessibility_outlined);
      break;
         case 'break': 
        return const Icon(Icons.accessibility_outlined);
      break;
         case 'break': 
        return const Icon(Icons.accessibility_outlined);
      break;
         case 'break': 
        return const Icon(Icons.accessibility_outlined);
      break;
         case 'break': 
        return const Icon(Icons.accessibility_outlined);
      break;
         case 'break': 
        return const Icon(Icons.accessibility_outlined);
      break;
      default :
        return const Icon(Icons.ac_unit_outlined);
        break;
  }
*/
