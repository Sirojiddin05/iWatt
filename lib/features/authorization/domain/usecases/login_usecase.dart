import 'package:i_watt_app/core/error/failure_handler.dart';
import 'package:i_watt_app/core/usecases/base_usecase.dart';
import 'package:i_watt_app/core/util/either.dart';
import 'package:i_watt_app/features/authorization/domain/repositories/sign_in_repository.dart';

class LoginUseCase implements UseCase<String, String> {
  final SignInRepository repository;
  const LoginUseCase(this.repository);
  @override
  Future<Either<Failure, String>> call(String params) async {
    return await repository.login(phone: params);
  }
}
