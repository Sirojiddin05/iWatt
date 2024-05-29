import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'car_models_event.dart';
part 'car_models_state.dart';

class CarModelsBloc extends Bloc<CarModelsEvent, CarModelsState> {
  CarModelsBloc() : super(CarModelsInitial()) {
    on<CarModelsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
