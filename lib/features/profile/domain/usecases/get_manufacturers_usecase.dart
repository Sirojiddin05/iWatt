import 'package:i_watt_app/core/error/failure_handler.dart';
import 'package:i_watt_app/core/usecases/base_usecase.dart';
import 'package:i_watt_app/core/util/either.dart';
import 'package:i_watt_app/features/common/data/models/generic_pagination.dart';
import 'package:i_watt_app/features/common/domain/entities/id_name_entity.dart';
import 'package:i_watt_app/features/profile/domain/entities/get_manufacturers_param_entity.dart';
import 'package:i_watt_app/features/profile/domain/repositories/car_brand_repository.dart';

class GetManufacturersUseCase implements UseCase<GenericPagination<IdNameEntity>, GetManufacturersParamEntity> {
  final CarBrandsRepository repository;
  GetManufacturersUseCase(this.repository);
  @override
  Future<Either<Failure, GenericPagination<IdNameEntity>>> call(GetManufacturersParamEntity params) async {
    return await repository.getManufacturers(
      searchQuery: params.searchQuery,
      next: params.next,
    );
  }
}
