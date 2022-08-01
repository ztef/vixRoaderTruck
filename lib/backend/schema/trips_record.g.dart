// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trips_record.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<TripsRecord> _$tripsRecordSerializer = new _$TripsRecordSerializer();

class _$TripsRecordSerializer implements StructuredSerializer<TripsRecord> {
  @override
  final Iterable<Type> types = const [TripsRecord, _$TripsRecord];
  @override
  final String wireName = 'TripsRecord';

  @override
  Iterable<Object> serialize(Serializers serializers, TripsRecord object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    Object value;
    value = object.tripId;
    if (value != null) {
      result
        ..add('trip_id')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.destination;
    if (value != null) {
      result
        ..add('destination')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.date;
    if (value != null) {
      result
        ..add('date')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(DateTime)));
    }
    value = object.uid;
    if (value != null) {
      result
        ..add('uid')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.customer;
    if (value != null) {
      result
        ..add('customer')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.load;
    if (value != null) {
      result
        ..add('load')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.unit;
    if (value != null) {
      result
        ..add('unit')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.active;
    if (value != null) {
      result
        ..add('active')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.log;
    if (value != null) {
      result
        ..add('log')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.lastStatus;
    if (value != null) {
      result
        ..add('lastStatus')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.shareWith;
    if (value != null) {
      result
        ..add('shareWith')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                DocumentReference, const [const FullType(Object)])));
    }
    value = object.position;
    if (value != null) {
      result
        ..add('position')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(LatLng)));
    }
    value = object.positionTime;
    if (value != null) {
      result
        ..add('positionTime')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(DateTime)));
    }
    value = object.geodata;
    if (value != null) {
      result
        ..add('geodata')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.lat;
    if (value != null) {
      result
        ..add('lat')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(double)));
    }
    value = object.long;
    if (value != null) {
      result
        ..add('long')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(double)));
    }
    value = object.status;
    if (value != null) {
      result
        ..add('status')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.positionDest;
    if (value != null) {
      result
        ..add('positionDest')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(LatLng)));
    }
    value = object.onRoute;
    if (value != null) {
      result
        ..add('onRoute')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.positionOrig;
    if (value != null) {
      result
        ..add('positionOrig')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(LatLng)));
    }
    value = object.postitionZero;
    if (value != null) {
      result
        ..add('postitionZero')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(LatLng)));
    }
    value = object.usePositionZero;
    if (value != null) {
      result
        ..add('usePositionZero')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.route;
    if (value != null) {
      result
        ..add('route')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.distance;
    if (value != null) {
      result
        ..add('distance')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(double)));
    }
    value = object.reference;
    if (value != null) {
      result
        ..add('Document__Reference__Field')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                DocumentReference, const [const FullType(Object)])));
    }
    return result;
  }

  @override
  TripsRecord deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new TripsRecordBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object value = iterator.current;
      switch (key) {
        case 'trip_id':
          result.tripId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'destination':
          result.destination = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'date':
          result.date = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime;
          break;
        case 'uid':
          result.uid = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'customer':
          result.customer = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'load':
          result.load = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'unit':
          result.unit = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'active':
          result.active = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'log':
          result.log = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'lastStatus':
          result.lastStatus = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'shareWith':
          result.shareWith = serializers.deserialize(value,
                  specifiedType: const FullType(
                      DocumentReference, const [const FullType(Object)]))
              as DocumentReference<Object>;
          break;
        case 'position':
          result.position = serializers.deserialize(value,
              specifiedType: const FullType(LatLng)) as LatLng;
          break;
        case 'positionTime':
          result.positionTime = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime;
          break;
        case 'geodata':
          result.geodata = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'lat':
          result.lat = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'long':
          result.long = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'status':
          result.status = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'positionDest':
          result.positionDest = serializers.deserialize(value,
              specifiedType: const FullType(LatLng)) as LatLng;
          break;
        case 'onRoute':
          result.onRoute = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'positionOrig':
          result.positionOrig = serializers.deserialize(value,
              specifiedType: const FullType(LatLng)) as LatLng;
          break;
        case 'postitionZero':
          result.postitionZero = serializers.deserialize(value,
              specifiedType: const FullType(LatLng)) as LatLng;
          break;
        case 'usePositionZero':
          result.usePositionZero = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'route':
          result.route = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'distance':
          result.distance = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'Document__Reference__Field':
          result.reference = serializers.deserialize(value,
                  specifiedType: const FullType(
                      DocumentReference, const [const FullType(Object)]))
              as DocumentReference<Object>;
          break;
      }
    }

    return result.build();
  }
}

class _$TripsRecord extends TripsRecord {
  @override
  final String tripId;
  @override
  final String destination;
  @override
  final DateTime date;
  @override
  final String uid;
  @override
  final String customer;
  @override
  final String load;
  @override
  final String unit;
  @override
  final bool active;
  @override
  final String log;
  @override
  final String lastStatus;
  @override
  final DocumentReference<Object> shareWith;
  @override
  final LatLng position;
  @override
  final DateTime positionTime;
  @override
  final String geodata;
  @override
  final double lat;
  @override
  final double long;
  @override
  final String status;
  @override
  final LatLng positionDest;
  @override
  final bool onRoute;
  @override
  final LatLng positionOrig;
  @override
  final LatLng postitionZero;
  @override
  final bool usePositionZero;
  @override
  final String route;
  @override
  final double distance;
  @override
  final DocumentReference<Object> reference;

  factory _$TripsRecord([void Function(TripsRecordBuilder) updates]) =>
      (new TripsRecordBuilder()..update(updates))._build();

  _$TripsRecord._(
      {this.tripId,
      this.destination,
      this.date,
      this.uid,
      this.customer,
      this.load,
      this.unit,
      this.active,
      this.log,
      this.lastStatus,
      this.shareWith,
      this.position,
      this.positionTime,
      this.geodata,
      this.lat,
      this.long,
      this.status,
      this.positionDest,
      this.onRoute,
      this.positionOrig,
      this.postitionZero,
      this.usePositionZero,
      this.route,
      this.distance,
      this.reference})
      : super._();

  @override
  TripsRecord rebuild(void Function(TripsRecordBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TripsRecordBuilder toBuilder() => new TripsRecordBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TripsRecord &&
        tripId == other.tripId &&
        destination == other.destination &&
        date == other.date &&
        uid == other.uid &&
        customer == other.customer &&
        load == other.load &&
        unit == other.unit &&
        active == other.active &&
        log == other.log &&
        lastStatus == other.lastStatus &&
        shareWith == other.shareWith &&
        position == other.position &&
        positionTime == other.positionTime &&
        geodata == other.geodata &&
        lat == other.lat &&
        long == other.long &&
        status == other.status &&
        positionDest == other.positionDest &&
        onRoute == other.onRoute &&
        positionOrig == other.positionOrig &&
        postitionZero == other.postitionZero &&
        usePositionZero == other.usePositionZero &&
        route == other.route &&
        distance == other.distance &&
        reference == other.reference;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc(
                            $jc(
                                $jc(
                                    $jc(
                                        $jc(
                                            $jc(
                                                $jc(
                                                    $jc(
                                                        $jc(
                                                            $jc(
                                                                $jc(
                                                                    $jc(
                                                                        $jc(
                                                                            $jc($jc($jc($jc($jc($jc($jc(0, tripId.hashCode), destination.hashCode), date.hashCode), uid.hashCode), customer.hashCode), load.hashCode),
                                                                                unit.hashCode),
                                                                            active.hashCode),
                                                                        log.hashCode),
                                                                    lastStatus.hashCode),
                                                                shareWith.hashCode),
                                                            position.hashCode),
                                                        positionTime.hashCode),
                                                    geodata.hashCode),
                                                lat.hashCode),
                                            long.hashCode),
                                        status.hashCode),
                                    positionDest.hashCode),
                                onRoute.hashCode),
                            positionOrig.hashCode),
                        postitionZero.hashCode),
                    usePositionZero.hashCode),
                route.hashCode),
            distance.hashCode),
        reference.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'TripsRecord')
          ..add('tripId', tripId)
          ..add('destination', destination)
          ..add('date', date)
          ..add('uid', uid)
          ..add('customer', customer)
          ..add('load', load)
          ..add('unit', unit)
          ..add('active', active)
          ..add('log', log)
          ..add('lastStatus', lastStatus)
          ..add('shareWith', shareWith)
          ..add('position', position)
          ..add('positionTime', positionTime)
          ..add('geodata', geodata)
          ..add('lat', lat)
          ..add('long', long)
          ..add('status', status)
          ..add('positionDest', positionDest)
          ..add('onRoute', onRoute)
          ..add('positionOrig', positionOrig)
          ..add('postitionZero', postitionZero)
          ..add('usePositionZero', usePositionZero)
          ..add('route', route)
          ..add('distance', distance)
          ..add('reference', reference))
        .toString();
  }
}

class TripsRecordBuilder implements Builder<TripsRecord, TripsRecordBuilder> {
  _$TripsRecord _$v;

  String _tripId;
  String get tripId => _$this._tripId;
  set tripId(String tripId) => _$this._tripId = tripId;

  String _destination;
  String get destination => _$this._destination;
  set destination(String destination) => _$this._destination = destination;

  DateTime _date;
  DateTime get date => _$this._date;
  set date(DateTime date) => _$this._date = date;

  String _uid;
  String get uid => _$this._uid;
  set uid(String uid) => _$this._uid = uid;

  String _customer;
  String get customer => _$this._customer;
  set customer(String customer) => _$this._customer = customer;

  String _load;
  String get load => _$this._load;
  set load(String load) => _$this._load = load;

  String _unit;
  String get unit => _$this._unit;
  set unit(String unit) => _$this._unit = unit;

  bool _active;
  bool get active => _$this._active;
  set active(bool active) => _$this._active = active;

  String _log;
  String get log => _$this._log;
  set log(String log) => _$this._log = log;

  String _lastStatus;
  String get lastStatus => _$this._lastStatus;
  set lastStatus(String lastStatus) => _$this._lastStatus = lastStatus;

  DocumentReference<Object> _shareWith;
  DocumentReference<Object> get shareWith => _$this._shareWith;
  set shareWith(DocumentReference<Object> shareWith) =>
      _$this._shareWith = shareWith;

  LatLng _position;
  LatLng get position => _$this._position;
  set position(LatLng position) => _$this._position = position;

  DateTime _positionTime;
  DateTime get positionTime => _$this._positionTime;
  set positionTime(DateTime positionTime) =>
      _$this._positionTime = positionTime;

  String _geodata;
  String get geodata => _$this._geodata;
  set geodata(String geodata) => _$this._geodata = geodata;

  double _lat;
  double get lat => _$this._lat;
  set lat(double lat) => _$this._lat = lat;

  double _long;
  double get long => _$this._long;
  set long(double long) => _$this._long = long;

  String _status;
  String get status => _$this._status;
  set status(String status) => _$this._status = status;

  LatLng _positionDest;
  LatLng get positionDest => _$this._positionDest;
  set positionDest(LatLng positionDest) => _$this._positionDest = positionDest;

  bool _onRoute;
  bool get onRoute => _$this._onRoute;
  set onRoute(bool onRoute) => _$this._onRoute = onRoute;

  LatLng _positionOrig;
  LatLng get positionOrig => _$this._positionOrig;
  set positionOrig(LatLng positionOrig) => _$this._positionOrig = positionOrig;

  LatLng _postitionZero;
  LatLng get postitionZero => _$this._postitionZero;
  set postitionZero(LatLng postitionZero) =>
      _$this._postitionZero = postitionZero;

  bool _usePositionZero;
  bool get usePositionZero => _$this._usePositionZero;
  set usePositionZero(bool usePositionZero) =>
      _$this._usePositionZero = usePositionZero;

  String _route;
  String get route => _$this._route;
  set route(String route) => _$this._route = route;

  double _distance;
  double get distance => _$this._distance;
  set distance(double distance) => _$this._distance = distance;

  DocumentReference<Object> _reference;
  DocumentReference<Object> get reference => _$this._reference;
  set reference(DocumentReference<Object> reference) =>
      _$this._reference = reference;

  TripsRecordBuilder() {
    TripsRecord._initializeBuilder(this);
  }

  TripsRecordBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _tripId = $v.tripId;
      _destination = $v.destination;
      _date = $v.date;
      _uid = $v.uid;
      _customer = $v.customer;
      _load = $v.load;
      _unit = $v.unit;
      _active = $v.active;
      _log = $v.log;
      _lastStatus = $v.lastStatus;
      _shareWith = $v.shareWith;
      _position = $v.position;
      _positionTime = $v.positionTime;
      _geodata = $v.geodata;
      _lat = $v.lat;
      _long = $v.long;
      _status = $v.status;
      _positionDest = $v.positionDest;
      _onRoute = $v.onRoute;
      _positionOrig = $v.positionOrig;
      _postitionZero = $v.postitionZero;
      _usePositionZero = $v.usePositionZero;
      _route = $v.route;
      _distance = $v.distance;
      _reference = $v.reference;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TripsRecord other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$TripsRecord;
  }

  @override
  void update(void Function(TripsRecordBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  TripsRecord build() => _build();

  _$TripsRecord _build() {
    final _$result = _$v ??
        new _$TripsRecord._(
            tripId: tripId,
            destination: destination,
            date: date,
            uid: uid,
            customer: customer,
            load: load,
            unit: unit,
            active: active,
            log: log,
            lastStatus: lastStatus,
            shareWith: shareWith,
            position: position,
            positionTime: positionTime,
            geodata: geodata,
            lat: lat,
            long: long,
            status: status,
            positionDest: positionDest,
            onRoute: onRoute,
            positionOrig: positionOrig,
            postitionZero: postitionZero,
            usePositionZero: usePositionZero,
            route: route,
            distance: distance,
            reference: reference);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
