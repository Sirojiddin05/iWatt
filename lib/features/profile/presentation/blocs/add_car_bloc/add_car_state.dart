part of 'add_car_bloc.dart';

class AddCarState extends Equatable {
  const AddCarState({
    this.status = FormzSubmissionStatus.initial,
    this.error = '',
    this.car = const CarEntity(),
    this.currentStep = 0,
    this.temporaryModel = const IdNameEntity(),
    this.temporaryManufacturer = const IdNameEntity(),
    this.temporaryConnectorTypes = const [],
    this.otherMark = '',
    this.otherModel = '',
  });

  final FormzSubmissionStatus status;
  final String error;
  final CarEntity car;
  final int currentStep;
  final IdNameEntity temporaryModel;
  final IdNameEntity temporaryManufacturer;
  final List<int> temporaryConnectorTypes;
  final String otherMark;
  final String otherModel;

  AddCarState copyWith({
    FormzSubmissionStatus? status,
    String? error,
    CarEntity? car,
    int? currentStep,
    IdNameEntity? temporaryModel,
    IdNameEntity? temporaryManufacturer,
    List<int>? temporaryConnectorTypes,
    String? otherMark,
    String? otherModel,
  }) {
    return AddCarState(
      status: status ?? this.status,
      error: error ?? this.error,
      car: car ?? this.car,
      currentStep: currentStep ?? this.currentStep,
      temporaryModel: temporaryModel ?? this.temporaryModel,
      temporaryConnectorTypes: temporaryConnectorTypes ?? this.temporaryConnectorTypes,
      otherMark: otherMark ?? this.otherMark,
      otherModel: otherModel ?? this.otherModel,
      temporaryManufacturer: temporaryManufacturer ?? this.temporaryManufacturer,
    );
  }

  @override
  List<Object> get props => [
        status,
        error,
        car,
        currentStep,
        temporaryModel,
        temporaryManufacturer,
        temporaryConnectorTypes,
        otherMark,
        otherModel,
      ];
}
