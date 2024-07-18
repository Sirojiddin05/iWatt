import 'package:i_watt_app/core/error/failure_handler.dart';
import 'package:i_watt_app/core/util/either.dart';
import 'package:i_watt_app/features/common/data/models/generic_pagination.dart';
import 'package:i_watt_app/features/list/domain/entities/charge_location_entity.dart';
import 'package:i_watt_app/features/list/domain/entities/get_charge_locations_param_entity.dart';
import 'package:i_watt_app/features/map/domain/entities/cluste_entity.dart';
import 'package:i_watt_app/features/map/domain/entities/get_locations_from_local_params.dart';

abstract class MapRepository {
  Future<Either<Failure, GenericPagination<ClusterEntity>>> getClusters({required GetChargeLocationParamEntity params});
  Future<Either<Failure, ChargeLocationEntity>> getLocation({required String key});
  Future<Either<Failure, List<ChargeLocationEntity>>> getMapLocationsFromRemote(GetChargeLocationParamEntity params);
  Future<Either<Failure, List<ChargeLocationEntity>>> getMapLocationsFromLocal(GetLocationsFromLocalParams params);
  Future<Either<Failure, void>> saveLocationList(List<ChargeLocationEntity> locations);
  Future<Either<Failure, List<ChargeLocationEntity>>> getCreatedLocations();
  Future<Either<Failure, List<ChargeLocationEntity>>> getUpdatedLocations();
  Future<Either<Failure, List<int>>> getDeletedLocations();
}
