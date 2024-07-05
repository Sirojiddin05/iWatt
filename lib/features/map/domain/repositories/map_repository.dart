import 'package:i_watt_app/core/error/failure_handler.dart';
import 'package:i_watt_app/core/util/either.dart';
import 'package:i_watt_app/features/common/data/models/generic_pagination.dart';
import 'package:i_watt_app/features/list/domain/entities/get_charge_locations_param_entity.dart';
import 'package:i_watt_app/features/map/data/models/cluster_model.dart';

abstract class MapRepository {
  Future<Either<Failure, GenericPagination<ClusterModel>>> getClusters({required GetChargeLocationParamEntity params});
}
