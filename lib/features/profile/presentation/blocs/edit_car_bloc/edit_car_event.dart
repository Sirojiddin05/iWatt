part of 'edit_car_bloc.dart';

@immutable
abstract class EditCarEvent {}

class EditSetTemporaryManufacturer extends EditCarEvent {
  final int manufacturer;
  EditSetTemporaryManufacturer(this.manufacturer);
}

class EditSetManufacturer extends EditCarEvent {
  final int manufacturer;
  EditSetManufacturer(this.manufacturer);
}

class EditSetTemporaryModel extends EditCarEvent {
  final int model;
  EditSetTemporaryModel(this.model);
}

class EditSetModel extends EditCarEvent {
  final int model;
  EditSetModel(this.model);
}

class EditSetTemporaryConnectorTypes extends EditCarEvent {
  final List<int> connectorTypes;
  EditSetTemporaryConnectorTypes(this.connectorTypes);
}

class EditSetConnectorTypes extends EditCarEvent {
  final List<int> connectorTypes;
  EditSetConnectorTypes(this.connectorTypes);
}

class EditCar extends EditCarEvent {
  final CarEntity car;
  EditCar(this.car);
}
