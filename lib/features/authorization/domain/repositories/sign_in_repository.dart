import 'package:i_watt_app/core/error/failure_handler.dart';
import 'package:i_watt_app/core/util/either.dart';

abstract class SignInRepository {
  Future<Either<Failure, String>> login({required String phone});
  Future<Either<Failure, bool>> verifyCode({required String code, required String phone, required String session, required String type});
}
