import 'package:i_watt_app/core/error/failure_handler.dart';
import 'package:i_watt_app/core/usecases/base_usecase.dart';
import 'package:i_watt_app/core/util/either.dart';
import 'package:i_watt_app/features/authorization/domain/repositories/sign_in_repository.dart';

class LoginWithQrUseCase implements UseCase<void, String> {
  final SignInRepository repository;
  const LoginWithQrUseCase(this.repository);
  @override
  Future<Either<Failure, void>> call(String params) async {
    return await repository.loginWithQr(token: params);
  }
}
