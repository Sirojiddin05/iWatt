part of 'internet_bloc.dart';

@immutable
abstract class InternetEvent {
  const InternetEvent();
}

class ConnectionChanged extends InternetEvent {
  final bool isConnected;

  const ConnectionChanged({required this.isConnected});
}

class CheckConnectionEvent extends InternetEvent {}
