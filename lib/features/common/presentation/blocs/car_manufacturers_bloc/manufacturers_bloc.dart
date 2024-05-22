import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'manufacturers_event.dart';
part 'manufacturers_state.dart';

class ManufacturersBloc extends Bloc<ManufacturersEvent, ManufacturersState> {
  ManufacturersBloc() : super(ManufacturersInitial()) {
    on<ManufacturersEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
