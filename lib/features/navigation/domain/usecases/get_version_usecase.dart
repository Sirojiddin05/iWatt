import 'package:i_watt_app/core/error/failure_handler.dart';
import 'package:i_watt_app/core/usecases/base_usecase.dart';
import 'package:i_watt_app/core/util/either.dart';
import 'package:i_watt_app/features/navigation/domain/entity/version_entity.dart';
import 'package:i_watt_app/features/navigation/domain/repositories/version_check_repository.dart';

class GetAppLatestVersionUseCase implements UseCase<VersionEntity, NoParams> {
  final VersionCheckRepository repo;

  const GetAppLatestVersionUseCase(this.repo);

  @override
  Future<Either<Failure, VersionEntity>> call(NoParams params) async {
    return await repo.getAppLatestVersion();
  }
}
