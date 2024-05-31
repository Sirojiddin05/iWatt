import 'package:i_watt_app/core/error/failure_handler.dart';
import 'package:i_watt_app/core/util/either.dart';
import 'package:i_watt_app/features/profile/data/models/user_model.dart';
import 'package:i_watt_app/features/profile/domain/entities/user_entity.dart';

abstract class ProfileRepository {
  Future<Either<Failure, UserEntity>> getUserData();
  Future<Either<Failure, UserEntity>> updateProfile({required UserModel user});
}
