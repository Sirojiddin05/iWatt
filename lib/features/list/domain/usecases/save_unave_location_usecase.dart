import 'package:i_watt_app/core/error/failure_handler.dart';
import 'package:i_watt_app/core/usecases/base_usecase.dart';
import 'package:i_watt_app/core/util/either.dart';
import 'package:i_watt_app/features/list/domain/entities/charge_location_entity.dart';
import 'package:i_watt_app/features/list/domain/repositories/charge_locations_repository.dart';

class SaveUnSaveChargeLocationUseCase implements UseCase<void, ChargeLocationEntity> {
  final ChargeLocationsRepository repo;
  const SaveUnSaveChargeLocationUseCase(this.repo);

  @override
  Future<Either<Failure, void>> call(ChargeLocationEntity location) async {
    return await repo.saveUnSaveChargeLocation(location: location);
  }
}
