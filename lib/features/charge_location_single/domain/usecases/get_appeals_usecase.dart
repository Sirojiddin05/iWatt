import 'package:i_watt_app/core/error/failure_handler.dart';
import 'package:i_watt_app/core/usecases/base_usecase.dart';
import 'package:i_watt_app/core/util/either.dart';
import 'package:i_watt_app/features/charge_location_single/domain/repositories/appeal_repository.dart';
import 'package:i_watt_app/features/common/data/models/generic_pagination.dart';
import 'package:i_watt_app/features/common/domain/entities/id_name_entity.dart';

class GetAppealsUseCase implements UseCase<GenericPagination<IdNameEntity>, String> {
  final AppealRepository repo;
  const GetAppealsUseCase(this.repo);

  @override
  Future<Either<Failure, GenericPagination<IdNameEntity>>> call(String params) async {
    return await repo.getAppeals(next: params);
  }
}
