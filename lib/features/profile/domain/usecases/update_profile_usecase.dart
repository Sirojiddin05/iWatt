import 'package:i_watt_app/core/error/failure_handler.dart';
import 'package:i_watt_app/core/usecases/base_usecase.dart';
import 'package:i_watt_app/core/util/either.dart';
import 'package:i_watt_app/features/profile/data/models/user_model.dart';
import 'package:i_watt_app/features/profile/domain/entities/user_entity.dart';
import 'package:i_watt_app/features/profile/domain/repositories/profile_repository.dart';

class UpdateProfileDataUseCase implements UseCase<UserEntity, UserModel> {
  final ProfileRepository repository;
  UpdateProfileDataUseCase(this.repository);
  @override
  Future<Either<Failure, UserEntity>> call(UserModel params) async {
    return await repository.updateProfile(user: params);
  }
}
