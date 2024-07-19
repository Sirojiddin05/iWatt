import 'package:i_watt_app/core/error/failure_handler.dart';
import 'package:i_watt_app/core/usecases/base_usecase.dart';
import 'package:i_watt_app/core/util/either.dart';
import 'package:i_watt_app/features/list/domain/entities/charge_location_entity.dart';
import 'package:i_watt_app/features/map/domain/repositories/map_repository.dart';

class SaveLocationListUseCase implements UseCase<void, List<ChargeLocationEntity>> {
  final MapRepository repo;
  const SaveLocationListUseCase(this.repo);

  @override
  Future<Either<Failure, void>> call(List<ChargeLocationEntity> params) async {
    return await repo.saveLocations(params);
  }
}
