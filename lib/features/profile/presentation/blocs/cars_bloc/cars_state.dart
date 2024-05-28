part of 'cars_bloc.dart';

class CarsState extends Equatable {
  const CarsState({
    this.getCarsStatus = FormzSubmissionStatus.initial,
    this.deleteCarStatus = FormzSubmissionStatus.initial,
    this.addCarStatus = FormzSubmissionStatus.initial,
    this.cars = const [],
  });

  final FormzSubmissionStatus getCarsStatus;
  final FormzSubmissionStatus deleteCarStatus;
  final FormzSubmissionStatus addCarStatus;
  final List<CarEntity> cars;

  @override
  List<Object> get props => [
        getCarsStatus,
        deleteCarStatus,
        addCarStatus,
        cars,
      ];
}
