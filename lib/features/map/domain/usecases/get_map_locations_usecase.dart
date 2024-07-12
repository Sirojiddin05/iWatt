import 'package:i_watt_app/core/error/failure_handler.dart';
import 'package:i_watt_app/core/usecases/base_usecase.dart';
import 'package:i_watt_app/core/util/either.dart';
import 'package:i_watt_app/features/list/domain/entities/charge_location_entity.dart';
import 'package:i_watt_app/features/list/domain/entities/get_charge_locations_param_entity.dart';
import 'package:i_watt_app/features/map/domain/repositories/map_repository.dart';

class GetMapLocationsUseCase implements UseCase<List<ChargeLocationEntity>, GetChargeLocationParamEntity> {
  final MapRepository repo;
  const GetMapLocationsUseCase(this.repo);

  @override
  Future<Either<Failure, List<ChargeLocationEntity>>> call(GetChargeLocationParamEntity params) async {
    return await repo.getMapLocationsFromRemote(params);
  }
}
