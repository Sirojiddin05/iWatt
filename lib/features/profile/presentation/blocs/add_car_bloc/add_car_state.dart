part of 'add_car_bloc.dart';

class AddCarState extends Equatable {
  const AddCarState({
    this.status = FormzSubmissionStatus.initial,
    this.error = '',
    this.car = const CarEntity(),
    this.currentStep = 0,
    this.temporaryModel = -1,
    this.temporaryConnectorTypes = const [],
  });

  final FormzSubmissionStatus status;
  final String error;
  final CarEntity car;
  final int currentStep;
  final int temporaryModel;
  final List<int> temporaryConnectorTypes;

  AddCarState copyWith({
    FormzSubmissionStatus? status,
    String? error,
    CarEntity? car,
    int? currentStep,
    int? temporaryModel,
    List<int>? temporaryConnectorTypes,
  }) {
    return AddCarState(
      status: status ?? this.status,
      error: error ?? this.error,
      car: car ?? this.car,
      currentStep: currentStep ?? this.currentStep,
      temporaryModel: temporaryModel ?? this.temporaryModel,
      temporaryConnectorTypes: temporaryConnectorTypes ?? this.temporaryConnectorTypes,
    );
  }

  @override
  List<Object> get props => [
        status,
        error,
        car,
        currentStep,
        temporaryModel,
        temporaryConnectorTypes,
      ];
}
