// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: type=lint
class Session extends DataClass implements Insertable<Session> {
  final int id;
  final int sessionNumber;
  final String participantId;
  final DateTime timeStart;
  final DateTime timeEnd;
  Session(
      {required this.id,
      required this.sessionNumber,
      required this.participantId,
      required this.timeStart,
      required this.timeEnd});
  factory Session.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Session(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      sessionNumber: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}session_number'])!,
      participantId: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}participant_id'])!,
      timeStart: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}time_start'])!,
      timeEnd: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}time_end'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['session_number'] = Variable<int>(sessionNumber);
    map['participant_id'] = Variable<String>(participantId);
    map['time_start'] = Variable<DateTime>(timeStart);
    map['time_end'] = Variable<DateTime>(timeEnd);
    return map;
  }

  SessionsCompanion toCompanion(bool nullToAbsent) {
    return SessionsCompanion(
      id: Value(id),
      sessionNumber: Value(sessionNumber),
      participantId: Value(participantId),
      timeStart: Value(timeStart),
      timeEnd: Value(timeEnd),
    );
  }

  factory Session.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Session(
      id: serializer.fromJson<int>(json['id']),
      sessionNumber: serializer.fromJson<int>(json['sessionNumber']),
      participantId: serializer.fromJson<String>(json['participantId']),
      timeStart: serializer.fromJson<DateTime>(json['timeStart']),
      timeEnd: serializer.fromJson<DateTime>(json['timeEnd']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'sessionNumber': serializer.toJson<int>(sessionNumber),
      'participantId': serializer.toJson<String>(participantId),
      'timeStart': serializer.toJson<DateTime>(timeStart),
      'timeEnd': serializer.toJson<DateTime>(timeEnd),
    };
  }

  Session copyWith(
          {int? id,
          int? sessionNumber,
          String? participantId,
          DateTime? timeStart,
          DateTime? timeEnd}) =>
      Session(
        id: id ?? this.id,
        sessionNumber: sessionNumber ?? this.sessionNumber,
        participantId: participantId ?? this.participantId,
        timeStart: timeStart ?? this.timeStart,
        timeEnd: timeEnd ?? this.timeEnd,
      );
  @override
  String toString() {
    return (StringBuffer('Session(')
          ..write('id: $id, ')
          ..write('sessionNumber: $sessionNumber, ')
          ..write('participantId: $participantId, ')
          ..write('timeStart: $timeStart, ')
          ..write('timeEnd: $timeEnd')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, sessionNumber, participantId, timeStart, timeEnd);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Session &&
          other.id == this.id &&
          other.sessionNumber == this.sessionNumber &&
          other.participantId == this.participantId &&
          other.timeStart == this.timeStart &&
          other.timeEnd == this.timeEnd);
}

class SessionsCompanion extends UpdateCompanion<Session> {
  final Value<int> id;
  final Value<int> sessionNumber;
  final Value<String> participantId;
  final Value<DateTime> timeStart;
  final Value<DateTime> timeEnd;
  const SessionsCompanion({
    this.id = const Value.absent(),
    this.sessionNumber = const Value.absent(),
    this.participantId = const Value.absent(),
    this.timeStart = const Value.absent(),
    this.timeEnd = const Value.absent(),
  });
  SessionsCompanion.insert({
    this.id = const Value.absent(),
    required int sessionNumber,
    required String participantId,
    required DateTime timeStart,
    required DateTime timeEnd,
  })  : sessionNumber = Value(sessionNumber),
        participantId = Value(participantId),
        timeStart = Value(timeStart),
        timeEnd = Value(timeEnd);
  static Insertable<Session> custom({
    Expression<int>? id,
    Expression<int>? sessionNumber,
    Expression<String>? participantId,
    Expression<DateTime>? timeStart,
    Expression<DateTime>? timeEnd,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sessionNumber != null) 'session_number': sessionNumber,
      if (participantId != null) 'participant_id': participantId,
      if (timeStart != null) 'time_start': timeStart,
      if (timeEnd != null) 'time_end': timeEnd,
    });
  }

  SessionsCompanion copyWith(
      {Value<int>? id,
      Value<int>? sessionNumber,
      Value<String>? participantId,
      Value<DateTime>? timeStart,
      Value<DateTime>? timeEnd}) {
    return SessionsCompanion(
      id: id ?? this.id,
      sessionNumber: sessionNumber ?? this.sessionNumber,
      participantId: participantId ?? this.participantId,
      timeStart: timeStart ?? this.timeStart,
      timeEnd: timeEnd ?? this.timeEnd,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (sessionNumber.present) {
      map['session_number'] = Variable<int>(sessionNumber.value);
    }
    if (participantId.present) {
      map['participant_id'] = Variable<String>(participantId.value);
    }
    if (timeStart.present) {
      map['time_start'] = Variable<DateTime>(timeStart.value);
    }
    if (timeEnd.present) {
      map['time_end'] = Variable<DateTime>(timeEnd.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SessionsCompanion(')
          ..write('id: $id, ')
          ..write('sessionNumber: $sessionNumber, ')
          ..write('participantId: $participantId, ')
          ..write('timeStart: $timeStart, ')
          ..write('timeEnd: $timeEnd')
          ..write(')'))
        .toString();
  }
}

class $SessionsTable extends Sessions with TableInfo<$SessionsTable, Session> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SessionsTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _sessionNumberMeta =
      const VerificationMeta('sessionNumber');
  @override
  late final GeneratedColumn<int?> sessionNumber = GeneratedColumn<int?>(
      'session_number', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _participantIdMeta =
      const VerificationMeta('participantId');
  @override
  late final GeneratedColumn<String?> participantId = GeneratedColumn<String?>(
      'participant_id', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _timeStartMeta = const VerificationMeta('timeStart');
  @override
  late final GeneratedColumn<DateTime?> timeStart = GeneratedColumn<DateTime?>(
      'time_start', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _timeEndMeta = const VerificationMeta('timeEnd');
  @override
  late final GeneratedColumn<DateTime?> timeEnd = GeneratedColumn<DateTime?>(
      'time_end', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, sessionNumber, participantId, timeStart, timeEnd];
  @override
  String get aliasedName => _alias ?? 'sessions';
  @override
  String get actualTableName => 'sessions';
  @override
  VerificationContext validateIntegrity(Insertable<Session> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('session_number')) {
      context.handle(
          _sessionNumberMeta,
          sessionNumber.isAcceptableOrUnknown(
              data['session_number']!, _sessionNumberMeta));
    } else if (isInserting) {
      context.missing(_sessionNumberMeta);
    }
    if (data.containsKey('participant_id')) {
      context.handle(
          _participantIdMeta,
          participantId.isAcceptableOrUnknown(
              data['participant_id']!, _participantIdMeta));
    } else if (isInserting) {
      context.missing(_participantIdMeta);
    }
    if (data.containsKey('time_start')) {
      context.handle(_timeStartMeta,
          timeStart.isAcceptableOrUnknown(data['time_start']!, _timeStartMeta));
    } else if (isInserting) {
      context.missing(_timeStartMeta);
    }
    if (data.containsKey('time_end')) {
      context.handle(_timeEndMeta,
          timeEnd.isAcceptableOrUnknown(data['time_end']!, _timeEndMeta));
    } else if (isInserting) {
      context.missing(_timeEndMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Session map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Session.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $SessionsTable createAlias(String alias) {
    return $SessionsTable(attachedDatabase, alias);
  }
}

class Trial extends DataClass implements Insertable<Trial> {
  final int id;
  final String participantId;
  final String stim;
  final String resp;
  final int sessionNumber;
  Trial(
      {required this.id,
      required this.participantId,
      required this.stim,
      required this.resp,
      required this.sessionNumber});
  factory Trial.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Trial(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      participantId: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}participant_id'])!,
      stim: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}stim'])!,
      resp: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}resp'])!,
      sessionNumber: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}session_number'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['participant_id'] = Variable<String>(participantId);
    map['stim'] = Variable<String>(stim);
    map['resp'] = Variable<String>(resp);
    map['session_number'] = Variable<int>(sessionNumber);
    return map;
  }

  TrialsCompanion toCompanion(bool nullToAbsent) {
    return TrialsCompanion(
      id: Value(id),
      participantId: Value(participantId),
      stim: Value(stim),
      resp: Value(resp),
      sessionNumber: Value(sessionNumber),
    );
  }

  factory Trial.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Trial(
      id: serializer.fromJson<int>(json['id']),
      participantId: serializer.fromJson<String>(json['participantId']),
      stim: serializer.fromJson<String>(json['stim']),
      resp: serializer.fromJson<String>(json['resp']),
      sessionNumber: serializer.fromJson<int>(json['sessionNumber']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'participantId': serializer.toJson<String>(participantId),
      'stim': serializer.toJson<String>(stim),
      'resp': serializer.toJson<String>(resp),
      'sessionNumber': serializer.toJson<int>(sessionNumber),
    };
  }

  Trial copyWith(
          {int? id,
          String? participantId,
          String? stim,
          String? resp,
          int? sessionNumber}) =>
      Trial(
        id: id ?? this.id,
        participantId: participantId ?? this.participantId,
        stim: stim ?? this.stim,
        resp: resp ?? this.resp,
        sessionNumber: sessionNumber ?? this.sessionNumber,
      );
  @override
  String toString() {
    return (StringBuffer('Trial(')
          ..write('id: $id, ')
          ..write('participantId: $participantId, ')
          ..write('stim: $stim, ')
          ..write('resp: $resp, ')
          ..write('sessionNumber: $sessionNumber')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, participantId, stim, resp, sessionNumber);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Trial &&
          other.id == this.id &&
          other.participantId == this.participantId &&
          other.stim == this.stim &&
          other.resp == this.resp &&
          other.sessionNumber == this.sessionNumber);
}

class TrialsCompanion extends UpdateCompanion<Trial> {
  final Value<int> id;
  final Value<String> participantId;
  final Value<String> stim;
  final Value<String> resp;
  final Value<int> sessionNumber;
  const TrialsCompanion({
    this.id = const Value.absent(),
    this.participantId = const Value.absent(),
    this.stim = const Value.absent(),
    this.resp = const Value.absent(),
    this.sessionNumber = const Value.absent(),
  });
  TrialsCompanion.insert({
    this.id = const Value.absent(),
    required String participantId,
    required String stim,
    required String resp,
    required int sessionNumber,
  })  : participantId = Value(participantId),
        stim = Value(stim),
        resp = Value(resp),
        sessionNumber = Value(sessionNumber);
  static Insertable<Trial> custom({
    Expression<int>? id,
    Expression<String>? participantId,
    Expression<String>? stim,
    Expression<String>? resp,
    Expression<int>? sessionNumber,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (participantId != null) 'participant_id': participantId,
      if (stim != null) 'stim': stim,
      if (resp != null) 'resp': resp,
      if (sessionNumber != null) 'session_number': sessionNumber,
    });
  }

  TrialsCompanion copyWith(
      {Value<int>? id,
      Value<String>? participantId,
      Value<String>? stim,
      Value<String>? resp,
      Value<int>? sessionNumber}) {
    return TrialsCompanion(
      id: id ?? this.id,
      participantId: participantId ?? this.participantId,
      stim: stim ?? this.stim,
      resp: resp ?? this.resp,
      sessionNumber: sessionNumber ?? this.sessionNumber,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (participantId.present) {
      map['participant_id'] = Variable<String>(participantId.value);
    }
    if (stim.present) {
      map['stim'] = Variable<String>(stim.value);
    }
    if (resp.present) {
      map['resp'] = Variable<String>(resp.value);
    }
    if (sessionNumber.present) {
      map['session_number'] = Variable<int>(sessionNumber.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TrialsCompanion(')
          ..write('id: $id, ')
          ..write('participantId: $participantId, ')
          ..write('stim: $stim, ')
          ..write('resp: $resp, ')
          ..write('sessionNumber: $sessionNumber')
          ..write(')'))
        .toString();
  }
}

class $TrialsTable extends Trials with TableInfo<$TrialsTable, Trial> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TrialsTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _participantIdMeta =
      const VerificationMeta('participantId');
  @override
  late final GeneratedColumn<String?> participantId = GeneratedColumn<String?>(
      'participant_id', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _stimMeta = const VerificationMeta('stim');
  @override
  late final GeneratedColumn<String?> stim = GeneratedColumn<String?>(
      'stim', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _respMeta = const VerificationMeta('resp');
  @override
  late final GeneratedColumn<String?> resp = GeneratedColumn<String?>(
      'resp', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _sessionNumberMeta =
      const VerificationMeta('sessionNumber');
  @override
  late final GeneratedColumn<int?> sessionNumber = GeneratedColumn<int?>(
      'session_number', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: true,
      defaultConstraints: 'REFERENCES sessions (session_number)');
  @override
  List<GeneratedColumn> get $columns =>
      [id, participantId, stim, resp, sessionNumber];
  @override
  String get aliasedName => _alias ?? 'trials';
  @override
  String get actualTableName => 'trials';
  @override
  VerificationContext validateIntegrity(Insertable<Trial> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('participant_id')) {
      context.handle(
          _participantIdMeta,
          participantId.isAcceptableOrUnknown(
              data['participant_id']!, _participantIdMeta));
    } else if (isInserting) {
      context.missing(_participantIdMeta);
    }
    if (data.containsKey('stim')) {
      context.handle(
          _stimMeta, stim.isAcceptableOrUnknown(data['stim']!, _stimMeta));
    } else if (isInserting) {
      context.missing(_stimMeta);
    }
    if (data.containsKey('resp')) {
      context.handle(
          _respMeta, resp.isAcceptableOrUnknown(data['resp']!, _respMeta));
    } else if (isInserting) {
      context.missing(_respMeta);
    }
    if (data.containsKey('session_number')) {
      context.handle(
          _sessionNumberMeta,
          sessionNumber.isAcceptableOrUnknown(
              data['session_number']!, _sessionNumberMeta));
    } else if (isInserting) {
      context.missing(_sessionNumberMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Trial map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Trial.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $TrialsTable createAlias(String alias) {
    return $TrialsTable(attachedDatabase, alias);
  }
}

class Device extends DataClass implements Insertable<Device> {
  final int id;
  final String participantId;
  final String platform;
  final double height;
  final double width;
  final double aspectRatio;
  final int sessionNumber;
  Device(
      {required this.id,
      required this.participantId,
      required this.platform,
      required this.height,
      required this.width,
      required this.aspectRatio,
      required this.sessionNumber});
  factory Device.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Device(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      participantId: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}participant_id'])!,
      platform: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}platform'])!,
      height: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}height'])!,
      width: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}width'])!,
      aspectRatio: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}aspect_ratio'])!,
      sessionNumber: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}session_number'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['participant_id'] = Variable<String>(participantId);
    map['platform'] = Variable<String>(platform);
    map['height'] = Variable<double>(height);
    map['width'] = Variable<double>(width);
    map['aspect_ratio'] = Variable<double>(aspectRatio);
    map['session_number'] = Variable<int>(sessionNumber);
    return map;
  }

  DevicesCompanion toCompanion(bool nullToAbsent) {
    return DevicesCompanion(
      id: Value(id),
      participantId: Value(participantId),
      platform: Value(platform),
      height: Value(height),
      width: Value(width),
      aspectRatio: Value(aspectRatio),
      sessionNumber: Value(sessionNumber),
    );
  }

  factory Device.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Device(
      id: serializer.fromJson<int>(json['id']),
      participantId: serializer.fromJson<String>(json['participantId']),
      platform: serializer.fromJson<String>(json['platform']),
      height: serializer.fromJson<double>(json['height']),
      width: serializer.fromJson<double>(json['width']),
      aspectRatio: serializer.fromJson<double>(json['aspectRatio']),
      sessionNumber: serializer.fromJson<int>(json['sessionNumber']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'participantId': serializer.toJson<String>(participantId),
      'platform': serializer.toJson<String>(platform),
      'height': serializer.toJson<double>(height),
      'width': serializer.toJson<double>(width),
      'aspectRatio': serializer.toJson<double>(aspectRatio),
      'sessionNumber': serializer.toJson<int>(sessionNumber),
    };
  }

  Device copyWith(
          {int? id,
          String? participantId,
          String? platform,
          double? height,
          double? width,
          double? aspectRatio,
          int? sessionNumber}) =>
      Device(
        id: id ?? this.id,
        participantId: participantId ?? this.participantId,
        platform: platform ?? this.platform,
        height: height ?? this.height,
        width: width ?? this.width,
        aspectRatio: aspectRatio ?? this.aspectRatio,
        sessionNumber: sessionNumber ?? this.sessionNumber,
      );
  @override
  String toString() {
    return (StringBuffer('Device(')
          ..write('id: $id, ')
          ..write('participantId: $participantId, ')
          ..write('platform: $platform, ')
          ..write('height: $height, ')
          ..write('width: $width, ')
          ..write('aspectRatio: $aspectRatio, ')
          ..write('sessionNumber: $sessionNumber')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, participantId, platform, height, width, aspectRatio, sessionNumber);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Device &&
          other.id == this.id &&
          other.participantId == this.participantId &&
          other.platform == this.platform &&
          other.height == this.height &&
          other.width == this.width &&
          other.aspectRatio == this.aspectRatio &&
          other.sessionNumber == this.sessionNumber);
}

class DevicesCompanion extends UpdateCompanion<Device> {
  final Value<int> id;
  final Value<String> participantId;
  final Value<String> platform;
  final Value<double> height;
  final Value<double> width;
  final Value<double> aspectRatio;
  final Value<int> sessionNumber;
  const DevicesCompanion({
    this.id = const Value.absent(),
    this.participantId = const Value.absent(),
    this.platform = const Value.absent(),
    this.height = const Value.absent(),
    this.width = const Value.absent(),
    this.aspectRatio = const Value.absent(),
    this.sessionNumber = const Value.absent(),
  });
  DevicesCompanion.insert({
    this.id = const Value.absent(),
    required String participantId,
    this.platform = const Value.absent(),
    this.height = const Value.absent(),
    this.width = const Value.absent(),
    this.aspectRatio = const Value.absent(),
    required int sessionNumber,
  })  : participantId = Value(participantId),
        sessionNumber = Value(sessionNumber);
  static Insertable<Device> custom({
    Expression<int>? id,
    Expression<String>? participantId,
    Expression<String>? platform,
    Expression<double>? height,
    Expression<double>? width,
    Expression<double>? aspectRatio,
    Expression<int>? sessionNumber,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (participantId != null) 'participant_id': participantId,
      if (platform != null) 'platform': platform,
      if (height != null) 'height': height,
      if (width != null) 'width': width,
      if (aspectRatio != null) 'aspect_ratio': aspectRatio,
      if (sessionNumber != null) 'session_number': sessionNumber,
    });
  }

  DevicesCompanion copyWith(
      {Value<int>? id,
      Value<String>? participantId,
      Value<String>? platform,
      Value<double>? height,
      Value<double>? width,
      Value<double>? aspectRatio,
      Value<int>? sessionNumber}) {
    return DevicesCompanion(
      id: id ?? this.id,
      participantId: participantId ?? this.participantId,
      platform: platform ?? this.platform,
      height: height ?? this.height,
      width: width ?? this.width,
      aspectRatio: aspectRatio ?? this.aspectRatio,
      sessionNumber: sessionNumber ?? this.sessionNumber,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (participantId.present) {
      map['participant_id'] = Variable<String>(participantId.value);
    }
    if (platform.present) {
      map['platform'] = Variable<String>(platform.value);
    }
    if (height.present) {
      map['height'] = Variable<double>(height.value);
    }
    if (width.present) {
      map['width'] = Variable<double>(width.value);
    }
    if (aspectRatio.present) {
      map['aspect_ratio'] = Variable<double>(aspectRatio.value);
    }
    if (sessionNumber.present) {
      map['session_number'] = Variable<int>(sessionNumber.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DevicesCompanion(')
          ..write('id: $id, ')
          ..write('participantId: $participantId, ')
          ..write('platform: $platform, ')
          ..write('height: $height, ')
          ..write('width: $width, ')
          ..write('aspectRatio: $aspectRatio, ')
          ..write('sessionNumber: $sessionNumber')
          ..write(')'))
        .toString();
  }
}

class $DevicesTable extends Devices with TableInfo<$DevicesTable, Device> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DevicesTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _participantIdMeta =
      const VerificationMeta('participantId');
  @override
  late final GeneratedColumn<String?> participantId = GeneratedColumn<String?>(
      'participant_id', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _platformMeta = const VerificationMeta('platform');
  @override
  late final GeneratedColumn<String?> platform = GeneratedColumn<String?>(
      'platform', aliasedName, false,
      type: const StringType(),
      requiredDuringInsert: false,
      defaultValue: Constant(getPlatform()));
  final VerificationMeta _heightMeta = const VerificationMeta('height');
  @override
  late final GeneratedColumn<double?> height = GeneratedColumn<double?>(
      'height', aliasedName, false,
      type: const RealType(),
      requiredDuringInsert: false,
      defaultValue: Constant(getHeight));
  final VerificationMeta _widthMeta = const VerificationMeta('width');
  @override
  late final GeneratedColumn<double?> width = GeneratedColumn<double?>(
      'width', aliasedName, false,
      type: const RealType(),
      requiredDuringInsert: false,
      defaultValue: Constant(getWidth));
  final VerificationMeta _aspectRatioMeta =
      const VerificationMeta('aspectRatio');
  @override
  late final GeneratedColumn<double?> aspectRatio = GeneratedColumn<double?>(
      'aspect_ratio', aliasedName, false,
      type: const RealType(),
      requiredDuringInsert: false,
      defaultValue: Constant(getAspectRatio));
  final VerificationMeta _sessionNumberMeta =
      const VerificationMeta('sessionNumber');
  @override
  late final GeneratedColumn<int?> sessionNumber = GeneratedColumn<int?>(
      'session_number', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: true,
      defaultConstraints: 'REFERENCES sessions (session_number)');
  @override
  List<GeneratedColumn> get $columns =>
      [id, participantId, platform, height, width, aspectRatio, sessionNumber];
  @override
  String get aliasedName => _alias ?? 'devices';
  @override
  String get actualTableName => 'devices';
  @override
  VerificationContext validateIntegrity(Insertable<Device> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('participant_id')) {
      context.handle(
          _participantIdMeta,
          participantId.isAcceptableOrUnknown(
              data['participant_id']!, _participantIdMeta));
    } else if (isInserting) {
      context.missing(_participantIdMeta);
    }
    if (data.containsKey('platform')) {
      context.handle(_platformMeta,
          platform.isAcceptableOrUnknown(data['platform']!, _platformMeta));
    }
    if (data.containsKey('height')) {
      context.handle(_heightMeta,
          height.isAcceptableOrUnknown(data['height']!, _heightMeta));
    }
    if (data.containsKey('width')) {
      context.handle(
          _widthMeta, width.isAcceptableOrUnknown(data['width']!, _widthMeta));
    }
    if (data.containsKey('aspect_ratio')) {
      context.handle(
          _aspectRatioMeta,
          aspectRatio.isAcceptableOrUnknown(
              data['aspect_ratio']!, _aspectRatioMeta));
    }
    if (data.containsKey('session_number')) {
      context.handle(
          _sessionNumberMeta,
          sessionNumber.isAcceptableOrUnknown(
              data['session_number']!, _sessionNumberMeta));
    } else if (isInserting) {
      context.missing(_sessionNumberMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Device map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Device.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $DevicesTable createAlias(String alias) {
    return $DevicesTable(attachedDatabase, alias);
  }
}

abstract class _$DataBase extends GeneratedDatabase {
  _$DataBase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $SessionsTable sessions = $SessionsTable(this);
  late final $TrialsTable trials = $TrialsTable(this);
  late final $DevicesTable devices = $DevicesTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [sessions, trials, devices];
}
