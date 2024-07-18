part of 'deep_link_bloc.dart';

@immutable
abstract class DeepLinkState {
  const DeepLinkState();
}

class DeepLinkInitial extends DeepLinkState {}

class ChargeLocationScanned extends DeepLinkState {
  const ChargeLocationScanned(this.locationId);

  final int locationId;
}
