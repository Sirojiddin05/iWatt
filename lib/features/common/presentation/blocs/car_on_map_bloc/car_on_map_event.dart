part of 'car_on_map_bloc.dart';

@immutable
abstract class CarOnMapEvent {}

class CarOnMapChanged extends CarOnMapEvent {
  final CarOnMap carOnMap;

  CarOnMapChanged(this.carOnMap);
}
