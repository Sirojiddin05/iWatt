part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationEvent {}

class AuthenticationStatusChanged extends AuthenticationEvent {
  final AuthenticationStatus authenticationStatus;
  final bool isRebuild;
  AuthenticationStatusChanged({required this.authenticationStatus, this.isRebuild = false});
}
