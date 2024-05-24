import 'package:i_watt_app/core/error/failure_handler.dart';
import 'package:i_watt_app/core/usecases/base_usecase.dart';
import 'package:i_watt_app/core/util/either.dart';
import 'package:i_watt_app/features/common/domain/repositories/search_history_repository.dart';

class DeleteAllSearchHistoryUseCase extends UseCase<void, NoParams> {
  final SearchHistoryRepository repository;

  DeleteAllSearchHistoryUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await repository.deleteAllSearchHistory();
  }
}
