import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:i_watt_app/core/usecases/base_usecase.dart';
import 'package:i_watt_app/features/profile/domain/entities/car_entity.dart';
import 'package:i_watt_app/features/profile/domain/usecases/delete_car_usecase.dart';
import 'package:i_watt_app/features/profile/domain/usecases/get_cars_use_case.dart';

part 'cars_event.dart';
part 'cars_state.dart';

class CarsBloc extends Bloc<CarsEvent, CarsState> {
  final DeleteCarUseCase deleteCarUseCase;
  final GetCarsUseCase getCarsUseCase;

  CarsBloc({
    required this.deleteCarUseCase,
    required this.getCarsUseCase,
  }) : super(const CarsState()) {
    on<GetCarsEvent>((event, emit) async {
      emit(state.copyWith(getCarsStatus: FormzSubmissionStatus.inProgress));
      try {
        final result = await getCarsUseCase.call(NoParams());
        if (result.isRight) {
          print(result.right.results.length);
          emit(
            state.copyWith(getCarsStatus: FormzSubmissionStatus.success, cars: [...result.right.results]),
          );
        } else {
          emit(
            state.copyWith(getCarsStatus: FormzSubmissionStatus.failure, getCarsErrorMessage: result.left.errorMessage),
          );
        }
      } catch (e) {
        log("ParseError->$e");
      }
    });
    on<DeleteCarEvent>((event, emit) async {
      emit(state.copyWith(deleteCarStatus: FormzSubmissionStatus.inProgress));
      final result = await deleteCarUseCase.call(event.carId);
      if (result.isRight) {
        emit(
          state.copyWith(
            deleteCarStatus: FormzSubmissionStatus.success,
            cars: [...state.cars.where((e) => e.id != event.carId)],
          ),
        );
      } else {
        emit(
          state.copyWith(
            deleteCarStatus: FormzSubmissionStatus.failure,
            deleteCarErrorMessage: result.left.errorMessage,
          ),
        );
      }
    });
    on<AddCarLocallyEvent>((event, emit) {
      emit(state.copyWith(cars: [...state.cars, event.car]));
    });
  }
}
