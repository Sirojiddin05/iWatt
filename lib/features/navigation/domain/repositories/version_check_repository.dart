import 'package:i_watt_app/core/error/failure_handler.dart';
import 'package:i_watt_app/core/util/either.dart';
import 'package:i_watt_app/features/navigation/domain/entity/version_entity.dart';

abstract class VersionCheckRepository {
  Future<Either<Failure, VersionEntity>> getAppLatestVersion();
}
