// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'events_local_storage.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
class CachedEvent extends _CachedEvent
    with RealmEntity, RealmObjectBase, RealmObject {
  CachedEvent(
    String id,
    String title,
    String type,
    String description,
    DateTime date,
    String locationName,
    double latitude,
    double longitude,
    bool isFavorite,
  ) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'title', title);
    RealmObjectBase.set(this, 'type', type);
    RealmObjectBase.set(this, 'description', description);
    RealmObjectBase.set(this, 'date', date);
    RealmObjectBase.set(this, 'locationName', locationName);
    RealmObjectBase.set(this, 'latitude', latitude);
    RealmObjectBase.set(this, 'longitude', longitude);
    RealmObjectBase.set(this, 'isFavorite', isFavorite);
  }

  CachedEvent._();

  @override
  String get id => RealmObjectBase.get<String>(this, 'id') as String;
  @override
  set id(String value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get title => RealmObjectBase.get<String>(this, 'title') as String;
  @override
  set title(String value) => RealmObjectBase.set(this, 'title', value);

  @override
  String get type => RealmObjectBase.get<String>(this, 'type') as String;
  @override
  set type(String value) => RealmObjectBase.set(this, 'type', value);

  @override
  String get description =>
      RealmObjectBase.get<String>(this, 'description') as String;
  @override
  set description(String value) =>
      RealmObjectBase.set(this, 'description', value);

  @override
  DateTime get date => RealmObjectBase.get<DateTime>(this, 'date') as DateTime;
  @override
  set date(DateTime value) => RealmObjectBase.set(this, 'date', value);

  @override
  String get locationName =>
      RealmObjectBase.get<String>(this, 'locationName') as String;
  @override
  set locationName(String value) =>
      RealmObjectBase.set(this, 'locationName', value);

  @override
  double get latitude =>
      RealmObjectBase.get<double>(this, 'latitude') as double;
  @override
  set latitude(double value) => RealmObjectBase.set(this, 'latitude', value);

  @override
  double get longitude =>
      RealmObjectBase.get<double>(this, 'longitude') as double;
  @override
  set longitude(double value) => RealmObjectBase.set(this, 'longitude', value);

  @override
  bool get isFavorite => RealmObjectBase.get<bool>(this, 'isFavorite') as bool;
  @override
  set isFavorite(bool value) => RealmObjectBase.set(this, 'isFavorite', value);

  @override
  Stream<RealmObjectChanges<CachedEvent>> get changes =>
      RealmObjectBase.getChanges<CachedEvent>(this);

  @override
  Stream<RealmObjectChanges<CachedEvent>> changesFor([
    List<String>? keyPaths,
  ]) => RealmObjectBase.getChangesFor<CachedEvent>(this, keyPaths);

  @override
  CachedEvent freeze() => RealmObjectBase.freezeObject<CachedEvent>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'id': id.toEJson(),
      'title': title.toEJson(),
      'type': type.toEJson(),
      'description': description.toEJson(),
      'date': date.toEJson(),
      'locationName': locationName.toEJson(),
      'latitude': latitude.toEJson(),
      'longitude': longitude.toEJson(),
      'isFavorite': isFavorite.toEJson(),
    };
  }

  static EJsonValue _toEJson(CachedEvent value) => value.toEJson();
  static CachedEvent _fromEJson(EJsonValue ejson) {
    if (ejson is! Map<String, dynamic>) return raiseInvalidEJson(ejson);
    return switch (ejson) {
      {
        'id': EJsonValue id,
        'title': EJsonValue title,
        'type': EJsonValue type,
        'description': EJsonValue description,
        'date': EJsonValue date,
        'locationName': EJsonValue locationName,
        'latitude': EJsonValue latitude,
        'longitude': EJsonValue longitude,
        'isFavorite': EJsonValue isFavorite,
      } =>
        CachedEvent(
          fromEJson(id),
          fromEJson(title),
          fromEJson(type),
          fromEJson(description),
          fromEJson(date),
          fromEJson(locationName),
          fromEJson(latitude),
          fromEJson(longitude),
          fromEJson(isFavorite),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(CachedEvent._);
    register(_toEJson, _fromEJson);
    return const SchemaObject(
      ObjectType.realmObject,
      CachedEvent,
      'CachedEvent',
      [
        SchemaProperty('id', RealmPropertyType.string, primaryKey: true),
        SchemaProperty('title', RealmPropertyType.string),
        SchemaProperty('type', RealmPropertyType.string),
        SchemaProperty('description', RealmPropertyType.string),
        SchemaProperty('date', RealmPropertyType.timestamp),
        SchemaProperty('locationName', RealmPropertyType.string),
        SchemaProperty('latitude', RealmPropertyType.double),
        SchemaProperty('longitude', RealmPropertyType.double),
        SchemaProperty('isFavorite', RealmPropertyType.bool),
      ],
    );
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}

class FavoriteEventLocal extends _FavoriteEventLocal
    with RealmEntity, RealmObjectBase, RealmObject {
  FavoriteEventLocal(
    String id,
    String title,
    String type,
    String description,
    DateTime date,
    String locationName,
    double latitude,
    double longitude,
    DateTime savedAt,
  ) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'title', title);
    RealmObjectBase.set(this, 'type', type);
    RealmObjectBase.set(this, 'description', description);
    RealmObjectBase.set(this, 'date', date);
    RealmObjectBase.set(this, 'locationName', locationName);
    RealmObjectBase.set(this, 'latitude', latitude);
    RealmObjectBase.set(this, 'longitude', longitude);
    RealmObjectBase.set(this, 'savedAt', savedAt);
  }

  FavoriteEventLocal._();

  @override
  String get id => RealmObjectBase.get<String>(this, 'id') as String;
  @override
  set id(String value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get title => RealmObjectBase.get<String>(this, 'title') as String;
  @override
  set title(String value) => RealmObjectBase.set(this, 'title', value);

  @override
  String get type => RealmObjectBase.get<String>(this, 'type') as String;
  @override
  set type(String value) => RealmObjectBase.set(this, 'type', value);

  @override
  String get description =>
      RealmObjectBase.get<String>(this, 'description') as String;
  @override
  set description(String value) =>
      RealmObjectBase.set(this, 'description', value);

  @override
  DateTime get date => RealmObjectBase.get<DateTime>(this, 'date') as DateTime;
  @override
  set date(DateTime value) => RealmObjectBase.set(this, 'date', value);

  @override
  String get locationName =>
      RealmObjectBase.get<String>(this, 'locationName') as String;
  @override
  set locationName(String value) =>
      RealmObjectBase.set(this, 'locationName', value);

  @override
  double get latitude =>
      RealmObjectBase.get<double>(this, 'latitude') as double;
  @override
  set latitude(double value) => RealmObjectBase.set(this, 'latitude', value);

  @override
  double get longitude =>
      RealmObjectBase.get<double>(this, 'longitude') as double;
  @override
  set longitude(double value) => RealmObjectBase.set(this, 'longitude', value);

  @override
  DateTime get savedAt =>
      RealmObjectBase.get<DateTime>(this, 'savedAt') as DateTime;
  @override
  set savedAt(DateTime value) => RealmObjectBase.set(this, 'savedAt', value);

  @override
  Stream<RealmObjectChanges<FavoriteEventLocal>> get changes =>
      RealmObjectBase.getChanges<FavoriteEventLocal>(this);

  @override
  Stream<RealmObjectChanges<FavoriteEventLocal>> changesFor([
    List<String>? keyPaths,
  ]) => RealmObjectBase.getChangesFor<FavoriteEventLocal>(this, keyPaths);

  @override
  FavoriteEventLocal freeze() =>
      RealmObjectBase.freezeObject<FavoriteEventLocal>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'id': id.toEJson(),
      'title': title.toEJson(),
      'type': type.toEJson(),
      'description': description.toEJson(),
      'date': date.toEJson(),
      'locationName': locationName.toEJson(),
      'latitude': latitude.toEJson(),
      'longitude': longitude.toEJson(),
      'savedAt': savedAt.toEJson(),
    };
  }

  static EJsonValue _toEJson(FavoriteEventLocal value) => value.toEJson();
  static FavoriteEventLocal _fromEJson(EJsonValue ejson) {
    if (ejson is! Map<String, dynamic>) return raiseInvalidEJson(ejson);
    return switch (ejson) {
      {
        'id': EJsonValue id,
        'title': EJsonValue title,
        'type': EJsonValue type,
        'description': EJsonValue description,
        'date': EJsonValue date,
        'locationName': EJsonValue locationName,
        'latitude': EJsonValue latitude,
        'longitude': EJsonValue longitude,
        'savedAt': EJsonValue savedAt,
      } =>
        FavoriteEventLocal(
          fromEJson(id),
          fromEJson(title),
          fromEJson(type),
          fromEJson(description),
          fromEJson(date),
          fromEJson(locationName),
          fromEJson(latitude),
          fromEJson(longitude),
          fromEJson(savedAt),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(FavoriteEventLocal._);
    register(_toEJson, _fromEJson);
    return const SchemaObject(
      ObjectType.realmObject,
      FavoriteEventLocal,
      'FavoriteEventLocal',
      [
        SchemaProperty('id', RealmPropertyType.string, primaryKey: true),
        SchemaProperty('title', RealmPropertyType.string),
        SchemaProperty('type', RealmPropertyType.string),
        SchemaProperty('description', RealmPropertyType.string),
        SchemaProperty('date', RealmPropertyType.timestamp),
        SchemaProperty('locationName', RealmPropertyType.string),
        SchemaProperty('latitude', RealmPropertyType.double),
        SchemaProperty('longitude', RealmPropertyType.double),
        SchemaProperty('savedAt', RealmPropertyType.timestamp),
      ],
    );
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}
