import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'models_event.dart';
part 'models_state.dart';

class ModelsBloc extends Bloc<ModelsEvent, ModelsState> {
  ModelsBloc() : super(ModelsInitial()) {
    on<ModelsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
