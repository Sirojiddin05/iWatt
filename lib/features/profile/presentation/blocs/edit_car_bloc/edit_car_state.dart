part of 'edit_car_bloc.dart';

class EditCarState extends Equatable {
  final FormzSubmissionStatus status;
  final CarEntity car;
  final int temporaryManufacturer;
  final int temporaryModel;
  final List<int> temporaryConnectorTypes;

  const EditCarState({
    this.status = FormzSubmissionStatus.initial,
    this.car = const CarEntity(),
    this.temporaryManufacturer = -1,
    this.temporaryModel = -1,
    this.temporaryConnectorTypes = const [],
  });

  EditCarState copyWith({
    FormzSubmissionStatus? status,
    CarEntity? car,
    int? temporaryManufacturer,
    int? temporaryModel,
    List<int>? temporaryConnectorTypes,
  }) {
    return EditCarState(
      status: status ?? this.status,
      car: car ?? this.car,
      temporaryManufacturer: temporaryManufacturer ?? this.temporaryManufacturer,
      temporaryModel: temporaryModel ?? this.temporaryModel,
      temporaryConnectorTypes: temporaryConnectorTypes ?? this.temporaryConnectorTypes,
    );
  }

  @override
  List<Object> get props => [
        status,
        car,
        temporaryManufacturer,
        temporaryModel,
        temporaryConnectorTypes,
      ];
}
