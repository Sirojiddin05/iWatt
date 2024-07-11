import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:i_watt_app/core/usecases/base_usecase.dart';
import 'package:i_watt_app/features/common/domain/entities/location_filter_key_entity.dart';
import 'package:i_watt_app/features/common/domain/usecases/get_location_filter_keys_usecase.dart';
import 'package:meta/meta.dart';

part 'location_filter_key_event.dart';
part 'location_filter_key_state.dart';

class LocationFilterKeyBloc extends Bloc<LocationFilterKeyEvent, LocationFilterKeyState> {
  final GetLocationFilterKeysUseCase _getLocationFilterKeysUseCase;

  LocationFilterKeyBloc(this._getLocationFilterKeysUseCase) : super(const LocationFilterKeyState()) {
    on<GetLocationFilterKeysEvent>(_getLocationFilterKeys);
  }

  void _getLocationFilterKeys(GetLocationFilterKeysEvent event, Emitter<LocationFilterKeyState> emit) async {
    try {
      emit(state.copyWith(filterKeysStatus: FormzSubmissionStatus.inProgress));
      final result = await _getLocationFilterKeysUseCase.call(NoParams());
      if (result.isRight) {
        emit(state.copyWith(
          filterKeysStatus: FormzSubmissionStatus.success,
          filterKeys: result.right,
        ));
      } else {
        emit(state.copyWith(
          filterKeysStatus: FormzSubmissionStatus.failure,
          filterKeysError: result.left.errorMessage,
        ));
      }
    } catch (e) {
      print(e);
    }
  }
}
