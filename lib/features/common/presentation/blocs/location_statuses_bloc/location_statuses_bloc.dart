import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:i_watt_app/core/usecases/base_usecase.dart';
import 'package:i_watt_app/features/common/domain/entities/location_filter_key_entity.dart';
import 'package:i_watt_app/features/common/domain/usecases/get_location_filter_keys_usecase.dart';
import 'package:meta/meta.dart';

part 'location_statuses_event.dart';
part 'location_statuses_state.dart';

class LocationStatusesBloc extends Bloc<LocationStatusesEvent, LocationStatuesState> {
  final GetLocationFilterKeysUseCase _getLocationFilterKeysUseCase;

  LocationStatusesBloc(this._getLocationFilterKeysUseCase) : super(const LocationStatuesState()) {
    on<GetLocationStatusesEvent>(_getLocationStatusesKeys);
  }

  void _getLocationStatusesKeys(GetLocationStatusesEvent event, Emitter<LocationStatuesState> emit) async {
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
  }
}
