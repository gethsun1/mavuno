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
import 'package:mavuno_server/src/generated/farm/farm.dart' as _i3p74zpc;
import 'package:mavuno_server/src/generated/livestock/animal.dart' as _isv0knrb;
import 'package:serverpod/protocol.dart' as _isp;
import 'package:serverpod/serverpod.dart' as _is;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _iacs;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart'
    as _iais;
import 'alerts/alert_severity.dart' as _iu08z8uc;
import 'alerts/alert_type.dart' as _i3o8d7cu;
import 'alerts/farm_alert.dart' as _iokus4nq;
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

class Protocol extends _is.DatabaseSerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._().._registerHostProtocols();

  static List<_isp.TableDefinition> get targetTableDefinitions => [
    _isp.TableDefinition(
      name: 'animal',
      dartName: 'Animal',
      schema: 'public',
      module: 'mavuno',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'farmId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'tag',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'name',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'species',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:AnimalSpecies',
        ),
        _isp.ColumnDefinition(
          name: 'breed',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'sex',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:AnimalSex',
        ),
        _isp.ColumnDefinition(
          name: 'dateOfBirth',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'status',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:AnimalStatus',
        ),
        _isp.ColumnDefinition(
          name: 'notes',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'updatedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'animal_fk_0',
          columns: ['farmId'],
          referenceTable: 'farm',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'animal_farm_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'farmId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'animal_observation',
      dartName: 'AnimalObservation',
      schema: 'public',
      module: 'mavuno',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'animalId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'recordedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'temperature',
          columnType: _isp.ColumnType.doublePrecision,
          isNullable: true,
          dartType: 'double?',
        ),
        _isp.ColumnDefinition(
          name: 'activityScore',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'appetiteScore',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'feedIntake',
          columnType: _isp.ColumnType.doublePrecision,
          isNullable: true,
          dartType: 'double?',
        ),
        _isp.ColumnDefinition(
          name: 'productionValue',
          columnType: _isp.ColumnType.doublePrecision,
          isNullable: true,
          dartType: 'double?',
        ),
        _isp.ColumnDefinition(
          name: 'productionUnit',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'visibleSymptoms',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'notes',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'recordedBy',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'animal_observation_fk_0',
          columns: ['animalId'],
          referenceTable: 'animal',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'observation_animal_recorded_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'animalId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'recordedAt',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'farm',
      dartName: 'Farm',
      schema: 'public',
      module: 'mavuno',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'ownerId',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'name',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'location',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'farmType',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'description',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'updatedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'farm_owner_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'ownerId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'farm_alert',
      dartName: 'FarmAlert',
      schema: 'public',
      module: 'mavuno',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'farmId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'animalId',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'severity',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:AlertSeverity',
        ),
        _isp.ColumnDefinition(
          name: 'alertType',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:AlertType',
        ),
        _isp.ColumnDefinition(
          name: 'title',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'description',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'acknowledgedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'resolvedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'farm_alert_fk_0',
          columns: ['farmId'],
          referenceTable: 'farm',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _isp.ForeignKeyDefinition(
          constraintName: 'farm_alert_fk_1',
          columns: ['animalId'],
          referenceTable: 'animal',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'alert_farm_active_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'farmId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'resolvedAt',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'farm_task',
      dartName: 'FarmTask',
      schema: 'public',
      module: 'mavuno',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'farmId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'animalId',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'title',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'description',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'priority',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:TaskPriority',
        ),
        _isp.ColumnDefinition(
          name: 'dueAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'status',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:TaskStatus',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'completedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'farm_task_fk_0',
          columns: ['farmId'],
          referenceTable: 'farm',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _isp.ForeignKeyDefinition(
          constraintName: 'farm_task_fk_1',
          columns: ['animalId'],
          referenceTable: 'animal',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'task_farm_status_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'farmId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'status',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'feed_record',
      dartName: 'FeedRecord',
      schema: 'public',
      module: 'mavuno',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'farmId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'animalId',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'recordedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'feedType',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'quantity',
          columnType: _isp.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _isp.ColumnDefinition(
          name: 'unit',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'notes',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'feed_record_fk_0',
          columns: ['farmId'],
          referenceTable: 'farm',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _isp.ForeignKeyDefinition(
          constraintName: 'feed_record_fk_1',
          columns: ['animalId'],
          referenceTable: 'animal',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'feed_farm_recorded_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'farmId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'recordedAt',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'health_record',
      dartName: 'HealthRecord',
      schema: 'public',
      module: 'mavuno',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'animalId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'recordedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'recordType',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'description',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'professionalName',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'notes',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'health_record_fk_0',
          columns: ['animalId'],
          referenceTable: 'animal',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'health_animal_recorded_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'animalId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'recordedAt',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'production_record',
      dartName: 'ProductionRecord',
      schema: 'public',
      module: 'mavuno',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'animalId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'recordedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'metricType',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'value',
          columnType: _isp.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _isp.ColumnDefinition(
          name: 'unit',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'notes',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'production_record_fk_0',
          columns: ['animalId'],
          referenceTable: 'animal',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'production_animal_recorded_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'animalId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'recordedAt',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'sentinel_assessment',
      dartName: 'SentinelAssessment',
      schema: 'public',
      module: 'mavuno',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'farmId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'animalId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'assessedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'riskScore',
          columnType: _isp.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _isp.ColumnDefinition(
          name: 'riskLevel',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:RiskLevel',
        ),
        _isp.ColumnDefinition(
          name: 'detectedSignals',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'baselineSummary',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'explanation',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'recommendedAction',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'sourceObservationId',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'sentinel_assessment_fk_0',
          columns: ['farmId'],
          referenceTable: 'farm',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _isp.ForeignKeyDefinition(
          constraintName: 'sentinel_assessment_fk_1',
          columns: ['animalId'],
          referenceTable: 'animal',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _isp.ForeignKeyDefinition(
          constraintName: 'sentinel_assessment_fk_2',
          columns: ['sourceObservationId'],
          referenceTable: 'animal_observation',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'assessment_animal_assessed_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'animalId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'assessedAt',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'vaccination_record',
      dartName: 'VaccinationRecord',
      schema: 'public',
      module: 'mavuno',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'animalId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'vaccination',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'administeredAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'nextDueAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'provider',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'notes',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'vaccination_record_fk_0',
          columns: ['animalId'],
          referenceTable: 'animal',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'vaccination_animal_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'animalId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    ..._iais.Protocol.targetTableDefinitions,
    ..._iacs.Protocol.targetTableDefinitions,
    ..._isp.Protocol.targetTableDefinitions,
  ];

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
      } on _is.DeserializationClassNameNotFoundException catch (_) {
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
    if (t == _is.getType<_iu08z8uc.AlertSeverity?>()) {
      return (data != null ? _iu08z8uc.AlertSeverity.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_i3o8d7cu.AlertType?>()) {
      return (data != null ? _i3o8d7cu.AlertType.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_iokus4nq.FarmAlert?>()) {
      return (data != null ? _iokus4nq.FarmAlert.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_iaxrkr2w.Farm?>()) {
      return (data != null ? _iaxrkr2w.Farm.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i4r52dc7.FeedRecord?>()) {
      return (data != null ? _i4r52dc7.FeedRecord.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_izw8z7ou.Greeting?>()) {
      return (data != null ? _izw8z7ou.Greeting.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ioxvgdwn.HealthRecord?>()) {
      return (data != null ? _ioxvgdwn.HealthRecord.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_idmsc9k2.VaccinationRecord?>()) {
      return (data != null ? _idmsc9k2.VaccinationRecord.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_i1g50dlu.Animal?>()) {
      return (data != null ? _i1g50dlu.Animal.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_igjjd0ss.AnimalSex?>()) {
      return (data != null ? _igjjd0ss.AnimalSex.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ihlw5w94.AnimalSpecies?>()) {
      return (data != null ? _ihlw5w94.AnimalSpecies.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_irv9gm2j.AnimalStatus?>()) {
      return (data != null ? _irv9gm2j.AnimalStatus.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i3jehzkb.AnimalObservation?>()) {
      return (data != null ? _i3jehzkb.AnimalObservation.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_icnogur8.ProductionRecord?>()) {
      return (data != null ? _icnogur8.ProductionRecord.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_inmi9ln2.RiskLevel?>()) {
      return (data != null ? _inmi9ln2.RiskLevel.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i5feeh1w.SentinelAssessment?>()) {
      return (data != null ? _i5feeh1w.SentinelAssessment.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_ivo8j1ja.FarmTask?>()) {
      return (data != null ? _ivo8j1ja.FarmTask.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ihh19m3v.TaskPriority?>()) {
      return (data != null ? _ihh19m3v.TaskPriority.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i65tv1la.TaskStatus?>()) {
      return (data != null ? _i65tv1la.TaskStatus.fromJson(data) : null) as T;
    }
    if (t == List<_i3p74zpc.Farm>) {
      return (data as List).map((e) => deserialize<_i3p74zpc.Farm>(e)).toList()
          as T;
    }
    if (t == List<_isv0knrb.Animal>) {
      return (data as List)
              .map((e) => deserialize<_isv0knrb.Animal>(e))
              .toList()
          as T;
    }
    try {
      return _iais.Protocol().deserialize<T>(data, t);
    } on _is.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _iacs.Protocol().deserialize<T>(data, t);
    } on _is.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _isp.Protocol().deserialize<T>(data, t);
    } on _is.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _iu08z8uc.AlertSeverity => 'AlertSeverity',
      _i3o8d7cu.AlertType => 'AlertType',
      _iokus4nq.FarmAlert => 'FarmAlert',
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
    className = _iais.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_auth_idp.$className';
    }
    className = _iacs.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_auth_core.$className';
    }
    className = _isp.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.') ? className : 'serverpod.$className';
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
      return _iais.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _iacs.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod.')) {
      data['className'] = dataClassName.substring(10);
      return _isp.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

  void _registerHostProtocols() {
    _iais.Protocol().registerHostProtocol('mavuno', this);
    _iacs.Protocol().registerHostProtocol('mavuno', this);
  }

  @override
  _is.Table? getTableForType(Type t) {
    {
      var table = _iais.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    {
      var table = _iacs.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    {
      var table = _isp.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    switch (t) {
      case _iokus4nq.FarmAlert:
        return _iokus4nq.FarmAlert.t;
      case _iaxrkr2w.Farm:
        return _iaxrkr2w.Farm.t;
      case _i4r52dc7.FeedRecord:
        return _i4r52dc7.FeedRecord.t;
      case _ioxvgdwn.HealthRecord:
        return _ioxvgdwn.HealthRecord.t;
      case _idmsc9k2.VaccinationRecord:
        return _idmsc9k2.VaccinationRecord.t;
      case _i1g50dlu.Animal:
        return _i1g50dlu.Animal.t;
      case _i3jehzkb.AnimalObservation:
        return _i3jehzkb.AnimalObservation.t;
      case _icnogur8.ProductionRecord:
        return _icnogur8.ProductionRecord.t;
      case _i5feeh1w.SentinelAssessment:
        return _i5feeh1w.SentinelAssessment.t;
      case _ivo8j1ja.FarmTask:
        return _ivo8j1ja.FarmTask.t;
    }
    return null;
  }

  @override
  List<_isp.TableDefinition> getTargetTableDefinitions() =>
      targetTableDefinitions;

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
      return _iais.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _iacs.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
