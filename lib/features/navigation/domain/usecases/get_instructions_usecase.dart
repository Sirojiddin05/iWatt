import 'package:i_watt_app/core/error/failure_handler.dart';
import 'package:i_watt_app/core/usecases/base_usecase.dart';
import 'package:i_watt_app/core/util/either.dart';
import 'package:i_watt_app/features/common/data/models/generic_pagination.dart';
import 'package:i_watt_app/features/navigation/domain/entity/version_features_entity.dart';
import 'package:i_watt_app/features/navigation/domain/repositories/instructions_repository.dart';

class GetInstructionsUseCase implements UseCase<GenericPagination<VersionFeaturesEntity>, String> {
  final InstructionsRepository repo;

  const GetInstructionsUseCase(this.repo);

  @override
  Future<Either<Failure, GenericPagination<VersionFeaturesEntity>>> call(String params) async {
    return await repo.getInstructions(params);
  }
}
