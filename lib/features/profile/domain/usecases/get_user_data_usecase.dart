import 'package:i_watt_app/core/error/failure_handler.dart';
import 'package:i_watt_app/core/usecases/base_usecase.dart';
import 'package:i_watt_app/core/util/either.dart';
import 'package:i_watt_app/features/profile/domain/entities/user_entity.dart';
import 'package:i_watt_app/features/profile/domain/repositories/profile_repository.dart';

class GetUserDataUseCase implements UseCase<UserEntity, NoParams> {
  final ProfileRepository repository;
  GetUserDataUseCase(this.repository);
  @override
  Future<Either<Failure, UserEntity>> call(NoParams params) async {
    return await repository.getUserData();
  }
}
