import 'package:i_watt_app/core/error/failure_handler.dart';
import 'package:i_watt_app/core/usecases/base_usecase.dart';
import 'package:i_watt_app/core/util/either.dart';
import 'package:i_watt_app/features/charge_location_single/domain/repositories/charge_location_single_repository.dart';
import 'package:i_watt_app/features/list/domain/entities/charge_location_entity.dart';

class GetChargeLocationSingleUseCase implements UseCase<ChargeLocationEntity, int> {
  final ChargeLocationSingleRepository repo;
  const GetChargeLocationSingleUseCase(this.repo);

  @override
  Future<Either<Failure, ChargeLocationEntity>> call(int params) async {
    return await repo.getLocationSingle(params);
  }
}
