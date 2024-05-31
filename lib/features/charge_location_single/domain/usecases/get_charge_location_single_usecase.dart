import 'package:i_watt_app/core/error/failure_handler.dart';
import 'package:i_watt_app/core/usecases/base_usecase.dart';
import 'package:i_watt_app/core/util/either.dart';
import 'package:i_watt_app/features/charge_location_single/domain/entities/charge_location_single_entity.dart';
import 'package:i_watt_app/features/charge_location_single/domain/repositories/charge_location_single_repository.dart';

class GetChargeLocationSingleUseCase implements UseCase<ChargeLocationSingleEntity, int> {
  final ChargeLocationSingleRepository repo;
  const GetChargeLocationSingleUseCase(this.repo);

  @override
  Future<Either<Failure, ChargeLocationSingleEntity>> call(int params) async {
    return await repo.getLocationSingle(params);
  }
}
