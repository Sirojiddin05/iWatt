import 'package:i_watt_app/core/error/failure_handler.dart';
import 'package:i_watt_app/core/usecases/base_usecase.dart';
import 'package:i_watt_app/core/util/either.dart';
import 'package:i_watt_app/features/charge_location_single/domain/entities/appeal_entity.dart';
import 'package:i_watt_app/features/charge_location_single/domain/repositories/appeal_repository.dart';
import 'package:i_watt_app/features/common/data/models/generic_pagination.dart';

class GetAppealsUseCase implements UseCase<GenericPagination<AppealEntity>, String> {
  final AppealRepository repo;
  const GetAppealsUseCase(this.repo);

  @override
  Future<Either<Failure, GenericPagination<AppealEntity>>> call(String params) async {
    return await repo.getAppeals(next: params);
  }
}
