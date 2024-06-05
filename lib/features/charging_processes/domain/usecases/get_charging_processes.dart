import 'package:i_watt_app/core/error/failure_handler.dart';
import 'package:i_watt_app/core/usecases/base_usecase.dart';
import 'package:i_watt_app/core/util/either.dart';
import 'package:i_watt_app/features/charge_location_single/domain/entities/in_progress_charing_entity.dart';
import 'package:i_watt_app/features/charging_processes/domain/repositories/charging_process_repository.dart';
import 'package:i_watt_app/features/common/data/models/generic_pagination.dart';

class GetChargingProcessUseCase implements UseCase<GenericPagination<InProgressChargingEntity>, NoParams> {
  final ChargingProcessRepository repo;
  const GetChargingProcessUseCase(this.repo);

  @override
  Future<Either<Failure, GenericPagination<InProgressChargingEntity>>> call(NoParams params) async {
    return await repo.getChargingProcesses();
  }
}
