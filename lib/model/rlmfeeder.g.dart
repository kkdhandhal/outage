// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rlmfeeder.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

class rlmfeeder extends _rlmfeeder
    with RealmEntity, RealmObjectBase, RealmObject {
  rlmfeeder(
    int fdr_code,
    int fdr_loccode,
    int fdr_adm_sdn,
    String fdr_type,
    String fdr_name,
    String fdr_category,
    int fdr_cons,
  ) {
    RealmObjectBase.set(this, 'fdr_code', fdr_code);
    RealmObjectBase.set(this, 'fdr_loccode', fdr_loccode);
    RealmObjectBase.set(this, 'fdr_adm_sdn', fdr_adm_sdn);
    RealmObjectBase.set(this, 'fdr_type', fdr_type);
    RealmObjectBase.set(this, 'fdr_name', fdr_name);
    RealmObjectBase.set(this, 'fdr_category', fdr_category);
    RealmObjectBase.set(this, 'fdr_cons', fdr_cons);
  }

  rlmfeeder._();

  @override
  int get fdr_code => RealmObjectBase.get<int>(this, 'fdr_code') as int;
  @override
  set fdr_code(int value) => throw RealmUnsupportedSetError();

  @override
  int get fdr_loccode => RealmObjectBase.get<int>(this, 'fdr_loccode') as int;
  @override
  set fdr_loccode(int value) => throw RealmUnsupportedSetError();

  @override
  int get fdr_adm_sdn => RealmObjectBase.get<int>(this, 'fdr_adm_sdn') as int;
  @override
  set fdr_adm_sdn(int value) => throw RealmUnsupportedSetError();

  @override
  String get fdr_type =>
      RealmObjectBase.get<String>(this, 'fdr_type') as String;
  @override
  set fdr_type(String value) => throw RealmUnsupportedSetError();

  @override
  String get fdr_name =>
      RealmObjectBase.get<String>(this, 'fdr_name') as String;
  @override
  set fdr_name(String value) => throw RealmUnsupportedSetError();

  @override
  String get fdr_category =>
      RealmObjectBase.get<String>(this, 'fdr_category') as String;
  @override
  set fdr_category(String value) => throw RealmUnsupportedSetError();

  @override
  int get fdr_cons => RealmObjectBase.get<int>(this, 'fdr_cons') as int;
  @override
  set fdr_cons(int value) => throw RealmUnsupportedSetError();

  @override
  Stream<RealmObjectChanges<rlmfeeder>> get changes =>
      RealmObjectBase.getChanges<rlmfeeder>(this);

  @override
  rlmfeeder freeze() => RealmObjectBase.freezeObject<rlmfeeder>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(rlmfeeder._);
    return const SchemaObject(ObjectType.realmObject, rlmfeeder, 'rlmfeeder', [
      SchemaProperty('fdr_code', RealmPropertyType.int, primaryKey: true),
      SchemaProperty('fdr_loccode', RealmPropertyType.int),
      SchemaProperty('fdr_adm_sdn', RealmPropertyType.int),
      SchemaProperty('fdr_type', RealmPropertyType.string),
      SchemaProperty('fdr_name', RealmPropertyType.string),
      SchemaProperty('fdr_category', RealmPropertyType.string),
      SchemaProperty('fdr_cons', RealmPropertyType.int),
    ]);
  }
}
