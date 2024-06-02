import 'package:i_watt_app/core/error/failure_handler.dart';
import 'package:i_watt_app/core/usecases/base_usecase.dart';
import 'package:i_watt_app/core/util/either.dart';
import 'package:i_watt_app/features/profile/domain/repositories/profile_repository.dart';

class DeleteAccountUseCase implements UseCase<void, NoParams> {
  final ProfileRepository repository;

  DeleteAccountUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await repository.deleteAccount();
  }
}
