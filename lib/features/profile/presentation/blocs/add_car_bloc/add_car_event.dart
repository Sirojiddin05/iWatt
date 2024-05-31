part of 'add_car_bloc.dart';

@immutable
abstract class AddCarEvent {}

class SetManufacturer extends AddCarEvent {
  final IdNameEntity manufacturer;
  SetManufacturer(this.manufacturer);
}

class SetModel extends AddCarEvent {
  SetModel();
}

class SetConnectorTypes extends AddCarEvent {
  SetConnectorTypes();
}

class SetCarNumber extends AddCarEvent {
  final String number;
  SetCarNumber(this.number);
}

class SwitchToStep extends AddCarEvent {
  final int step;
  SwitchToStep(this.step);
}

class SwitchToNextStep extends AddCarEvent {}

class SwitchToPreviousStep extends AddCarEvent {}

class SetTemporaryModel extends AddCarEvent {
  final IdNameEntity model;
  SetTemporaryModel(this.model);
}

class SetTemporaryConnectorTypes extends AddCarEvent {
  final List<int> ids;
  SetTemporaryConnectorTypes(this.ids);
}

class SetOtherMark extends AddCarEvent {
  final String mark;
  SetOtherMark(this.mark);
}

class SetOtherModel extends AddCarEvent {
  final String model;
  SetOtherModel(this.model);
}

class AddCar extends AddCarEvent {}
