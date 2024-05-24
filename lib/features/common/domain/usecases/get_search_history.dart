import 'package:i_watt_app/core/error/failure_handler.dart';
import 'package:i_watt_app/core/usecases/base_usecase.dart';
import 'package:i_watt_app/core/util/either.dart';
import 'package:i_watt_app/features/common/data/models/generic_pagination.dart';
import 'package:i_watt_app/features/common/domain/entities/id_name_entity.dart';
import 'package:i_watt_app/features/common/domain/repositories/search_history_repository.dart';

class GetSearchHistoryUseCase extends UseCase<GenericPagination<IdNameEntity>, NoParams> {
  final SearchHistoryRepository repository;

  GetSearchHistoryUseCase(this.repository);

  @override
  Future<Either<Failure, GenericPagination<IdNameEntity>>> call(NoParams params) async {
    return await repository.getSearchHistory();
  }
}
