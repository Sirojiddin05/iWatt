import 'package:i_watt_app/core/error/failure_handler.dart';
import 'package:i_watt_app/core/usecases/base_usecase.dart';
import 'package:i_watt_app/core/util/either.dart';
import 'package:i_watt_app/features/common/data/models/generic_pagination.dart';
import 'package:i_watt_app/features/profile/domain/entities/car_entity.dart';
import 'package:i_watt_app/features/profile/domain/repositories/cars_repository.dart';

class GetCarsUseCase implements UseCase<GenericPagination<CarEntity>, NoParams> {
  final CarsRepository repository;
  GetCarsUseCase(this.repository);
  @override
  Future<Either<Failure, GenericPagination<CarEntity>>> call(NoParams params) async => await repository.getCars();
}
