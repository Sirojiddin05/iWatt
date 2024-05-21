import 'package:i_watt_app/core/error/failure_handler.dart';
import 'package:i_watt_app/core/util/either.dart';
import 'package:i_watt_app/features/common/data/models/generic_pagination.dart';
import 'package:i_watt_app/features/list/domain/entities/charge_location_entity.dart';
import 'package:i_watt_app/features/list/domain/entities/get_charge_locations_param_entity.dart';

abstract class ChargeLocationsRepository {
  Future<Either<Failure, GenericPagination<ChargeLocationEntity>>> getChargeLocations({required GetChargeLocationParamEntity paramEntity});
  Future<Either<Failure, void>> saveUnSaveChargeLocation({required ChargeLocationEntity location});
  Stream<ChargeLocationEntity> saveUnSaveChargeLocationStream();
}
