import 'package:i_watt_app/core/error/failure_handler.dart';
import 'package:i_watt_app/core/usecases/base_usecase.dart';
import 'package:i_watt_app/core/util/either.dart';
import 'package:i_watt_app/features/map/domain/repositories/map_repository.dart';

class DeleteLocationsUseCase implements UseCase<void, List<int>> {
  final MapRepository repo;
  const DeleteLocationsUseCase(this.repo);

  @override
  Future<Either<Failure, void>> call(List<int> params) async {
    return await repo.deleteLocations(params);
  }
}
