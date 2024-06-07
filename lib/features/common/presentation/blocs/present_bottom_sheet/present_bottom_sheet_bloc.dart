import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'present_bottom_sheet_event.dart';
part 'present_bottom_sheet_state.dart';

class PresentBottomSheetBloc extends Bloc<PresentBottomSheetEvent, PresentBottomSheetState> {
  PresentBottomSheetBloc() : super(const PresentBottomSheetState()) {
    on<ShowPresentBottomSheet>((event, emit) {
      emit(state.copyWith(isPresented: event.isPresented));
    });
  }
}
