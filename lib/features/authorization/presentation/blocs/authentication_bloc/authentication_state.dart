part of 'authentication_bloc.dart';

@immutable
class AuthenticationState {
  final AuthenticationStatus authenticationStatus;
  final bool isRebuild;

  const AuthenticationState._({this.authenticationStatus = AuthenticationStatus.unauthenticated, this.isRebuild = false});

  const AuthenticationState.authenticated(bool isRebuild) : this._(authenticationStatus: AuthenticationStatus.authenticated, isRebuild: isRebuild);

  const AuthenticationState.unauthenticated(bool isRebuild)
      : this._(authenticationStatus: AuthenticationStatus.unauthenticated, isRebuild: isRebuild);

  const AuthenticationState.unKnown() : this._(authenticationStatus: AuthenticationStatus.unKnown);
}
