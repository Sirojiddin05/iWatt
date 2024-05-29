import 'package:i_watt_app/core/error/failure_handler.dart';
import 'package:i_watt_app/core/usecases/base_usecase.dart';
import 'package:i_watt_app/core/util/either.dart';
import 'package:i_watt_app/features/profile/domain/repositories/cars_repository.dart';

class DeleteCarUseCase implements UseCase<void, int> {
  final CarsRepository repository;
  DeleteCarUseCase(this.repository);
  @override
  Future<Either<Failure, void>> call(int params) async => await repository.deleteCar(id: params);
}
