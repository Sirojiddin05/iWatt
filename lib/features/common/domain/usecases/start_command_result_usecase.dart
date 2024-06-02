import 'package:i_watt_app/core/usecases/base_usecase.dart';
import 'package:i_watt_app/features/common/domain/entities/command_result_message.dart';
import 'package:i_watt_app/features/common/domain/repositories/socket_repository.dart';

class StartCommandResultStreamUseCase implements StreamUseCase<CommandResultMessageEntity, NoParams> {
  final SocketRepository repository;
  StartCommandResultStreamUseCase(this.repository);
  @override
  Stream<CommandResultMessageEntity> call(NoParams params) async* {
    yield* repository.startCommandResultStream();
  }
}
