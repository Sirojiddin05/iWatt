import 'package:i_watt_app/core/usecases/base_usecase.dart';
import 'package:i_watt_app/features/common/domain/entities/command_result_message.dart';
import 'package:i_watt_app/features/common/domain/repositories/socket_repository.dart';

class StopCommandResultStreamUseCase implements StreamUseCase<CommandResultMessageEntity, NoParams> {
  final SocketRepository repository;
  StopCommandResultStreamUseCase(this.repository);
  @override
  Stream<CommandResultMessageEntity> call(NoParams params) async* {
    yield* repository.stopCommandResult();
  }
}
