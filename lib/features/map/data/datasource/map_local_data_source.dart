import 'dart:async';
import 'dart:isolate';

import 'package:flutter_isolate/flutter_isolate.dart';
import 'package:i_watt_app/core/error/exception_handler.dart';
import 'package:i_watt_app/core/util/db_helpers/locations_db_helper.dart';
import 'package:i_watt_app/features/list/data/models/charge_location_model.dart';
import 'package:i_watt_app/features/list/domain/entities/charge_location_entity.dart';
import 'package:i_watt_app/features/map/domain/entities/get_locations_from_local_params.dart';

abstract class MapLocalDataSource {
  Future<List<ChargeLocationModel>> getMapLocations(GetLocationsFromLocalParams params);
  Future<void> saveLocationList(List<ChargeLocationEntity> locations);
  Future<void> deleteLocations({required List<int> locationIds});
}

class MapLocalDataSourceImpl implements MapLocalDataSource {
  final LocationsDbHelper dbHelper;
  const MapLocalDataSourceImpl(this.dbHelper);
  @override
  Future<List<ChargeLocationModel>> getMapLocations(GetLocationsFromLocalParams params) async {
    try {
      final query = params.generateQuery();
      final where = query.conditions;
      final args = query.args;
      final result = await dbHelper.fetchLocations(
        where: where,
        whereArgs: args,
      );
      return List<ChargeLocationModel>.generate(result.length, (index) => ChargeLocationModel.fromJson(result[index]));

      // final completer = Completer<List<ChargeLocationModel>>();
      // final receivePort = ReceivePort();
      // await FlutterIsolate.spawn<Map<String, dynamic>>(databaseIsolate, {
      //   'command': 'fetch',
      //   'where': where,
      //   'args': args,
      //   'sendPort': receivePort.sendPort,
      // });
      // receivePort.listen((data) {
      //   final List<ChargeLocationModel> result = data.map((e) => ChargeLocationModel.fromJson(e)).toList();
      //   completer.complete(result);
      //   receivePort.close();
      // });
      // return completer.future;
    } catch (e) {
      throw CacheException(errorMessage: e.toString());
    }
  }

  @override
  Future<void> saveLocationList(List<ChargeLocationEntity> locations) async {
    try {
      await dbHelper.saveLocationsList(locations);
    } catch (e) {
      throw CacheException(errorMessage: e.toString());
    }
  }

  @override
  Future<void> deleteLocations({required List<int> locationIds}) async {
    try {
      dbHelper.deleteItems(locationIds);
      // await FlutterIsolate.spawn<Map<String, dynamic>>(databaseIsolate, {
      //   'command': 'delete',
      //   'location_ids': locationIds,
      // });
    } catch (e) {
      throw CacheException(errorMessage: e.toString());
    }
  }
}

void databaseIsolate(Map<String, dynamic> data) async {
  print('databaseIsolate');
  final String command = data['command'];
  final LocationsDbHelper dbHelper = LocationsDbHelper();
  await dbHelper.init();
  if (command == 'save') {
    await dbHelper.saveLocationsList(data['locations']);
  } else if (command == 'fetch') {
    final result = await dbHelper.fetchLocations(
      where: data['where'],
      whereArgs: data['args'],
    );
    data['sendPort'].send(result);
  } else if (command == 'delete') {
    final result = await dbHelper.deleteItems(data['location_ids']);
    data['sendPort'].send(result);
  }
}
