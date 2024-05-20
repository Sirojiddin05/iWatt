part of 'authentication_bloc.dart';

@immutable
class AuthenticationState {
  final AuthenticationStatus authenticationStatus;

  const AuthenticationState._({
    this.authenticationStatus = AuthenticationStatus.unauthenticated,
  });

  const AuthenticationState.authenticated() : this._(authenticationStatus: AuthenticationStatus.authenticated);

  const AuthenticationState.unauthenticated() : this._(authenticationStatus: AuthenticationStatus.unauthenticated);

  const AuthenticationState.unKnown() : this._(authenticationStatus: AuthenticationStatus.unKnown);
}
