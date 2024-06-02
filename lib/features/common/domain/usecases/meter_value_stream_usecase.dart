import 'package:i_watt_app/core/usecases/base_usecase.dart';
import 'package:i_watt_app/features/common/domain/entities/meter_value_message.dart';
import 'package:i_watt_app/features/common/domain/repositories/socket_repository.dart';

class MeterValueStreamUseCase implements StreamUseCase<MeterValueMessageEntity, NoParams> {
  final SocketRepository repository;
  const MeterValueStreamUseCase(this.repository);
  @override
  Stream<MeterValueMessageEntity> call(NoParams params) async* {
    yield* repository.meterValueStream();
  }
}
