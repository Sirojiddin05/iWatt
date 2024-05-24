import 'package:i_watt_app/core/error/failure_handler.dart';
import 'package:i_watt_app/core/usecases/base_usecase.dart';
import 'package:i_watt_app/core/util/either.dart';
import 'package:i_watt_app/features/common/domain/repositories/search_history_repository.dart';

class DeleteSingleSearchHistoryUseCase extends UseCase<void, int> {
  final SearchHistoryRepository repository;

  DeleteSingleSearchHistoryUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(int params) async {
    return await repository.deleteSingleSearchHistory(params);
  }
}
