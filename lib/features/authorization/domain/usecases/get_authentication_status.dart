import 'package:i_watt_app/core/usecases/base_usecase.dart';
import 'package:i_watt_app/core/util/enums/authentication_status.dart';
import 'package:i_watt_app/features/authorization/domain/repositories/authentication_repository.dart';

class GetAuthenticationStatusUseCase implements StreamUseCase<AuthenticationStatus, NoParams> {
  final AuthenticationRepository repository;
  GetAuthenticationStatusUseCase({required this.repository});
  @override
  Stream<AuthenticationStatus> call(NoParams params) => repository.authenticationStatusStream();
}
