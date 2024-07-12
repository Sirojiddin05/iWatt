import 'package:i_watt_app/core/error/failure_handler.dart';
import 'package:i_watt_app/core/util/either.dart';
import 'package:i_watt_app/features/common/domain/entities/location_filter_key_entity.dart';

abstract class LocationFilterKeyRepository {
  Future<Either<Failure, List<LocationFilterKeyEntity>>> getLocationFilterKeys();
}
