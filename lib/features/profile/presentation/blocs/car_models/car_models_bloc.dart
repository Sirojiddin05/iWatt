import 'package:flutter_bloc/flutter_bloc.dart';
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
