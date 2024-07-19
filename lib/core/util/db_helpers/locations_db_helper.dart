import 'dart:developer';
import 'dart:io';

import 'package:i_watt_app/core/config/app_constants.dart';
import 'package:i_watt_app/core/error/exception_handler.dart';
import 'package:i_watt_app/features/list/data/models/charge_location_model.dart';
import 'package:i_watt_app/features/list/domain/entities/charge_location_entity.dart';
import 'package:path/path.dart' show dirname, join;
import 'package:sqflite/sqflite.dart';

class LocationsDbHelper {
  LocationsDbHelper._internal();
  static final LocationsDbHelper _instance = LocationsDbHelper._internal();
  factory LocationsDbHelper() => _instance;

  static late final Database database;

  Future<void> init() async {
    print('LocationsDbHelper init');
    var databasesPath = await getDatabasesPath();
    print('databasesPath $databasesPath');
    var path = join(databasesPath, AppConstants.locationDb);
    print('path $path');
    var exists = await databaseExists(path);
    if (!exists) {
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (error) {
        log(error.toString());
      }
    }
    try {
      database = await openDatabase(path, readOnly: false, onOpen: (db) {});
    } catch (e) {
      log('initError: ${e.toString()}');
    }
    await _createTable();
  }

  Future<void> _createTable() async {
    await database.execute('''CREATE TABLE IF NOT EXISTS ${AppConstants.locationsTable}(
            id INTEGER PRIMARY KEY,
            latitude TEXT NOT NULL,
            longitude TEXT NOT NULL,
            address TEXT NOT NULL,
            connectors_count INTEGER NOT NULL,
            vendor_name TEXT NOT NULL,
            location_name TEXT NOT NULL,
            logo TEXT NOT NULL,
            connectors_status TEXT NOT NULL,
            distance REAL NOT NULL,
            is_favorite INTEGER NOT NULL,
            max_electric_powers TEXT,
            status TEXT,
            location_appearance TEXT
        )''');
  }

  Future<void> saveLocationsList(List<ChargeLocationEntity> locations) async {
    try {
      if (database.isOpen) {
        for (var element in locations) {
          var values = element.toJson();
          try {
            await database.insert(
              AppConstants.locationsTable,
              values,
              conflictAlgorithm: ConflictAlgorithm.replace,
            );
          } catch (e) {
            log('saveLocationsListError: ${e.toString()}');
          }
        }
      }
    } catch (e) {
      throw CacheException(errorMessage: e.toString());
    }
  }

  Future<List<Map<String, dynamic>>> fetchLocations({
    String? where,
    List<dynamic>? whereArgs,
  }) async {
    try {
      final results = await database.rawQuery(
        'SELECT * FROM ${AppConstants.locationsTable} $where',
        whereArgs,
      );
      final locations = List.generate(
        results.length,
        (index) {
          final connectorsStatus = (results[index]['connectors_status'] as String).split(',');
          final statuses = (results[index]['status'] as String).split(',');
          return {
            "id": results[index]['id'],
            "latitude": results[index]['latitude'],
            "longitude": results[index]['longitude'],
            "address": results[index]['address'],
            "vendor_name": results[index]['vendor_name'],
            "location_name": results[index]['location_name'],
            "logo": results[index]['logo'],
            "distance": results[index]['distance'],
            "is_favorite": results[index]['is_favorite'] == 1,
            "connectors_count": results[index]['connectors_count'],
            "location_appearance": results[index]['location_appearance'],
            "connectors_status": connectorsStatus,
            "status": statuses,
          };
        },
      );
      return locations;
    } catch (e) {
      throw CacheException(errorMessage: e.toString());
    }
  }

  Future<void> insert(String table, Map<String, dynamic> row) async {
    try {
      await database.insert(table, row, conflictAlgorithm: ConflictAlgorithm.replace);
    } catch (e) {
      await init();
      await database.insert(table, row, conflictAlgorithm: ConflictAlgorithm.replace);
    }
  }

  Future<void> deleteItems(List<int> ids) async {
    try {
      final idsString = ids.join(',');
      await database.delete(
        AppConstants.locationsTable,
        where: 'id IN ($idsString)',
      );
    } catch (e) {
      log('deleteItemsError: ${e.toString()}');
      throw CacheException(errorMessage: e.toString());
    }
  }
}
