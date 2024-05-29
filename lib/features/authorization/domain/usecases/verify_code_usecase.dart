import 'package:i_watt_app/core/error/failure_handler.dart';
import 'package:i_watt_app/core/usecases/base_usecase.dart';
import 'package:i_watt_app/core/util/either.dart';
import 'package:i_watt_app/features/authorization/domain/entities/verify_code_params_entity.dart';
import 'package:i_watt_app/features/authorization/domain/repositories/sign_in_repository.dart';

class VerifyCodeUseCase implements UseCase<bool, VerifyCodeParamsEntity> {
  final SignInRepository repository;
  const VerifyCodeUseCase(this.repository);
  @override
  Future<Either<Failure, bool>> call(VerifyCodeParamsEntity params) async {
    return await repository.verifyCode(
      code: params.code,
      phone: params.phone,
      session: params.session,
      type: params.type,
    );
  }
}
