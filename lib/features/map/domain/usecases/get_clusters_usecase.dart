import 'package:i_watt_app/core/error/failure_handler.dart';
import 'package:i_watt_app/core/usecases/base_usecase.dart';
import 'package:i_watt_app/core/util/either.dart';
import 'package:i_watt_app/features/common/data/models/generic_pagination.dart';
import 'package:i_watt_app/features/list/domain/entities/get_charge_locations_param_entity.dart';
import 'package:i_watt_app/features/map/domain/entities/cluste_entity.dart';
import 'package:i_watt_app/features/map/domain/repositories/map_repository.dart';

class GetClustersUseCase implements UseCase<GenericPagination<ClusterEntity>, GetChargeLocationParamEntity> {
  final MapRepository repo;
  const GetClustersUseCase(this.repo);

  @override
  Future<Either<Failure, GenericPagination<ClusterEntity>>> call(GetChargeLocationParamEntity params) async {
    return await repo.getClusters(params: params);
  }
}
