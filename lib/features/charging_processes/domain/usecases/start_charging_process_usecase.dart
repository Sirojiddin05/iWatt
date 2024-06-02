import 'package:i_watt_app/core/error/failure_handler.dart';
import 'package:i_watt_app/core/usecases/base_usecase.dart';
import 'package:i_watt_app/core/util/either.dart';
import 'package:i_watt_app/features/charging_processes/domain/entities/start_process_param_entity.dart';
import 'package:i_watt_app/features/charging_processes/domain/entities/start_process_response_entity.dart';
import 'package:i_watt_app/features/charging_processes/domain/repositories/charging_process_repository.dart';

class StartChargingProcessUseCase implements UseCase<CommandResultResponseEntity, StartProcessParamEntity> {
  final ChargingProcessRepository repo;
  const StartChargingProcessUseCase(this.repo);

  @override
  Future<Either<Failure, CommandResultResponseEntity>> call(StartProcessParamEntity params) async {
    return await repo.startChargingProcess(params: params);
  }
}
