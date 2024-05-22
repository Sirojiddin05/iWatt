import 'package:i_watt_app/core/error/failure_handler.dart';
import 'package:i_watt_app/core/util/either.dart';
import 'package:i_watt_app/features/charge_location_single/domain/entities/appeal_entity.dart';
import 'package:i_watt_app/features/common/data/models/generic_pagination.dart';

abstract class AppealRepository {
  Future<Either<Failure, GenericPagination<AppealEntity>>> getAppeals({required String next});
  Future<Either<Failure, void>> sendAppeal({required int id, required int location, String otherAppeal = ''});
}
