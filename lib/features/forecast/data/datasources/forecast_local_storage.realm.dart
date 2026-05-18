// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forecast_local_storage.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
class CachedCurrentWeather extends _CachedCurrentWeather
    with RealmEntity, RealmObjectBase, RealmObject {
  CachedCurrentWeather(
    String id,
    String locationName,
    double temperature,
    double humidity,
    double windSpeed,
    String conditions,
    String description,
    double latitude,
    double longitude,
  ) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'locationName', locationName);
    RealmObjectBase.set(this, 'temperature', temperature);
    RealmObjectBase.set(this, 'humidity', humidity);
    RealmObjectBase.set(this, 'windSpeed', windSpeed);
    RealmObjectBase.set(this, 'conditions', conditions);
    RealmObjectBase.set(this, 'description', description);
    RealmObjectBase.set(this, 'latitude', latitude);
    RealmObjectBase.set(this, 'longitude', longitude);
  }

  CachedCurrentWeather._();

  @override
  String get id => RealmObjectBase.get<String>(this, 'id') as String;
  @override
  set id(String value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get locationName =>
      RealmObjectBase.get<String>(this, 'locationName') as String;
  @override
  set locationName(String value) =>
      RealmObjectBase.set(this, 'locationName', value);

  @override
  double get temperature =>
      RealmObjectBase.get<double>(this, 'temperature') as double;
  @override
  set temperature(double value) =>
      RealmObjectBase.set(this, 'temperature', value);

  @override
  double get humidity =>
      RealmObjectBase.get<double>(this, 'humidity') as double;
  @override
  set humidity(double value) => RealmObjectBase.set(this, 'humidity', value);

  @override
  double get windSpeed =>
      RealmObjectBase.get<double>(this, 'windSpeed') as double;
  @override
  set windSpeed(double value) => RealmObjectBase.set(this, 'windSpeed', value);

  @override
  String get conditions =>
      RealmObjectBase.get<String>(this, 'conditions') as String;
  @override
  set conditions(String value) =>
      RealmObjectBase.set(this, 'conditions', value);

  @override
  String get description =>
      RealmObjectBase.get<String>(this, 'description') as String;
  @override
  set description(String value) =>
      RealmObjectBase.set(this, 'description', value);

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
  Stream<RealmObjectChanges<CachedCurrentWeather>> get changes =>
      RealmObjectBase.getChanges<CachedCurrentWeather>(this);

  @override
  Stream<RealmObjectChanges<CachedCurrentWeather>> changesFor([
    List<String>? keyPaths,
  ]) => RealmObjectBase.getChangesFor<CachedCurrentWeather>(this, keyPaths);

  @override
  CachedCurrentWeather freeze() =>
      RealmObjectBase.freezeObject<CachedCurrentWeather>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'id': id.toEJson(),
      'locationName': locationName.toEJson(),
      'temperature': temperature.toEJson(),
      'humidity': humidity.toEJson(),
      'windSpeed': windSpeed.toEJson(),
      'conditions': conditions.toEJson(),
      'description': description.toEJson(),
      'latitude': latitude.toEJson(),
      'longitude': longitude.toEJson(),
    };
  }

  static EJsonValue _toEJson(CachedCurrentWeather value) => value.toEJson();
  static CachedCurrentWeather _fromEJson(EJsonValue ejson) {
    if (ejson is! Map<String, dynamic>) return raiseInvalidEJson(ejson);
    return switch (ejson) {
      {
        'id': EJsonValue id,
        'locationName': EJsonValue locationName,
        'temperature': EJsonValue temperature,
        'humidity': EJsonValue humidity,
        'windSpeed': EJsonValue windSpeed,
        'conditions': EJsonValue conditions,
        'description': EJsonValue description,
        'latitude': EJsonValue latitude,
        'longitude': EJsonValue longitude,
      } =>
        CachedCurrentWeather(
          fromEJson(id),
          fromEJson(locationName),
          fromEJson(temperature),
          fromEJson(humidity),
          fromEJson(windSpeed),
          fromEJson(conditions),
          fromEJson(description),
          fromEJson(latitude),
          fromEJson(longitude),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(CachedCurrentWeather._);
    register(_toEJson, _fromEJson);
    return const SchemaObject(
      ObjectType.realmObject,
      CachedCurrentWeather,
      'CachedCurrentWeather',
      [
        SchemaProperty('id', RealmPropertyType.string, primaryKey: true),
        SchemaProperty('locationName', RealmPropertyType.string),
        SchemaProperty('temperature', RealmPropertyType.double),
        SchemaProperty('humidity', RealmPropertyType.double),
        SchemaProperty('windSpeed', RealmPropertyType.double),
        SchemaProperty('conditions', RealmPropertyType.string),
        SchemaProperty('description', RealmPropertyType.string),
        SchemaProperty('latitude', RealmPropertyType.double),
        SchemaProperty('longitude', RealmPropertyType.double),
      ],
    );
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}

class CachedWeatherDay extends _CachedWeatherDay
    with RealmEntity, RealmObjectBase, RealmObject {
  CachedWeatherDay(
    String id,
    DateTime date,
    double temperature,
    double maxTemperature,
    double minTemperature,
    double humidity,
    double windSpeed,
    double precipitation,
    String conditions,
    String description,
  ) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'date', date);
    RealmObjectBase.set(this, 'temperature', temperature);
    RealmObjectBase.set(this, 'maxTemperature', maxTemperature);
    RealmObjectBase.set(this, 'minTemperature', minTemperature);
    RealmObjectBase.set(this, 'humidity', humidity);
    RealmObjectBase.set(this, 'windSpeed', windSpeed);
    RealmObjectBase.set(this, 'precipitation', precipitation);
    RealmObjectBase.set(this, 'conditions', conditions);
    RealmObjectBase.set(this, 'description', description);
  }

  CachedWeatherDay._();

  @override
  String get id => RealmObjectBase.get<String>(this, 'id') as String;
  @override
  set id(String value) => RealmObjectBase.set(this, 'id', value);

  @override
  DateTime get date => RealmObjectBase.get<DateTime>(this, 'date') as DateTime;
  @override
  set date(DateTime value) => RealmObjectBase.set(this, 'date', value);

  @override
  double get temperature =>
      RealmObjectBase.get<double>(this, 'temperature') as double;
  @override
  set temperature(double value) =>
      RealmObjectBase.set(this, 'temperature', value);

  @override
  double get maxTemperature =>
      RealmObjectBase.get<double>(this, 'maxTemperature') as double;
  @override
  set maxTemperature(double value) =>
      RealmObjectBase.set(this, 'maxTemperature', value);

  @override
  double get minTemperature =>
      RealmObjectBase.get<double>(this, 'minTemperature') as double;
  @override
  set minTemperature(double value) =>
      RealmObjectBase.set(this, 'minTemperature', value);

  @override
  double get humidity =>
      RealmObjectBase.get<double>(this, 'humidity') as double;
  @override
  set humidity(double value) => RealmObjectBase.set(this, 'humidity', value);

  @override
  double get windSpeed =>
      RealmObjectBase.get<double>(this, 'windSpeed') as double;
  @override
  set windSpeed(double value) => RealmObjectBase.set(this, 'windSpeed', value);

  @override
  double get precipitation =>
      RealmObjectBase.get<double>(this, 'precipitation') as double;
  @override
  set precipitation(double value) =>
      RealmObjectBase.set(this, 'precipitation', value);

  @override
  String get conditions =>
      RealmObjectBase.get<String>(this, 'conditions') as String;
  @override
  set conditions(String value) =>
      RealmObjectBase.set(this, 'conditions', value);

  @override
  String get description =>
      RealmObjectBase.get<String>(this, 'description') as String;
  @override
  set description(String value) =>
      RealmObjectBase.set(this, 'description', value);

  @override
  Stream<RealmObjectChanges<CachedWeatherDay>> get changes =>
      RealmObjectBase.getChanges<CachedWeatherDay>(this);

  @override
  Stream<RealmObjectChanges<CachedWeatherDay>> changesFor([
    List<String>? keyPaths,
  ]) => RealmObjectBase.getChangesFor<CachedWeatherDay>(this, keyPaths);

  @override
  CachedWeatherDay freeze() =>
      RealmObjectBase.freezeObject<CachedWeatherDay>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'id': id.toEJson(),
      'date': date.toEJson(),
      'temperature': temperature.toEJson(),
      'maxTemperature': maxTemperature.toEJson(),
      'minTemperature': minTemperature.toEJson(),
      'humidity': humidity.toEJson(),
      'windSpeed': windSpeed.toEJson(),
      'precipitation': precipitation.toEJson(),
      'conditions': conditions.toEJson(),
      'description': description.toEJson(),
    };
  }

  static EJsonValue _toEJson(CachedWeatherDay value) => value.toEJson();
  static CachedWeatherDay _fromEJson(EJsonValue ejson) {
    if (ejson is! Map<String, dynamic>) return raiseInvalidEJson(ejson);
    return switch (ejson) {
      {
        'id': EJsonValue id,
        'date': EJsonValue date,
        'temperature': EJsonValue temperature,
        'maxTemperature': EJsonValue maxTemperature,
        'minTemperature': EJsonValue minTemperature,
        'humidity': EJsonValue humidity,
        'windSpeed': EJsonValue windSpeed,
        'precipitation': EJsonValue precipitation,
        'conditions': EJsonValue conditions,
        'description': EJsonValue description,
      } =>
        CachedWeatherDay(
          fromEJson(id),
          fromEJson(date),
          fromEJson(temperature),
          fromEJson(maxTemperature),
          fromEJson(minTemperature),
          fromEJson(humidity),
          fromEJson(windSpeed),
          fromEJson(precipitation),
          fromEJson(conditions),
          fromEJson(description),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(CachedWeatherDay._);
    register(_toEJson, _fromEJson);
    return const SchemaObject(
      ObjectType.realmObject,
      CachedWeatherDay,
      'CachedWeatherDay',
      [
        SchemaProperty('id', RealmPropertyType.string, primaryKey: true),
        SchemaProperty('date', RealmPropertyType.timestamp),
        SchemaProperty('temperature', RealmPropertyType.double),
        SchemaProperty('maxTemperature', RealmPropertyType.double),
        SchemaProperty('minTemperature', RealmPropertyType.double),
        SchemaProperty('humidity', RealmPropertyType.double),
        SchemaProperty('windSpeed', RealmPropertyType.double),
        SchemaProperty('precipitation', RealmPropertyType.double),
        SchemaProperty('conditions', RealmPropertyType.string),
        SchemaProperty('description', RealmPropertyType.string),
      ],
    );
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}
