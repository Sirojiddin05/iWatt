import 'package:i_watt_app/core/error/failure_handler.dart';
import 'package:i_watt_app/core/usecases/base_usecase.dart';
import 'package:i_watt_app/core/util/either.dart';
import 'package:i_watt_app/features/profile/domain/entities/car_entity.dart';
import 'package:i_watt_app/features/profile/domain/repositories/cars_repository.dart';

class EditCarUseCase implements UseCase<void, CarEntity> {
  final CarsRepository repository;
  EditCarUseCase({required this.repository});
  @override
  Future<Either<Failure, void>> call(CarEntity params) async => await repository.editCar(car: params);
}
