import 'package:i_watt_app/core/error/failure_handler.dart';
import 'package:i_watt_app/core/usecases/base_usecase.dart';
import 'package:i_watt_app/core/util/either.dart';
import 'package:i_watt_app/features/common/domain/entities/location_filter_key_entity.dart';
import 'package:i_watt_app/features/common/domain/repositories/location_filter_key_repository.dart';

class GetLocationFilterKeysUseCase extends UseCase<List<LocationFilterKeyEntity>, NoParams> {
  final LocationFilterKeyRepository notificationRepository;

  GetLocationFilterKeysUseCase(this.notificationRepository);

  @override
  Future<Either<Failure, List<LocationFilterKeyEntity>>> call(NoParams params) {
    return notificationRepository.getLocationFilterKeys();
  }
}
