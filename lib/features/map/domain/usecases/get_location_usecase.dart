import 'package:i_watt_app/core/error/failure_handler.dart';
import 'package:i_watt_app/core/usecases/base_usecase.dart';
import 'package:i_watt_app/core/util/either.dart';
import 'package:i_watt_app/features/list/domain/entities/charge_location_entity.dart';
import 'package:i_watt_app/features/map/domain/repositories/map_repository.dart';

class GetMapLocationUseCase implements UseCase<ChargeLocationEntity, String> {
  final MapRepository repo;
  const GetMapLocationUseCase(this.repo);

  @override
  Future<Either<Failure, ChargeLocationEntity>> call(String params) async {
    return await repo.getLocation(key: params);
  }
}
