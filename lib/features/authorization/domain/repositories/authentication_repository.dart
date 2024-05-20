import 'package:i_watt_app/core/util/enums/authentication_status.dart';

abstract class AuthenticationRepository {
  Stream<AuthenticationStatus> authenticationStatusStream();
}
