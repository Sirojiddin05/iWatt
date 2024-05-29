import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:i_watt_app/features/common/domain/entities/id_name_entity.dart';
import 'package:i_watt_app/features/profile/domain/entities/getModels_param_entity.dart';
import 'package:i_watt_app/features/profile/domain/usecases/get_models_usecase.dart';
import 'package:i_watt_app/generated/locale_keys.g.dart';

part 'models_event.dart';
part 'models_state.dart';

class ModelsBloc extends Bloc<ModelsEvent, ModelsState> {
  final GetModelsUseCase getModelsUseCase;
  ModelsBloc(this.getModelsUseCase) : super(const ModelsState()) {
    on<GetModels>((event, emit) async {
      emit(state.copyWith(getModelsStatus: FormzSubmissionStatus.inProgress));
      final result = await getModelsUseCase(GetModelsParamEntity(manufacturerId: state.manufacturerId));
      if (result.isRight) {
        emit(state.copyWith(
          getModelsStatus: FormzSubmissionStatus.success,
          models: [
            ...result.right.results,
            IdNameEntity(
              id: 0,
              name: LocaleKeys.other_neuter.tr(),
            ),
          ],
        ));
      } else {
        emit(state.copyWith(
          getModelsStatus: FormzSubmissionStatus.failure,
          error: result.left.errorMessage,
        ));
      }
    });
    on<SetManufacturerId>((event, emit) {
      emit(state.copyWith(manufacturerId: event.manufacturerId));
      add(GetModels());
    });
  }
}
