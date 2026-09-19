/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:mavuno_server/src/generated/livestock/animal_sex.dart'
    as _i967ufj1;
import 'package:mavuno_server/src/generated/livestock/animal_species.dart'
    as _ifxpomhs;
import 'package:mavuno_server/src/generated/livestock/animal_status.dart'
    as _idmp214p;
import 'package:mavuno_server/src/generated/tasks/task_priority.dart'
    as _i7zu0q98;
import 'package:mavuno_server/src/generated/tasks/task_status.dart'
    as _i6ub2xo1;
import 'package:serverpod/serverpod.dart' as _is;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _iacs;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart'
    as _iais;
import '../alerts/alert_endpoint.dart' as _itgxyvy1;
import '../auth/email_idp_endpoint.dart' as _iuc1hd5t;
import '../auth/jwt_refresh_endpoint.dart' as _inwq3ztq;
import '../demo/demo_endpoint.dart' as _i46mxkwc;
import '../farm/farm_endpoint.dart' as _ifrsvro7;
import '../feed/feed_endpoint.dart' as _idutgb02;
import '../greetings/greeting_endpoint.dart' as _il624ik7;
import '../health/health_endpoint.dart' as _id9paj9q;
import '../livestock/animal_endpoint.dart' as _irhlkl43;
import '../observations/observation_endpoint.dart' as _iqyrnszk;
import '../production/production_endpoint.dart' as _ib3v0vgw;
import '../tasks/task_endpoint.dart' as _i3nmwja6;

class Endpoints extends _is.EndpointDispatch {
  @override
  void initializeEndpoints(_is.Server server) {
    var endpoints = <String, _is.Endpoint>{
      'alert': _itgxyvy1.AlertEndpoint()
        ..initialize(
          server,
          'alert',
          null,
        ),
      'emailIdp': _iuc1hd5t.EmailIdpEndpoint()
        ..initialize(
          server,
          'emailIdp',
          null,
        ),
      'jwtRefresh': _inwq3ztq.JwtRefreshEndpoint()
        ..initialize(
          server,
          'jwtRefresh',
          null,
        ),
      'demo': _i46mxkwc.DemoEndpoint()
        ..initialize(
          server,
          'demo',
          null,
        ),
      'farm': _ifrsvro7.FarmEndpoint()
        ..initialize(
          server,
          'farm',
          null,
        ),
      'feed': _idutgb02.FeedEndpoint()
        ..initialize(
          server,
          'feed',
          null,
        ),
      'greeting': _il624ik7.GreetingEndpoint()
        ..initialize(
          server,
          'greeting',
          null,
        ),
      'health': _id9paj9q.HealthEndpoint()
        ..initialize(
          server,
          'health',
          null,
        ),
      'animal': _irhlkl43.AnimalEndpoint()
        ..initialize(
          server,
          'animal',
          null,
        ),
      'observation': _iqyrnszk.ObservationEndpoint()
        ..initialize(
          server,
          'observation',
          null,
        ),
      'production': _ib3v0vgw.ProductionEndpoint()
        ..initialize(
          server,
          'production',
          null,
        ),
      'task': _i3nmwja6.TaskEndpoint()
        ..initialize(
          server,
          'task',
          null,
        ),
    };
    connectors['alert'] = _is.EndpointConnector(
      name: 'alert',
      endpoint: endpoints['alert']!,
      methodConnectors: {
        'listActive': _is.MethodConnector(
          name: 'listActive',
          params: {
            'farmId': _is.ParameterDescription(
              name: 'farmId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['alert'] as _itgxyvy1.AlertEndpoint).listActive(
                    session,
                    params['farmId'],
                  ),
        ),
        'acknowledge': _is.MethodConnector(
          name: 'acknowledge',
          params: {
            'alertId': _is.ParameterDescription(
              name: 'alertId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['alert'] as _itgxyvy1.AlertEndpoint).acknowledge(
                    session,
                    params['alertId'],
                  ),
        ),
        'resolve': _is.MethodConnector(
          name: 'resolve',
          params: {
            'alertId': _is.ParameterDescription(
              name: 'alertId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['alert'] as _itgxyvy1.AlertEndpoint).resolve(
                    session,
                    params['alertId'],
                  ),
        ),
      },
    );
    connectors['emailIdp'] = _is.EndpointConnector(
      name: 'emailIdp',
      endpoint: endpoints['emailIdp']!,
      methodConnectors: {
        'login': _is.MethodConnector(
          name: 'login',
          params: {
            'email': _is.ParameterDescription(
              name: 'email',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'password': _is.ParameterDescription(
              name: 'password',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint).login(
                    session,
                    email: params['email'],
                    password: params['password'],
                  ),
        ),
        'startRegistration': _is.MethodConnector(
          name: 'startRegistration',
          params: {
            'email': _is.ParameterDescription(
              name: 'email',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .startRegistration(
                    session,
                    email: params['email'],
                  ),
        ),
        'verifyRegistrationCode': _is.MethodConnector(
          name: 'verifyRegistrationCode',
          params: {
            'accountRequestId': _is.ParameterDescription(
              name: 'accountRequestId',
              type: _is.getType<_is.UuidValue>(),
              nullable: false,
            ),
            'verificationCode': _is.ParameterDescription(
              name: 'verificationCode',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .verifyRegistrationCode(
                    session,
                    accountRequestId: params['accountRequestId'],
                    verificationCode: params['verificationCode'],
                  ),
        ),
        'finishRegistration': _is.MethodConnector(
          name: 'finishRegistration',
          params: {
            'registrationToken': _is.ParameterDescription(
              name: 'registrationToken',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'password': _is.ParameterDescription(
              name: 'password',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .finishRegistration(
                    session,
                    registrationToken: params['registrationToken'],
                    password: params['password'],
                  ),
        ),
        'startPasswordReset': _is.MethodConnector(
          name: 'startPasswordReset',
          params: {
            'email': _is.ParameterDescription(
              name: 'email',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .startPasswordReset(
                    session,
                    email: params['email'],
                  ),
        ),
        'verifyPasswordResetCode': _is.MethodConnector(
          name: 'verifyPasswordResetCode',
          params: {
            'passwordResetRequestId': _is.ParameterDescription(
              name: 'passwordResetRequestId',
              type: _is.getType<_is.UuidValue>(),
              nullable: false,
            ),
            'verificationCode': _is.ParameterDescription(
              name: 'verificationCode',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .verifyPasswordResetCode(
                    session,
                    passwordResetRequestId: params['passwordResetRequestId'],
                    verificationCode: params['verificationCode'],
                  ),
        ),
        'finishPasswordReset': _is.MethodConnector(
          name: 'finishPasswordReset',
          params: {
            'finishPasswordResetToken': _is.ParameterDescription(
              name: 'finishPasswordResetToken',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'newPassword': _is.ParameterDescription(
              name: 'newPassword',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .finishPasswordReset(
                    session,
                    finishPasswordResetToken:
                        params['finishPasswordResetToken'],
                    newPassword: params['newPassword'],
                  ),
        ),
        'hasAccount': _is.MethodConnector(
          name: 'hasAccount',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .hasAccount(session),
        ),
      },
    );
    connectors['jwtRefresh'] = _is.EndpointConnector(
      name: 'jwtRefresh',
      endpoint: endpoints['jwtRefresh']!,
      methodConnectors: {
        'refreshAccessToken': _is.MethodConnector(
          name: 'refreshAccessToken',
          params: {
            'refreshToken': _is.ParameterDescription(
              name: 'refreshToken',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['jwtRefresh'] as _inwq3ztq.JwtRefreshEndpoint)
                      .refreshAccessToken(
                        session,
                        refreshToken: params['refreshToken'],
                      ),
        ),
      },
    );
    connectors['demo'] = _is.EndpointConnector(
      name: 'demo',
      endpoint: endpoints['demo']!,
      methodConnectors: {
        'seedDemo': _is.MethodConnector(
          name: 'seedDemo',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['demo'] as _i46mxkwc.DemoEndpoint).seedDemo(
                session,
              ),
        ),
      },
    );
    connectors['farm'] = _is.EndpointConnector(
      name: 'farm',
      endpoint: endpoints['farm']!,
      methodConnectors: {
        'create': _is.MethodConnector(
          name: 'create',
          params: {
            'name': _is.ParameterDescription(
              name: 'name',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'location': _is.ParameterDescription(
              name: 'location',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'farmType': _is.ParameterDescription(
              name: 'farmType',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'description': _is.ParameterDescription(
              name: 'description',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['farm'] as _ifrsvro7.FarmEndpoint).create(
                session,
                params['name'],
                location: params['location'],
                farmType: params['farmType'],
                description: params['description'],
              ),
        ),
        'list': _is.MethodConnector(
          name: 'list',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['farm'] as _ifrsvro7.FarmEndpoint).list(session),
        ),
        'get': _is.MethodConnector(
          name: 'get',
          params: {
            'farmId': _is.ParameterDescription(
              name: 'farmId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['farm'] as _ifrsvro7.FarmEndpoint).get(
                session,
                params['farmId'],
              ),
        ),
        'update': _is.MethodConnector(
          name: 'update',
          params: {
            'farmId': _is.ParameterDescription(
              name: 'farmId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'name': _is.ParameterDescription(
              name: 'name',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'location': _is.ParameterDescription(
              name: 'location',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'farmType': _is.ParameterDescription(
              name: 'farmType',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'description': _is.ParameterDescription(
              name: 'description',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['farm'] as _ifrsvro7.FarmEndpoint).update(
                session,
                params['farmId'],
                params['name'],
                location: params['location'],
                farmType: params['farmType'],
                description: params['description'],
              ),
        ),
      },
    );
    connectors['feed'] = _is.EndpointConnector(
      name: 'feed',
      endpoint: endpoints['feed']!,
      methodConnectors: {
        'create': _is.MethodConnector(
          name: 'create',
          params: {
            'farmId': _is.ParameterDescription(
              name: 'farmId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'recordedAt': _is.ParameterDescription(
              name: 'recordedAt',
              type: _is.getType<DateTime>(),
              nullable: false,
            ),
            'feedType': _is.ParameterDescription(
              name: 'feedType',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'quantity': _is.ParameterDescription(
              name: 'quantity',
              type: _is.getType<double>(),
              nullable: false,
            ),
            'unit': _is.ParameterDescription(
              name: 'unit',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'animalId': _is.ParameterDescription(
              name: 'animalId',
              type: _is.getType<int?>(),
              nullable: true,
            ),
            'notes': _is.ParameterDescription(
              name: 'notes',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['feed'] as _idutgb02.FeedEndpoint).create(
                session,
                params['farmId'],
                params['recordedAt'],
                params['feedType'],
                params['quantity'],
                params['unit'],
                animalId: params['animalId'],
                notes: params['notes'],
              ),
        ),
        'listByFarm': _is.MethodConnector(
          name: 'listByFarm',
          params: {
            'farmId': _is.ParameterDescription(
              name: 'farmId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'limit': _is.ParameterDescription(
              name: 'limit',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['feed'] as _idutgb02.FeedEndpoint).listByFarm(
                    session,
                    params['farmId'],
                    limit: params['limit'],
                  ),
        ),
        'listByAnimal': _is.MethodConnector(
          name: 'listByAnimal',
          params: {
            'animalId': _is.ParameterDescription(
              name: 'animalId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'limit': _is.ParameterDescription(
              name: 'limit',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['feed'] as _idutgb02.FeedEndpoint).listByAnimal(
                    session,
                    params['animalId'],
                    limit: params['limit'],
                  ),
        ),
      },
    );
    connectors['greeting'] = _is.EndpointConnector(
      name: 'greeting',
      endpoint: endpoints['greeting']!,
      methodConnectors: {
        'hello': _is.MethodConnector(
          name: 'hello',
          params: {
            'name': _is.ParameterDescription(
              name: 'name',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['greeting'] as _il624ik7.GreetingEndpoint).hello(
                    session,
                    params['name'],
                  ),
        ),
      },
    );
    connectors['health'] = _is.EndpointConnector(
      name: 'health',
      endpoint: endpoints['health']!,
      methodConnectors: {
        'create': _is.MethodConnector(
          name: 'create',
          params: {
            'animalId': _is.ParameterDescription(
              name: 'animalId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'recordedAt': _is.ParameterDescription(
              name: 'recordedAt',
              type: _is.getType<DateTime>(),
              nullable: false,
            ),
            'recordType': _is.ParameterDescription(
              name: 'recordType',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'description': _is.ParameterDescription(
              name: 'description',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'professionalName': _is.ParameterDescription(
              name: 'professionalName',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'notes': _is.ParameterDescription(
              name: 'notes',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['health'] as _id9paj9q.HealthEndpoint).create(
                    session,
                    params['animalId'],
                    params['recordedAt'],
                    params['recordType'],
                    params['description'],
                    professionalName: params['professionalName'],
                    notes: params['notes'],
                  ),
        ),
        'listByAnimal': _is.MethodConnector(
          name: 'listByAnimal',
          params: {
            'animalId': _is.ParameterDescription(
              name: 'animalId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['health'] as _id9paj9q.HealthEndpoint)
                  .listByAnimal(
                    session,
                    params['animalId'],
                  ),
        ),
        'createVaccination': _is.MethodConnector(
          name: 'createVaccination',
          params: {
            'animalId': _is.ParameterDescription(
              name: 'animalId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'vaccination': _is.ParameterDescription(
              name: 'vaccination',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'administeredAt': _is.ParameterDescription(
              name: 'administeredAt',
              type: _is.getType<DateTime>(),
              nullable: false,
            ),
            'nextDueAt': _is.ParameterDescription(
              name: 'nextDueAt',
              type: _is.getType<DateTime?>(),
              nullable: true,
            ),
            'provider': _is.ParameterDescription(
              name: 'provider',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'notes': _is.ParameterDescription(
              name: 'notes',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['health'] as _id9paj9q.HealthEndpoint)
                  .createVaccination(
                    session,
                    params['animalId'],
                    params['vaccination'],
                    params['administeredAt'],
                    nextDueAt: params['nextDueAt'],
                    provider: params['provider'],
                    notes: params['notes'],
                  ),
        ),
        'listVaccinations': _is.MethodConnector(
          name: 'listVaccinations',
          params: {
            'animalId': _is.ParameterDescription(
              name: 'animalId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['health'] as _id9paj9q.HealthEndpoint)
                  .listVaccinations(
                    session,
                    params['animalId'],
                  ),
        ),
      },
    );
    connectors['animal'] = _is.EndpointConnector(
      name: 'animal',
      endpoint: endpoints['animal']!,
      methodConnectors: {
        'create': _is.MethodConnector(
          name: 'create',
          params: {
            'farmId': _is.ParameterDescription(
              name: 'farmId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'tag': _is.ParameterDescription(
              name: 'tag',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'species': _is.ParameterDescription(
              name: 'species',
              type: _is.getType<_ifxpomhs.AnimalSpecies>(),
              nullable: false,
            ),
            'sex': _is.ParameterDescription(
              name: 'sex',
              type: _is.getType<_i967ufj1.AnimalSex>(),
              nullable: false,
            ),
            'name': _is.ParameterDescription(
              name: 'name',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'breed': _is.ParameterDescription(
              name: 'breed',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'dateOfBirth': _is.ParameterDescription(
              name: 'dateOfBirth',
              type: _is.getType<DateTime?>(),
              nullable: true,
            ),
            'status': _is.ParameterDescription(
              name: 'status',
              type: _is.getType<_idmp214p.AnimalStatus>(),
              nullable: false,
            ),
            'notes': _is.ParameterDescription(
              name: 'notes',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['animal'] as _irhlkl43.AnimalEndpoint).create(
                    session,
                    params['farmId'],
                    params['tag'],
                    params['species'],
                    params['sex'],
                    name: params['name'],
                    breed: params['breed'],
                    dateOfBirth: params['dateOfBirth'],
                    status: params['status'],
                    notes: params['notes'],
                  ),
        ),
        'get': _is.MethodConnector(
          name: 'get',
          params: {
            'animalId': _is.ParameterDescription(
              name: 'animalId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['animal'] as _irhlkl43.AnimalEndpoint).get(
                session,
                params['animalId'],
              ),
        ),
        'listByFarm': _is.MethodConnector(
          name: 'listByFarm',
          params: {
            'farmId': _is.ParameterDescription(
              name: 'farmId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['animal'] as _irhlkl43.AnimalEndpoint).listByFarm(
                    session,
                    params['farmId'],
                  ),
        ),
        'update': _is.MethodConnector(
          name: 'update',
          params: {
            'animalId': _is.ParameterDescription(
              name: 'animalId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'tag': _is.ParameterDescription(
              name: 'tag',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'name': _is.ParameterDescription(
              name: 'name',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'breed': _is.ParameterDescription(
              name: 'breed',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'status': _is.ParameterDescription(
              name: 'status',
              type: _is.getType<_idmp214p.AnimalStatus?>(),
              nullable: true,
            ),
            'dateOfBirth': _is.ParameterDescription(
              name: 'dateOfBirth',
              type: _is.getType<DateTime?>(),
              nullable: true,
            ),
            'notes': _is.ParameterDescription(
              name: 'notes',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['animal'] as _irhlkl43.AnimalEndpoint).update(
                    session,
                    params['animalId'],
                    tag: params['tag'],
                    name: params['name'],
                    breed: params['breed'],
                    status: params['status'],
                    dateOfBirth: params['dateOfBirth'],
                    notes: params['notes'],
                  ),
        ),
      },
    );
    connectors['observation'] = _is.EndpointConnector(
      name: 'observation',
      endpoint: endpoints['observation']!,
      methodConnectors: {
        'create': _is.MethodConnector(
          name: 'create',
          params: {
            'animalId': _is.ParameterDescription(
              name: 'animalId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'recordedAt': _is.ParameterDescription(
              name: 'recordedAt',
              type: _is.getType<DateTime>(),
              nullable: false,
            ),
            'temperature': _is.ParameterDescription(
              name: 'temperature',
              type: _is.getType<double?>(),
              nullable: true,
            ),
            'activityScore': _is.ParameterDescription(
              name: 'activityScore',
              type: _is.getType<int?>(),
              nullable: true,
            ),
            'appetiteScore': _is.ParameterDescription(
              name: 'appetiteScore',
              type: _is.getType<int?>(),
              nullable: true,
            ),
            'feedIntake': _is.ParameterDescription(
              name: 'feedIntake',
              type: _is.getType<double?>(),
              nullable: true,
            ),
            'productionValue': _is.ParameterDescription(
              name: 'productionValue',
              type: _is.getType<double?>(),
              nullable: true,
            ),
            'productionUnit': _is.ParameterDescription(
              name: 'productionUnit',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'visibleSymptoms': _is.ParameterDescription(
              name: 'visibleSymptoms',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'notes': _is.ParameterDescription(
              name: 'notes',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['observation'] as _iqyrnszk.ObservationEndpoint)
                      .create(
                        session,
                        params['animalId'],
                        params['recordedAt'],
                        temperature: params['temperature'],
                        activityScore: params['activityScore'],
                        appetiteScore: params['appetiteScore'],
                        feedIntake: params['feedIntake'],
                        productionValue: params['productionValue'],
                        productionUnit: params['productionUnit'],
                        visibleSymptoms: params['visibleSymptoms'],
                        notes: params['notes'],
                      ),
        ),
        'listByAnimal': _is.MethodConnector(
          name: 'listByAnimal',
          params: {
            'animalId': _is.ParameterDescription(
              name: 'animalId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'limit': _is.ParameterDescription(
              name: 'limit',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['observation'] as _iqyrnszk.ObservationEndpoint)
                      .listByAnimal(
                        session,
                        params['animalId'],
                        limit: params['limit'],
                      ),
        ),
      },
    );
    connectors['production'] = _is.EndpointConnector(
      name: 'production',
      endpoint: endpoints['production']!,
      methodConnectors: {
        'create': _is.MethodConnector(
          name: 'create',
          params: {
            'animalId': _is.ParameterDescription(
              name: 'animalId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'recordedAt': _is.ParameterDescription(
              name: 'recordedAt',
              type: _is.getType<DateTime>(),
              nullable: false,
            ),
            'metricType': _is.ParameterDescription(
              name: 'metricType',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'value': _is.ParameterDescription(
              name: 'value',
              type: _is.getType<double>(),
              nullable: false,
            ),
            'unit': _is.ParameterDescription(
              name: 'unit',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'notes': _is.ParameterDescription(
              name: 'notes',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['production'] as _ib3v0vgw.ProductionEndpoint)
                      .create(
                        session,
                        params['animalId'],
                        params['recordedAt'],
                        params['metricType'],
                        params['value'],
                        params['unit'],
                        notes: params['notes'],
                      ),
        ),
        'listByAnimal': _is.MethodConnector(
          name: 'listByAnimal',
          params: {
            'animalId': _is.ParameterDescription(
              name: 'animalId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['production'] as _ib3v0vgw.ProductionEndpoint)
                      .listByAnimal(
                        session,
                        params['animalId'],
                      ),
        ),
      },
    );
    connectors['task'] = _is.EndpointConnector(
      name: 'task',
      endpoint: endpoints['task']!,
      methodConnectors: {
        'create': _is.MethodConnector(
          name: 'create',
          params: {
            'farmId': _is.ParameterDescription(
              name: 'farmId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'title': _is.ParameterDescription(
              name: 'title',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'animalId': _is.ParameterDescription(
              name: 'animalId',
              type: _is.getType<int?>(),
              nullable: true,
            ),
            'description': _is.ParameterDescription(
              name: 'description',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'priority': _is.ParameterDescription(
              name: 'priority',
              type: _is.getType<_i7zu0q98.TaskPriority>(),
              nullable: false,
            ),
            'dueAt': _is.ParameterDescription(
              name: 'dueAt',
              type: _is.getType<DateTime?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['task'] as _i3nmwja6.TaskEndpoint).create(
                session,
                params['farmId'],
                params['title'],
                animalId: params['animalId'],
                description: params['description'],
                priority: params['priority'],
                dueAt: params['dueAt'],
              ),
        ),
        'list': _is.MethodConnector(
          name: 'list',
          params: {
            'farmId': _is.ParameterDescription(
              name: 'farmId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'status': _is.ParameterDescription(
              name: 'status',
              type: _is.getType<_i6ub2xo1.TaskStatus?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['task'] as _i3nmwja6.TaskEndpoint).list(
                session,
                params['farmId'],
                status: params['status'],
              ),
        ),
        'complete': _is.MethodConnector(
          name: 'complete',
          params: {
            'taskId': _is.ParameterDescription(
              name: 'taskId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['task'] as _i3nmwja6.TaskEndpoint).complete(
                session,
                params['taskId'],
              ),
        ),
      },
    );
    modules['serverpod_auth_idp'] = _iais.Endpoints()
      ..initializeEndpoints(server);
    modules['serverpod_auth_core'] = _iacs.Endpoints()
      ..initializeEndpoints(server);
  }
}
