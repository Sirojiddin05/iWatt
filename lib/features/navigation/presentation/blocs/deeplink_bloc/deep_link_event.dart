part of 'deep_link_bloc.dart';

@immutable
abstract class DeepLinkEvent {}

class DeepLinkChanged extends DeepLinkEvent {
  final String uri;

  DeepLinkChanged({required this.uri});
}
