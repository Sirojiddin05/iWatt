import 'package:i_watt_app/core/error/exception_handler.dart';
import 'package:i_watt_app/core/util/db_helper.dart';
import 'package:i_watt_app/features/list/data/models/charge_location_model.dart';
import 'package:i_watt_app/features/list/domain/entities/charge_location_entity.dart';
import 'package:i_watt_app/features/map/domain/entities/get_locations_from_local_params.dart';

abstract class MapLocalDataSource {
  Future<List<ChargeLocationModel>> getMapLocations(GetLocationsFromLocalParams params);
  Future<void> saveLocationList(List<ChargeLocationEntity> locations);
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
      final result = await dbHelper.fetchLocations(whereArgs: args, where: where);
      return result;
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
}
