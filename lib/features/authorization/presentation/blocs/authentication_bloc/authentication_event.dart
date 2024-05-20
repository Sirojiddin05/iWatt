part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationEvent {}

class AuthenticationStatusChanged extends AuthenticationEvent {
  final AuthenticationStatus authenticationStatus;
  AuthenticationStatusChanged({required this.authenticationStatus});
}

class GetAuthenticationStatus extends AuthenticationEvent {}
