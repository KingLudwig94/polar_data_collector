// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: type=lint
class HRData extends DataClass implements Insertable<HRData> {
  final int? id;
  final DateTime time;
  final int value;
  HRData({this.id, required this.time, required this.value});
  factory HRData.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return HRData(
      id: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}id']),
      time: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}time'])!,
      value: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}value'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int?>(id);
    }
    map['time'] = Variable<DateTime>(time);
    map['value'] = Variable<int>(value);
    return map;
  }

  HRCompanion toCompanion(bool nullToAbsent) {
    return HRCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      time: Value(time),
      value: Value(value),
    );
  }

  factory HRData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return HRData(
      id: serializer.fromJson<int?>(json['id']),
      time: serializer.fromJson<DateTime>(json['time']),
      value: serializer.fromJson<int>(json['value']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'time': serializer.toJson<DateTime>(time),
      'value': serializer.toJson<int>(value),
    };
  }

  HRData copyWith({int? id, DateTime? time, int? value}) => HRData(
        id: id ?? this.id,
        time: time ?? this.time,
        value: value ?? this.value,
      );
  @override
  String toString() {
    return (StringBuffer('HRData(')
          ..write('id: $id, ')
          ..write('time: $time, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, time, value);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HRData &&
          other.id == this.id &&
          other.time == this.time &&
          other.value == this.value);
}

class HRCompanion extends UpdateCompanion<HRData> {
  final Value<int?> id;
  final Value<DateTime> time;
  final Value<int> value;
  const HRCompanion({
    this.id = const Value.absent(),
    this.time = const Value.absent(),
    this.value = const Value.absent(),
  });
  HRCompanion.insert({
    this.id = const Value.absent(),
    required DateTime time,
    required int value,
  })  : time = Value(time),
        value = Value(value);
  static Insertable<HRData> custom({
    Expression<int?>? id,
    Expression<DateTime>? time,
    Expression<int>? value,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (time != null) 'time': time,
      if (value != null) 'value': value,
    });
  }

  HRCompanion copyWith(
      {Value<int?>? id, Value<DateTime>? time, Value<int>? value}) {
    return HRCompanion(
      id: id ?? this.id,
      time: time ?? this.time,
      value: value ?? this.value,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int?>(id.value);
    }
    if (time.present) {
      map['time'] = Variable<DateTime>(time.value);
    }
    if (value.present) {
      map['value'] = Variable<int>(value.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HRCompanion(')
          ..write('id: $id, ')
          ..write('time: $time, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }
}

class $HRTable extends HR with TableInfo<$HRTable, HRData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HRTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, true,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _timeMeta = const VerificationMeta('time');
  @override
  late final GeneratedColumn<DateTime?> time = GeneratedColumn<DateTime?>(
      'time', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<int?> value = GeneratedColumn<int?>(
      'value', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, time, value];
  @override
  String get aliasedName => _alias ?? 'hr';
  @override
  String get actualTableName => 'hr';
  @override
  VerificationContext validateIntegrity(Insertable<HRData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('time')) {
      context.handle(
          _timeMeta, time.isAcceptableOrUnknown(data['time']!, _timeMeta));
    } else if (isInserting) {
      context.missing(_timeMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
          _valueMeta, value.isAcceptableOrUnknown(data['value']!, _valueMeta));
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  HRData map(Map<String, dynamic> data, {String? tablePrefix}) {
    return HRData.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $HRTable createAlias(String alias) {
    return $HRTable(attachedDatabase, alias);
  }
}

class PPGData extends DataClass implements Insertable<PPGData> {
  final int? id;
  final int time;
  final int first;
  final int second;
  final int third;
  final int ambient;
  PPGData(
      {this.id,
      required this.time,
      required this.first,
      required this.second,
      required this.third,
      required this.ambient});
  factory PPGData.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return PPGData(
      id: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}id']),
      time: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}time'])!,
      first: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}first'])!,
      second: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}second'])!,
      third: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}third'])!,
      ambient: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}ambient'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int?>(id);
    }
    map['time'] = Variable<int>(time);
    map['first'] = Variable<int>(first);
    map['second'] = Variable<int>(second);
    map['third'] = Variable<int>(third);
    map['ambient'] = Variable<int>(ambient);
    return map;
  }

  PPGCompanion toCompanion(bool nullToAbsent) {
    return PPGCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      time: Value(time),
      first: Value(first),
      second: Value(second),
      third: Value(third),
      ambient: Value(ambient),
    );
  }

  factory PPGData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PPGData(
      id: serializer.fromJson<int?>(json['id']),
      time: serializer.fromJson<int>(json['time']),
      first: serializer.fromJson<int>(json['first']),
      second: serializer.fromJson<int>(json['second']),
      third: serializer.fromJson<int>(json['third']),
      ambient: serializer.fromJson<int>(json['ambient']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'time': serializer.toJson<int>(time),
      'first': serializer.toJson<int>(first),
      'second': serializer.toJson<int>(second),
      'third': serializer.toJson<int>(third),
      'ambient': serializer.toJson<int>(ambient),
    };
  }

  PPGData copyWith(
          {int? id,
          int? time,
          int? first,
          int? second,
          int? third,
          int? ambient}) =>
      PPGData(
        id: id ?? this.id,
        time: time ?? this.time,
        first: first ?? this.first,
        second: second ?? this.second,
        third: third ?? this.third,
        ambient: ambient ?? this.ambient,
      );
  @override
  String toString() {
    return (StringBuffer('PPGData(')
          ..write('id: $id, ')
          ..write('time: $time, ')
          ..write('first: $first, ')
          ..write('second: $second, ')
          ..write('third: $third, ')
          ..write('ambient: $ambient')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, time, first, second, third, ambient);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PPGData &&
          other.id == this.id &&
          other.time == this.time &&
          other.first == this.first &&
          other.second == this.second &&
          other.third == this.third &&
          other.ambient == this.ambient);
}

class PPGCompanion extends UpdateCompanion<PPGData> {
  final Value<int?> id;
  final Value<int> time;
  final Value<int> first;
  final Value<int> second;
  final Value<int> third;
  final Value<int> ambient;
  const PPGCompanion({
    this.id = const Value.absent(),
    this.time = const Value.absent(),
    this.first = const Value.absent(),
    this.second = const Value.absent(),
    this.third = const Value.absent(),
    this.ambient = const Value.absent(),
  });
  PPGCompanion.insert({
    this.id = const Value.absent(),
    required int time,
    required int first,
    required int second,
    required int third,
    required int ambient,
  })  : time = Value(time),
        first = Value(first),
        second = Value(second),
        third = Value(third),
        ambient = Value(ambient);
  static Insertable<PPGData> custom({
    Expression<int?>? id,
    Expression<int>? time,
    Expression<int>? first,
    Expression<int>? second,
    Expression<int>? third,
    Expression<int>? ambient,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (time != null) 'time': time,
      if (first != null) 'first': first,
      if (second != null) 'second': second,
      if (third != null) 'third': third,
      if (ambient != null) 'ambient': ambient,
    });
  }

  PPGCompanion copyWith(
      {Value<int?>? id,
      Value<int>? time,
      Value<int>? first,
      Value<int>? second,
      Value<int>? third,
      Value<int>? ambient}) {
    return PPGCompanion(
      id: id ?? this.id,
      time: time ?? this.time,
      first: first ?? this.first,
      second: second ?? this.second,
      third: third ?? this.third,
      ambient: ambient ?? this.ambient,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int?>(id.value);
    }
    if (time.present) {
      map['time'] = Variable<int>(time.value);
    }
    if (first.present) {
      map['first'] = Variable<int>(first.value);
    }
    if (second.present) {
      map['second'] = Variable<int>(second.value);
    }
    if (third.present) {
      map['third'] = Variable<int>(third.value);
    }
    if (ambient.present) {
      map['ambient'] = Variable<int>(ambient.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PPGCompanion(')
          ..write('id: $id, ')
          ..write('time: $time, ')
          ..write('first: $first, ')
          ..write('second: $second, ')
          ..write('third: $third, ')
          ..write('ambient: $ambient')
          ..write(')'))
        .toString();
  }
}

class $PPGTable extends PPG with TableInfo<$PPGTable, PPGData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PPGTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, true,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _timeMeta = const VerificationMeta('time');
  @override
  late final GeneratedColumn<int?> time = GeneratedColumn<int?>(
      'time', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _firstMeta = const VerificationMeta('first');
  @override
  late final GeneratedColumn<int?> first = GeneratedColumn<int?>(
      'first', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _secondMeta = const VerificationMeta('second');
  @override
  late final GeneratedColumn<int?> second = GeneratedColumn<int?>(
      'second', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _thirdMeta = const VerificationMeta('third');
  @override
  late final GeneratedColumn<int?> third = GeneratedColumn<int?>(
      'third', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _ambientMeta = const VerificationMeta('ambient');
  @override
  late final GeneratedColumn<int?> ambient = GeneratedColumn<int?>(
      'ambient', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, time, first, second, third, ambient];
  @override
  String get aliasedName => _alias ?? 'ppg';
  @override
  String get actualTableName => 'ppg';
  @override
  VerificationContext validateIntegrity(Insertable<PPGData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('time')) {
      context.handle(
          _timeMeta, time.isAcceptableOrUnknown(data['time']!, _timeMeta));
    } else if (isInserting) {
      context.missing(_timeMeta);
    }
    if (data.containsKey('first')) {
      context.handle(
          _firstMeta, first.isAcceptableOrUnknown(data['first']!, _firstMeta));
    } else if (isInserting) {
      context.missing(_firstMeta);
    }
    if (data.containsKey('second')) {
      context.handle(_secondMeta,
          second.isAcceptableOrUnknown(data['second']!, _secondMeta));
    } else if (isInserting) {
      context.missing(_secondMeta);
    }
    if (data.containsKey('third')) {
      context.handle(
          _thirdMeta, third.isAcceptableOrUnknown(data['third']!, _thirdMeta));
    } else if (isInserting) {
      context.missing(_thirdMeta);
    }
    if (data.containsKey('ambient')) {
      context.handle(_ambientMeta,
          ambient.isAcceptableOrUnknown(data['ambient']!, _ambientMeta));
    } else if (isInserting) {
      context.missing(_ambientMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PPGData map(Map<String, dynamic> data, {String? tablePrefix}) {
    return PPGData.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $PPGTable createAlias(String alias) {
    return $PPGTable(attachedDatabase, alias);
  }
}

class ECGData extends DataClass implements Insertable<ECGData> {
  final int? id;
  final int time;
  final int value;
  ECGData({this.id, required this.time, required this.value});
  factory ECGData.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return ECGData(
      id: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}id']),
      time: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}time'])!,
      value: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}value'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int?>(id);
    }
    map['time'] = Variable<int>(time);
    map['value'] = Variable<int>(value);
    return map;
  }

  ECGCompanion toCompanion(bool nullToAbsent) {
    return ECGCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      time: Value(time),
      value: Value(value),
    );
  }

  factory ECGData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ECGData(
      id: serializer.fromJson<int?>(json['id']),
      time: serializer.fromJson<int>(json['time']),
      value: serializer.fromJson<int>(json['value']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'time': serializer.toJson<int>(time),
      'value': serializer.toJson<int>(value),
    };
  }

  ECGData copyWith({int? id, int? time, int? value}) => ECGData(
        id: id ?? this.id,
        time: time ?? this.time,
        value: value ?? this.value,
      );
  @override
  String toString() {
    return (StringBuffer('ECGData(')
          ..write('id: $id, ')
          ..write('time: $time, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, time, value);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ECGData &&
          other.id == this.id &&
          other.time == this.time &&
          other.value == this.value);
}

class ECGCompanion extends UpdateCompanion<ECGData> {
  final Value<int?> id;
  final Value<int> time;
  final Value<int> value;
  const ECGCompanion({
    this.id = const Value.absent(),
    this.time = const Value.absent(),
    this.value = const Value.absent(),
  });
  ECGCompanion.insert({
    this.id = const Value.absent(),
    required int time,
    required int value,
  })  : time = Value(time),
        value = Value(value);
  static Insertable<ECGData> custom({
    Expression<int?>? id,
    Expression<int>? time,
    Expression<int>? value,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (time != null) 'time': time,
      if (value != null) 'value': value,
    });
  }

  ECGCompanion copyWith(
      {Value<int?>? id, Value<int>? time, Value<int>? value}) {
    return ECGCompanion(
      id: id ?? this.id,
      time: time ?? this.time,
      value: value ?? this.value,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int?>(id.value);
    }
    if (time.present) {
      map['time'] = Variable<int>(time.value);
    }
    if (value.present) {
      map['value'] = Variable<int>(value.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ECGCompanion(')
          ..write('id: $id, ')
          ..write('time: $time, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }
}

class $ECGTable extends ECG with TableInfo<$ECGTable, ECGData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ECGTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, true,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _timeMeta = const VerificationMeta('time');
  @override
  late final GeneratedColumn<int?> time = GeneratedColumn<int?>(
      'time', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<int?> value = GeneratedColumn<int?>(
      'value', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, time, value];
  @override
  String get aliasedName => _alias ?? 'ecg';
  @override
  String get actualTableName => 'ecg';
  @override
  VerificationContext validateIntegrity(Insertable<ECGData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('time')) {
      context.handle(
          _timeMeta, time.isAcceptableOrUnknown(data['time']!, _timeMeta));
    } else if (isInserting) {
      context.missing(_timeMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
          _valueMeta, value.isAcceptableOrUnknown(data['value']!, _valueMeta));
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ECGData map(Map<String, dynamic> data, {String? tablePrefix}) {
    return ECGData.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $ECGTable createAlias(String alias) {
    return $ECGTable(attachedDatabase, alias);
  }
}

abstract class _$MyDatabase extends GeneratedDatabase {
  _$MyDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $HRTable hr = $HRTable(this);
  late final $PPGTable ppg = $PPGTable(this);
  late final $ECGTable ecg = $ECGTable(this);
  late final HRDao hRDao = HRDao(this as MyDatabase);
  late final PPGDao pPGDao = PPGDao(this as MyDatabase);
  late final ECGDao eCGDao = ECGDao(this as MyDatabase);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [hr, ppg, ecg];
}
