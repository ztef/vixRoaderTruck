import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'trips_record.g.dart';

abstract class TripsRecord implements Built<TripsRecord, TripsRecordBuilder> {
  static Serializer<TripsRecord> get serializer => _$tripsRecordSerializer;

  @nullable
  @BuiltValueField(wireName: 'trip_id')
  String get tripId;

  @nullable
  String get destination;

  @nullable
  DateTime get date;

  @nullable
  String get uid;

  @nullable
  String get customer;

  @nullable
  String get load;

  @nullable
  String get unit;

  @nullable
  bool get active;

  @nullable
  String get log;

  @nullable
  String get lastStatus;

  @nullable
  DocumentReference get shareWith;

  @nullable
  LatLng get position;

  @nullable
  DateTime get positionTime;

  @nullable
  String get geodata;

  @nullable
  double get lat;

  @nullable
  double get long;

  @nullable
  String get status;

  @nullable
  LatLng get positionDest;

  @nullable
  bool get onRoute;

  @nullable
  LatLng get positionOrig;

  @nullable
  LatLng get postitionZero;

  @nullable
  bool get usePositionZero;

  @nullable
  String get route;

  @nullable
  double get distance;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(TripsRecordBuilder builder) => builder
    ..tripId = ''
    ..destination = ''
    ..uid = ''
    ..customer = ''
    ..load = ''
    ..unit = ''
    ..active = false
    ..log = ''
    ..lastStatus = ''
    ..geodata = ''
    ..lat = 0.0
    ..long = 0.0
    ..status = ''
    ..onRoute = false
    ..usePositionZero = false
    ..route = ''
    ..distance = 0.0;

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('trips');

  static Stream<TripsRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  static Future<TripsRecord> getDocumentOnce(DocumentReference ref) => ref
      .get()
      .then((s) => serializers.deserializeWith(serializer, serializedData(s)));

  TripsRecord._();
  factory TripsRecord([void Function(TripsRecordBuilder) updates]) =
      _$TripsRecord;

  static TripsRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference});
}

Map<String, dynamic> createTripsRecordData({
  String tripId,
  String destination,
  DateTime date,
  String uid,
  String customer,
  String load,
  String unit,
  bool active,
  String log,
  String lastStatus,
  DocumentReference shareWith,
  LatLng position,
  DateTime positionTime,
  String geodata,
  double lat,
  double long,
  String status,
  LatLng positionDest,
  bool onRoute,
  LatLng positionOrig,
  LatLng postitionZero,
  bool usePositionZero,
  String route,
  double distance,
}) =>
    serializers.toFirestore(
        TripsRecord.serializer,
        TripsRecord((t) => t
          ..tripId = tripId
          ..destination = destination
          ..date = date
          ..uid = uid
          ..customer = customer
          ..load = load
          ..unit = unit
          ..active = active
          ..log = log
          ..lastStatus = lastStatus
          ..shareWith = shareWith
          ..position = position
          ..positionTime = positionTime
          ..geodata = geodata
          ..lat = lat
          ..long = long
          ..status = status
          ..positionDest = positionDest
          ..onRoute = onRoute
          ..positionOrig = positionOrig
          ..postitionZero = postitionZero
          ..usePositionZero = usePositionZero
          ..route = route
          ..distance = distance));
