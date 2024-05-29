part of 'add_car_bloc.dart';

@immutable
abstract class AddCarEvent {}

class SetManufacturer extends AddCarEvent {
  final int id;
  SetManufacturer(this.id);
}

class SetModel extends AddCarEvent {
  SetModel();
}

class SetConnectorTypes extends AddCarEvent {
  SetConnectorTypes();
}

class SetCustomManufacturer extends AddCarEvent {
  final String manufacturer;
  SetCustomManufacturer(this.manufacturer);
}

class SetCustomModel extends AddCarEvent {
  final String model;
  SetCustomModel(this.model);
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
  final int id;
  SetTemporaryModel(this.id);
}

class SetTemporaryConnectorTypes extends AddCarEvent {
  final List<int> ids;
  SetTemporaryConnectorTypes(this.ids);
}

class AddCar extends AddCarEvent {}
