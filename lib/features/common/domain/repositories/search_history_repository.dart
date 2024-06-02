import 'package:i_watt_app/core/error/failure_handler.dart';
import 'package:i_watt_app/core/util/either.dart';
import 'package:i_watt_app/features/common/data/models/generic_pagination.dart';
import 'package:i_watt_app/features/common/data/models/search_history_model.dart';
import 'package:i_watt_app/features/common/domain/entities/search_history_entity.dart';

abstract class SearchHistoryRepository {
  Future<Either<Failure, SearchHistoryModel>> postSearchHistory(int locationId);

  Future<Either<Failure, GenericPagination<SearchHistoryEntity>>> getSearchHistory();

  Future<Either<Failure, void>> deleteSingleSearchHistory(int id);

  Future<Either<Failure, void>> deleteAllSearchHistory();
}
