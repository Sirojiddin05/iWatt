import 'package:i_watt_app/core/error/failure_handler.dart';
import 'package:i_watt_app/core/util/either.dart';
import 'package:i_watt_app/features/common/data/models/generic_pagination.dart';
import 'package:i_watt_app/features/common/domain/entities/id_name_entity.dart';

abstract class SearchHistoryRepository {
  Future<Either<Failure, GenericPagination<IdNameEntity>>> getSearchHistory();
  Future<Either<Failure, void>> deleteSingleSearchHistory(int id);
  Future<Either<Failure, void>> deleteAllSearchHistory();
}
