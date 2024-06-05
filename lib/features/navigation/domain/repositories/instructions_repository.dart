import 'package:i_watt_app/core/error/failure_handler.dart';
import 'package:i_watt_app/core/util/either.dart';
import 'package:i_watt_app/features/common/data/models/generic_pagination.dart';
import 'package:i_watt_app/features/navigation/domain/entity/version_features_entity.dart';

abstract class InstructionsRepository {
  Future<Either<Failure, GenericPagination<VersionFeaturesEntity>>> getInstructions(String type);
}
