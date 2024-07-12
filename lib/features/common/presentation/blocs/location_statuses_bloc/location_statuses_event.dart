part of 'location_statuses_bloc.dart';

@immutable
sealed class LocationStatusesEvent {}

class GetLocationStatusesEvent extends LocationStatusesEvent {}
