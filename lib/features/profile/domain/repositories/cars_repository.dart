import 'package:i_watt_app/core/error/failure_handler.dart';
import 'package:i_watt_app/core/util/either.dart';
import 'package:i_watt_app/features/common/data/models/generic_pagination.dart';
import 'package:i_watt_app/features/profile/domain/entities/car_entity.dart';

abstract class CarsRepository {
  Future<Either<Failure, void>> addCar({required CarEntity car});

  Future<Either<Failure, void>> editCar({required CarEntity car});

  Future<Either<Failure, void>> deleteCar({required int id});

  Future<Either<Failure, GenericPagination<CarEntity>>> getCars();
}
