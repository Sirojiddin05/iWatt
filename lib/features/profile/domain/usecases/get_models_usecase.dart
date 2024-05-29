import 'package:i_watt_app/core/error/failure_handler.dart';
import 'package:i_watt_app/core/usecases/base_usecase.dart';
import 'package:i_watt_app/core/util/either.dart';
import 'package:i_watt_app/features/common/data/models/generic_pagination.dart';
import 'package:i_watt_app/features/common/domain/entities/id_name_entity.dart';
import 'package:i_watt_app/features/profile/domain/entities/getModels_param_entity.dart';
import 'package:i_watt_app/features/profile/domain/repositories/car_brand_repository.dart';

class GetModelsUseCase implements UseCase<GenericPagination<IdNameEntity>, GetModelsParamEntity> {
  final CarBrandsRepository repository;
  GetModelsUseCase(this.repository);
  @override
  Future<Either<Failure, GenericPagination<IdNameEntity>>> call(GetModelsParamEntity params) async {
    return await repository.getModels(
      manufacturerId: params.manufacturerId,
      next: params.next,
    );
  }
}
