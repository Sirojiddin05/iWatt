import 'package:i_watt_app/core/error/failure_handler.dart';
import 'package:i_watt_app/core/util/either.dart';
import 'package:i_watt_app/features/charging_processes/domain/entities/start_process_param_entity.dart';
import 'package:i_watt_app/features/charging_processes/domain/entities/start_process_response_entity.dart';

abstract class ChargingProcessRepository {
  Future<Either<Failure, CommandResultResponseEntity>> startChargingProcess({required StartProcessParamEntity params});
  Future<Either<Failure, CommandResultResponseEntity>> stopChargingProcess({required int transaction});
}
