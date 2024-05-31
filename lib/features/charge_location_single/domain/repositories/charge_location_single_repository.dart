import 'package:i_watt_app/core/error/failure_handler.dart';
import 'package:i_watt_app/core/util/either.dart';
import 'package:i_watt_app/features/charge_location_single/domain/entities/charge_location_single_entity.dart';

abstract class ChargeLocationSingleRepository {
  Future<Either<Failure, ChargeLocationSingleEntity>> getLocationSingle(int id);
}
