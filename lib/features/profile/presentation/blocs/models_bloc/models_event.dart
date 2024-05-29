part of 'models_bloc.dart';

@immutable
abstract class ModelsEvent {}

class GetModels extends ModelsEvent {
  GetModels();
}

class SetManufacturerId extends ModelsEvent {
  final int manufacturerId;
  SetManufacturerId(this.manufacturerId);
}
