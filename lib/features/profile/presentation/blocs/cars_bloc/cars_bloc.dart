import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:i_watt_app/features/profile/domain/entities/car_model_entity.dart';

part 'cars_event.dart';
part 'cars_state.dart';

class CarsBloc extends Bloc<CarsEvent, CarsState> {
  CarsBloc() : super(const CarsState()) {
    on<CarsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
