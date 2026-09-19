/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member
// ignore_for_file: dead_code, unnecessary_type_check

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:mavuno_client/src/protocol/alerts/farm_alert.dart' as _i4cxyxim;
import 'package:mavuno_client/src/protocol/farm/farm.dart' as _i3h50elb;
import 'package:mavuno_client/src/protocol/feed/feed_record.dart' as _i1ionl62;
import 'package:mavuno_client/src/protocol/health/health_record.dart'
    as _il2jtq63;
import 'package:mavuno_client/src/protocol/health/vaccination_record.dart'
    as _i5l0l30f;
import 'package:mavuno_client/src/protocol/livestock/animal.dart' as _ihm4hxbr;
import 'package:mavuno_client/src/protocol/observations/animal_observation.dart'
    as _imy277ev;
import 'package:mavuno_client/src/protocol/production/production_record.dart'
    as _ir2h89uc;
import 'package:mavuno_client/src/protocol/tasks/farm_task.dart' as _iizfk1a5;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _iacc;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _iaic;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import 'alerts/alert_severity.dart' as _iu08z8uc;
import 'alerts/alert_type.dart' as _i3o8d7cu;
import 'alerts/farm_alert.dart' as _iokus4nq;
import 'demo/demo_seed_result.dart' as _i7olaciv;
import 'farm/farm.dart' as _iaxrkr2w;
import 'feed/feed_record.dart' as _i4r52dc7;
import 'greetings/greeting.dart' as _izw8z7ou;
import 'health/health_record.dart' as _ioxvgdwn;
import 'health/vaccination_record.dart' as _idmsc9k2;
import 'livestock/animal.dart' as _i1g50dlu;
import 'livestock/animal_sex.dart' as _igjjd0ss;
import 'livestock/animal_species.dart' as _ihlw5w94;
import 'livestock/animal_status.dart' as _irv9gm2j;
import 'observations/animal_observation.dart' as _i3jehzkb;
import 'production/production_record.dart' as _icnogur8;
import 'sentinel/risk_level.dart' as _inmi9ln2;
import 'sentinel/sentinel_assessment.dart' as _i5feeh1w;
import 'tasks/farm_task.dart' as _ivo8j1ja;
import 'tasks/task_priority.dart' as _ihh19m3v;
import 'tasks/task_status.dart' as _i65tv1la;
export 'alerts/alert_severity.dart';
export 'alerts/alert_type.dart';
export 'alerts/farm_alert.dart';
export 'demo/demo_seed_result.dart';
export 'farm/farm.dart';
export 'feed/feed_record.dart';
export 'greetings/greeting.dart';
export 'health/health_record.dart';
export 'health/vaccination_record.dart';
export 'livestock/animal.dart';
export 'livestock/animal_sex.dart';
export 'livestock/animal_species.dart';
export 'livestock/animal_status.dart';
export 'observations/animal_observation.dart';
export 'production/production_record.dart';
export 'sentinel/risk_level.dart';
export 'sentinel/sentinel_assessment.dart';
export 'tasks/farm_task.dart';
export 'tasks/task_priority.dart';
export 'tasks/task_status.dart';
export 'client.dart';

class Protocol extends _isc.SerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._().._registerHostProtocols();

  static String? getClassNameFromObjectJson(dynamic data) {
    if (data is! Map) return null;
    final className = data['__className__'] as String?;
    return className;
  }

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;

    final dataClassName = getClassNameFromObjectJson(data);
    if (dataClassName != null && dataClassName != getClassNameForType(t)) {
      try {
        return deserializeByClassName({
          'className': dataClassName,
          'data': data,
        });
      } on _isc.DeserializationClassNameNotFoundException catch (_) {
        // If the className is not recognized (e.g., older client receiving
        // data with a new subtype), fall back to deserializing without the
        // className, using the expected type T.
      }
    }

    if (t == _iu08z8uc.AlertSeverity) {
      return _iu08z8uc.AlertSeverity.fromJson(data) as T;
    }
    if (t == _i3o8d7cu.AlertType) {
      return _i3o8d7cu.AlertType.fromJson(data) as T;
    }
    if (t == _iokus4nq.FarmAlert) {
      return _iokus4nq.FarmAlert.fromJson(data) as T;
    }
    if (t == _i7olaciv.DemoSeedResult) {
      return _i7olaciv.DemoSeedResult.fromJson(data) as T;
    }
    if (t == _iaxrkr2w.Farm) {
      return _iaxrkr2w.Farm.fromJson(data) as T;
    }
    if (t == _i4r52dc7.FeedRecord) {
      return _i4r52dc7.FeedRecord.fromJson(data) as T;
    }
    if (t == _izw8z7ou.Greeting) {
      return _izw8z7ou.Greeting.fromJson(data) as T;
    }
    if (t == _ioxvgdwn.HealthRecord) {
      return _ioxvgdwn.HealthRecord.fromJson(data) as T;
    }
    if (t == _idmsc9k2.VaccinationRecord) {
      return _idmsc9k2.VaccinationRecord.fromJson(data) as T;
    }
    if (t == _i1g50dlu.Animal) {
      return _i1g50dlu.Animal.fromJson(data) as T;
    }
    if (t == _igjjd0ss.AnimalSex) {
      return _igjjd0ss.AnimalSex.fromJson(data) as T;
    }
    if (t == _ihlw5w94.AnimalSpecies) {
      return _ihlw5w94.AnimalSpecies.fromJson(data) as T;
    }
    if (t == _irv9gm2j.AnimalStatus) {
      return _irv9gm2j.AnimalStatus.fromJson(data) as T;
    }
    if (t == _i3jehzkb.AnimalObservation) {
      return _i3jehzkb.AnimalObservation.fromJson(data) as T;
    }
    if (t == _icnogur8.ProductionRecord) {
      return _icnogur8.ProductionRecord.fromJson(data) as T;
    }
    if (t == _inmi9ln2.RiskLevel) {
      return _inmi9ln2.RiskLevel.fromJson(data) as T;
    }
    if (t == _i5feeh1w.SentinelAssessment) {
      return _i5feeh1w.SentinelAssessment.fromJson(data) as T;
    }
    if (t == _ivo8j1ja.FarmTask) {
      return _ivo8j1ja.FarmTask.fromJson(data) as T;
    }
    if (t == _ihh19m3v.TaskPriority) {
      return _ihh19m3v.TaskPriority.fromJson(data) as T;
    }
    if (t == _i65tv1la.TaskStatus) {
      return _i65tv1la.TaskStatus.fromJson(data) as T;
    }
    if (t == _isc.getType<_iu08z8uc.AlertSeverity?>()) {
      return (data != null ? _iu08z8uc.AlertSeverity.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i3o8d7cu.AlertType?>()) {
      return (data != null ? _i3o8d7cu.AlertType.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_iokus4nq.FarmAlert?>()) {
      return (data != null ? _iokus4nq.FarmAlert.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i7olaciv.DemoSeedResult?>()) {
      return (data != null ? _i7olaciv.DemoSeedResult.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_iaxrkr2w.Farm?>()) {
      return (data != null ? _iaxrkr2w.Farm.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i4r52dc7.FeedRecord?>()) {
      return (data != null ? _i4r52dc7.FeedRecord.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_izw8z7ou.Greeting?>()) {
      return (data != null ? _izw8z7ou.Greeting.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ioxvgdwn.HealthRecord?>()) {
      return (data != null ? _ioxvgdwn.HealthRecord.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_idmsc9k2.VaccinationRecord?>()) {
      return (data != null ? _idmsc9k2.VaccinationRecord.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i1g50dlu.Animal?>()) {
      return (data != null ? _i1g50dlu.Animal.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_igjjd0ss.AnimalSex?>()) {
      return (data != null ? _igjjd0ss.AnimalSex.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ihlw5w94.AnimalSpecies?>()) {
      return (data != null ? _ihlw5w94.AnimalSpecies.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_irv9gm2j.AnimalStatus?>()) {
      return (data != null ? _irv9gm2j.AnimalStatus.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i3jehzkb.AnimalObservation?>()) {
      return (data != null ? _i3jehzkb.AnimalObservation.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_icnogur8.ProductionRecord?>()) {
      return (data != null ? _icnogur8.ProductionRecord.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_inmi9ln2.RiskLevel?>()) {
      return (data != null ? _inmi9ln2.RiskLevel.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i5feeh1w.SentinelAssessment?>()) {
      return (data != null ? _i5feeh1w.SentinelAssessment.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_ivo8j1ja.FarmTask?>()) {
      return (data != null ? _ivo8j1ja.FarmTask.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ihh19m3v.TaskPriority?>()) {
      return (data != null ? _ihh19m3v.TaskPriority.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i65tv1la.TaskStatus?>()) {
      return (data != null ? _i65tv1la.TaskStatus.fromJson(data) : null) as T;
    }
    if (t == List<_i4cxyxim.FarmAlert>) {
      return (data as List)
              .map((e) => deserialize<_i4cxyxim.FarmAlert>(e))
              .toList()
          as T;
    }
    if (t == List<_i3h50elb.Farm>) {
      return (data as List).map((e) => deserialize<_i3h50elb.Farm>(e)).toList()
          as T;
    }
    if (t == List<_i1ionl62.FeedRecord>) {
      return (data as List)
              .map((e) => deserialize<_i1ionl62.FeedRecord>(e))
              .toList()
          as T;
    }
    if (t == List<_il2jtq63.HealthRecord>) {
      return (data as List)
              .map((e) => deserialize<_il2jtq63.HealthRecord>(e))
              .toList()
          as T;
    }
    if (t == List<_i5l0l30f.VaccinationRecord>) {
      return (data as List)
              .map((e) => deserialize<_i5l0l30f.VaccinationRecord>(e))
              .toList()
          as T;
    }
    if (t == List<_ihm4hxbr.Animal>) {
      return (data as List)
              .map((e) => deserialize<_ihm4hxbr.Animal>(e))
              .toList()
          as T;
    }
    if (t == List<_imy277ev.AnimalObservation>) {
      return (data as List)
              .map((e) => deserialize<_imy277ev.AnimalObservation>(e))
              .toList()
          as T;
    }
    if (t == List<_ir2h89uc.ProductionRecord>) {
      return (data as List)
              .map((e) => deserialize<_ir2h89uc.ProductionRecord>(e))
              .toList()
          as T;
    }
    if (t == List<_iizfk1a5.FarmTask>) {
      return (data as List)
              .map((e) => deserialize<_iizfk1a5.FarmTask>(e))
              .toList()
          as T;
    }
    try {
      return _iaic.Protocol().deserialize<T>(data, t);
    } on _isc.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _iacc.Protocol().deserialize<T>(data, t);
    } on _isc.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _iu08z8uc.AlertSeverity => 'AlertSeverity',
      _i3o8d7cu.AlertType => 'AlertType',
      _iokus4nq.FarmAlert => 'FarmAlert',
      _i7olaciv.DemoSeedResult => 'DemoSeedResult',
      _iaxrkr2w.Farm => 'Farm',
      _i4r52dc7.FeedRecord => 'FeedRecord',
      _izw8z7ou.Greeting => 'Greeting',
      _ioxvgdwn.HealthRecord => 'HealthRecord',
      _idmsc9k2.VaccinationRecord => 'VaccinationRecord',
      _i1g50dlu.Animal => 'Animal',
      _igjjd0ss.AnimalSex => 'AnimalSex',
      _ihlw5w94.AnimalSpecies => 'AnimalSpecies',
      _irv9gm2j.AnimalStatus => 'AnimalStatus',
      _i3jehzkb.AnimalObservation => 'AnimalObservation',
      _icnogur8.ProductionRecord => 'ProductionRecord',
      _inmi9ln2.RiskLevel => 'RiskLevel',
      _i5feeh1w.SentinelAssessment => 'SentinelAssessment',
      _ivo8j1ja.FarmTask => 'FarmTask',
      _ihh19m3v.TaskPriority => 'TaskPriority',
      _i65tv1la.TaskStatus => 'TaskStatus',
      _ => null,
    };
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;

    if (data is Map<String, dynamic> && data['__className__'] is String) {
      return (data['__className__'] as String).replaceFirst('mavuno.', '');
    }

    switch (data) {
      case _iu08z8uc.AlertSeverity():
        return 'AlertSeverity';
      case _i3o8d7cu.AlertType():
        return 'AlertType';
      case _iokus4nq.FarmAlert():
        return 'FarmAlert';
      case _i7olaciv.DemoSeedResult():
        return 'DemoSeedResult';
      case _iaxrkr2w.Farm():
        return 'Farm';
      case _i4r52dc7.FeedRecord():
        return 'FeedRecord';
      case _izw8z7ou.Greeting():
        return 'Greeting';
      case _ioxvgdwn.HealthRecord():
        return 'HealthRecord';
      case _idmsc9k2.VaccinationRecord():
        return 'VaccinationRecord';
      case _i1g50dlu.Animal():
        return 'Animal';
      case _igjjd0ss.AnimalSex():
        return 'AnimalSex';
      case _ihlw5w94.AnimalSpecies():
        return 'AnimalSpecies';
      case _irv9gm2j.AnimalStatus():
        return 'AnimalStatus';
      case _i3jehzkb.AnimalObservation():
        return 'AnimalObservation';
      case _icnogur8.ProductionRecord():
        return 'ProductionRecord';
      case _inmi9ln2.RiskLevel():
        return 'RiskLevel';
      case _i5feeh1w.SentinelAssessment():
        return 'SentinelAssessment';
      case _ivo8j1ja.FarmTask():
        return 'FarmTask';
      case _ihh19m3v.TaskPriority():
        return 'TaskPriority';
      case _i65tv1la.TaskStatus():
        return 'TaskStatus';
    }
    className = _iaic.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_auth_idp.$className';
    }
    className = _iacc.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_auth_core.$className';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'AlertSeverity') {
      return deserialize<_iu08z8uc.AlertSeverity>(data['data']);
    }
    if (dataClassName == 'AlertType') {
      return deserialize<_i3o8d7cu.AlertType>(data['data']);
    }
    if (dataClassName == 'FarmAlert') {
      return deserialize<_iokus4nq.FarmAlert>(data['data']);
    }
    if (dataClassName == 'DemoSeedResult') {
      return deserialize<_i7olaciv.DemoSeedResult>(data['data']);
    }
    if (dataClassName == 'Farm') {
      return deserialize<_iaxrkr2w.Farm>(data['data']);
    }
    if (dataClassName == 'FeedRecord') {
      return deserialize<_i4r52dc7.FeedRecord>(data['data']);
    }
    if (dataClassName == 'Greeting') {
      return deserialize<_izw8z7ou.Greeting>(data['data']);
    }
    if (dataClassName == 'HealthRecord') {
      return deserialize<_ioxvgdwn.HealthRecord>(data['data']);
    }
    if (dataClassName == 'VaccinationRecord') {
      return deserialize<_idmsc9k2.VaccinationRecord>(data['data']);
    }
    if (dataClassName == 'Animal') {
      return deserialize<_i1g50dlu.Animal>(data['data']);
    }
    if (dataClassName == 'AnimalSex') {
      return deserialize<_igjjd0ss.AnimalSex>(data['data']);
    }
    if (dataClassName == 'AnimalSpecies') {
      return deserialize<_ihlw5w94.AnimalSpecies>(data['data']);
    }
    if (dataClassName == 'AnimalStatus') {
      return deserialize<_irv9gm2j.AnimalStatus>(data['data']);
    }
    if (dataClassName == 'AnimalObservation') {
      return deserialize<_i3jehzkb.AnimalObservation>(data['data']);
    }
    if (dataClassName == 'ProductionRecord') {
      return deserialize<_icnogur8.ProductionRecord>(data['data']);
    }
    if (dataClassName == 'RiskLevel') {
      return deserialize<_inmi9ln2.RiskLevel>(data['data']);
    }
    if (dataClassName == 'SentinelAssessment') {
      return deserialize<_i5feeh1w.SentinelAssessment>(data['data']);
    }
    if (dataClassName == 'FarmTask') {
      return deserialize<_ivo8j1ja.FarmTask>(data['data']);
    }
    if (dataClassName == 'TaskPriority') {
      return deserialize<_ihh19m3v.TaskPriority>(data['data']);
    }
    if (dataClassName == 'TaskStatus') {
      return deserialize<_i65tv1la.TaskStatus>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _iaic.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _iacc.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

  void _registerHostProtocols() {
    _iaic.Protocol().registerHostProtocol('mavuno', this);
    _iacc.Protocol().registerHostProtocol('mavuno', this);
  }

  @override
  String getModuleName() => 'mavuno';

  /// Maps any `Record`s known to this [Protocol] to their JSON representation
  ///
  /// Throws in case the record type is not known.
  ///
  /// This method will return `null` (only) for `null` inputs.
  Map<String, dynamic>? mapRecordToJson(Record? record) {
    if (record == null) {
      return null;
    }
    try {
      return _iaic.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _iacc.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
