import 'package:i_watt_app/core/error/failure_handler.dart';
import 'package:i_watt_app/core/usecases/base_usecase.dart';
import 'package:i_watt_app/core/util/either.dart';
import 'package:i_watt_app/features/charge_location_single/domain/entities/send_appeal_param_entity.dart';
import 'package:i_watt_app/features/charge_location_single/domain/repositories/appeal_repository.dart';

class SendAppealsUseCase implements UseCase<void, SendAppealParams> {
  final AppealRepository repo;
  const SendAppealsUseCase(this.repo);

  @override
  Future<Either<Failure, void>> call(SendAppealParams params) async {
    return await repo.sendAppeal(location: params.location, appeal: params.appeal);
  }
}
