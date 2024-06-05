part of 'cars_bloc.dart';

@immutable
abstract class CarsEvent {}

class GetCarsEvent extends CarsEvent {}

class DeleteCarEvent extends CarsEvent {
  final int carId;

  DeleteCarEvent(this.carId);
}

class AddCarLocallyEvent extends CarsEvent {
  final CarEntity car;

  AddCarLocallyEvent(this.car);
}
