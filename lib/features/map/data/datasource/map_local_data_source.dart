import 'package:i_watt_app/core/error/exception_handler.dart';
import 'package:i_watt_app/core/util/db_helper.dart';
import 'package:i_watt_app/features/list/data/models/charge_location_model.dart';
import 'package:i_watt_app/features/list/domain/entities/charge_location_entity.dart';

abstract class MapLocalDataSource {
  Future<List<ChargeLocationModel>> getMapLocations();
  Future<void> saveLocationList(List<ChargeLocationEntity> locations);
}

class MapLocalDataSourceImpl implements MapLocalDataSource {
  final DBHelper dbHelper;

  const MapLocalDataSourceImpl(this.dbHelper);
  @override
  Future<List<ChargeLocationModel>> getMapLocations() {
    // TODO: implement getMapLocations
    throw UnimplementedError();
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
