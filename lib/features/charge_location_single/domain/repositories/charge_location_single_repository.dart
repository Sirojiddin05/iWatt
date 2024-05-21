import 'package:i_watt_app/core/error/failure_handler.dart';
import 'package:i_watt_app/core/util/either.dart';
import 'package:i_watt_app/features/list/domain/entities/charge_location_entity.dart';

abstract class ChargeLocationSingleRepository {
  Future<Either<Failure, ChargeLocationEntity>> getLocationSingle(int id);
}
