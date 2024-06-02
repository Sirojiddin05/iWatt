import 'package:i_watt_app/core/error/failure_handler.dart';
import 'package:i_watt_app/core/usecases/base_usecase.dart';
import 'package:i_watt_app/core/util/either.dart';
import 'package:i_watt_app/features/common/data/models/search_history_model.dart';
import 'package:i_watt_app/features/common/domain/repositories/search_history_repository.dart';

class PostSearchHistoryUseCase extends UseCase<SearchHistoryModel, int> {
  final SearchHistoryRepository repository;

  PostSearchHistoryUseCase(this.repository);

  @override
  Future<Either<Failure, SearchHistoryModel>> call(int params) async {
    return await repository.postSearchHistory(params);
  }
}
