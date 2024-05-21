import 'package:i_watt_app/core/error/failure_handler.dart';
import 'package:i_watt_app/core/usecases/base_usecase.dart';
import 'package:i_watt_app/core/util/either.dart';
import 'package:i_watt_app/features/common/data/models/generic_pagination.dart';
import 'package:i_watt_app/features/list/domain/entities/charge_location_entity.dart';
import 'package:i_watt_app/features/list/domain/entities/get_charge_locations_param_entity.dart';
import 'package:i_watt_app/features/list/domain/repositories/charge_locations_repository.dart';

class GetChargeLocationsUseCase implements UseCase<GenericPagination<ChargeLocationEntity>, GetChargeLocationParamEntity> {
  final ChargeLocationsRepository repo;
  const GetChargeLocationsUseCase(this.repo);

  @override
  Future<Either<Failure, GenericPagination<ChargeLocationEntity>>> call(GetChargeLocationParamEntity params) async {
    return await repo.getChargeLocations(paramEntity: params);
  }
}
