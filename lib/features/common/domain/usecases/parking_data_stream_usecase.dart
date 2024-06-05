import 'package:i_watt_app/core/usecases/base_usecase.dart';
import 'package:i_watt_app/features/common/domain/entities/parking_data_message.dart';
import 'package:i_watt_app/features/common/domain/repositories/socket_repository.dart';

class ParkingDataStreamUseCase implements StreamUseCase<ParkingDataMessageEntity, NoParams> {
  final SocketRepository repository;
  const ParkingDataStreamUseCase(this.repository);
  @override
  Stream<ParkingDataMessageEntity> call(NoParams params) async* {
    yield* repository.parkingDataStream();
  }
}
