import 'package:i_watt_app/core/usecases/base_usecase.dart';
import 'package:i_watt_app/features/common/domain/entities/connector_status_message.dart';
import 'package:i_watt_app/features/common/domain/repositories/socket_repository.dart';

class ConnectorStatusStreamUseCase implements StreamUseCase<ConnectorStatusMessageEntity, NoParams> {
  final SocketRepository repository;
  ConnectorStatusStreamUseCase(this.repository);
  @override
  Stream<ConnectorStatusMessageEntity> call(NoParams params) async* {
    yield* repository.connectorStatusStream();
  }
}
