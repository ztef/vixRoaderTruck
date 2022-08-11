// Automatic FlutterFlow imports
import '../../backend/backend.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '../actions/index.dart'; // Imports custom actions
import '../../flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';

// Begin custom widget code
class TripClasses extends StatefulWidget {
  const TripClasses({
    Key key,
    this.width,
    this.height,
  }) : super(key: key);

  final double width;
  final double height;

  @override
  _TripClassesState createState() => _TripClassesState();
}

class _TripClassesState extends State<TripClasses> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

/*
class Time {
   

}


class Trip {
    static TripsRecord tripR;
    static Timer timer;
    static elapsed;
    
   static setRecord(record){
        tripR = record;
    }
    
    static getStartTime(){
      return tripR.date;
    }
  
    static startTimer(){
       timer = Timer.periodic(const Duration(seconds: 1), (timer) =>     _updater());
    }     
  
    static stopTimer(){
    	timer.cancel();
    }
  
    static _updater(){
    
    }
  
   _elapsedTimeFrom(time) {
  		Duration tiempo =  DateTime.now().difference(time);
  		return timeFormat(tiempo);
	}

  // static timeFormat(Duration d) =>   d.toString().split('.').first.padLeft(8, "0");


}


  */
