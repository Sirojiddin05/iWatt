import 'package:i_watt_app/core/usecases/base_usecase.dart';
import 'package:i_watt_app/features/list/domain/entities/charge_location_entity.dart';
import 'package:i_watt_app/features/list/domain/repositories/charge_locations_repository.dart';

class SaveUnSaveStreamUseCase implements StreamUseCase<ChargeLocationEntity, NoParams> {
  final ChargeLocationsRepository repository;
  SaveUnSaveStreamUseCase(this.repository);
  @override
  Stream<ChargeLocationEntity> call(NoParams params) async* {
    yield* repository.saveUnSaveChargeLocationStream();
  }
}
