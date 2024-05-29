part of 'cars_bloc.dart';

class CarsState extends Equatable {
  const CarsState({
    this.getCarsStatus = FormzSubmissionStatus.initial,
    this.getCarsErrorMessage = '',
    this.deleteCarStatus = FormzSubmissionStatus.initial,
    this.deleteCarErrorMessage = '',
    this.cars = const [],
  });

  final FormzSubmissionStatus getCarsStatus;
  final String getCarsErrorMessage;
  final FormzSubmissionStatus deleteCarStatus;
  final String deleteCarErrorMessage;
  final List<CarEntity> cars;

  CarsState copyWith({
    FormzSubmissionStatus? getCarsStatus,
    String? getCarsErrorMessage,
    FormzSubmissionStatus? deleteCarStatus,
    String? deleteCarErrorMessage,
    FormzSubmissionStatus? addCarStatus,
    List<CarEntity>? cars,
  }) {
    return CarsState(
      getCarsStatus: getCarsStatus ?? this.getCarsStatus,
      getCarsErrorMessage: getCarsErrorMessage ?? this.getCarsErrorMessage,
      deleteCarStatus: deleteCarStatus ?? this.deleteCarStatus,
      deleteCarErrorMessage: deleteCarErrorMessage ?? this.deleteCarErrorMessage,
      cars: cars ?? this.cars,
    );
  }

  @override
  List<Object> get props => [
        getCarsStatus,
        getCarsErrorMessage,
        deleteCarStatus,
        deleteCarErrorMessage,
        cars,
      ];
}
