import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:i_watt_app/core/usecases/base_usecase.dart';
import 'package:i_watt_app/features/common/domain/entities/id_name_entity.dart';
import 'package:i_watt_app/features/common/domain/usecases/get_power_groups_usecase.dart';
import 'package:meta/meta.dart';

part 'power_types_event.dart';
part 'power_types_state.dart';

class PowerTypesBloc extends Bloc<PowerTypesEvent, PowerTypesState> {
  final GetPowerTypesUseCase getPowerTypesUseCase;
  PowerTypesBloc(this.getPowerTypesUseCase) : super(const PowerTypesState()) {
    on<GetPowerTypesEvent>((event, emit) async {
      emit(state.copyWith(getPowerTypesStatus: FormzSubmissionStatus.inProgress));
      final result = await getPowerTypesUseCase.call(NoParams());
      if (result.isRight) {
        emit(state.copyWith(getPowerTypesStatus: FormzSubmissionStatus.success, powerTypes: result.right.results));
      } else {
        emit(state.copyWith(getPowerTypesStatus: FormzSubmissionStatus.failure));
      }
    });
  }
}
