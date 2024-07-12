import 'package:i_watt_app/core/error/failure_handler.dart';
import 'package:i_watt_app/core/usecases/base_usecase.dart';
import 'package:i_watt_app/core/util/either.dart';
import 'package:i_watt_app/features/list/domain/entities/charge_location_entity.dart';
import 'package:i_watt_app/features/map/domain/entities/get_locations_from_local_params.dart';
import 'package:i_watt_app/features/map/domain/repositories/map_repository.dart';

class GetLocationsFromLocalSourceUseCase implements UseCase<List<ChargeLocationEntity>, GetLocationsFromLocalParams> {
  final MapRepository repo;
  const GetLocationsFromLocalSourceUseCase(this.repo);

  @override
  Future<Either<Failure, List<ChargeLocationEntity>>> call(GetLocationsFromLocalParams params) async {
    return await repo.getMapLocationsFromLocal(params);
  }
}
