import 'package:i_watt_app/core/error/failure_handler.dart';
import 'package:i_watt_app/core/usecases/base_usecase.dart';
import 'package:i_watt_app/core/util/either.dart';
import 'package:i_watt_app/features/common/data/models/generic_pagination.dart';
import 'package:i_watt_app/features/common/domain/entities/search_history_entity.dart';
import 'package:i_watt_app/features/common/domain/repositories/search_history_repository.dart';

class GetSearchHistoryUseCase extends UseCase<GenericPagination<SearchHistoryEntity>, NoParams> {
  final SearchHistoryRepository repository;

  GetSearchHistoryUseCase(this.repository);

  @override
  Future<Either<Failure, GenericPagination<SearchHistoryEntity>>> call(NoParams params) async {
    return await repository.getSearchHistory();
  }
}
