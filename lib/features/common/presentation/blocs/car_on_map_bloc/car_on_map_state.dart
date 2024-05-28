part of 'car_on_map_bloc.dart';

class CarOnMapState extends Equatable {
  final CarOnMap carOnMap;

  const CarOnMapState(this.carOnMap);

  @override
  List<Object> get props => [carOnMap];
}
