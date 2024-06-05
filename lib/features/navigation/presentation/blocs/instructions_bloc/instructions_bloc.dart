import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:i_watt_app/core/util/enums/instructions_type.dart';
import 'package:i_watt_app/features/navigation/domain/entity/version_features_entity.dart';
import 'package:i_watt_app/features/navigation/domain/usecases/get_instructions_usecase.dart';
import 'package:meta/meta.dart';

part 'instructions_event.dart';
part 'instructions_state.dart';

class InstructionsBloc extends Bloc<InstructionsEvent, InstructionsState> {
  final GetInstructionsUseCase _getInstructionsUseCase;

  InstructionsBloc(this._getInstructionsUseCase) : super(const InstructionsState()) {
    on<GetInstructionsEvent>((event, emit) async {
      emit(event.type == InstructionsType.onboarding.name
          ? state.copyWith(getOnBoardingStatus: FormzSubmissionStatus.inProgress)
          : state.copyWith(getInstructionsStatus: FormzSubmissionStatus.inProgress));

      final result = await _getInstructionsUseCase.call(event.type);
      if (result.isRight) {
        emit(event.type == InstructionsType.onboarding.name
            ? state.copyWith(
                getOnBoardingStatus: FormzSubmissionStatus.success,
                onBoarding: result.right.results,
              )
            : state.copyWith(
                getInstructionsStatus: FormzSubmissionStatus.success,
                instructions: result.right.results,
              ));
      } else if (result.isLeft) {
        emit(event.type == InstructionsType.onboarding.name
            ? state.copyWith(getOnBoardingStatus: FormzSubmissionStatus.failure)
            : state.copyWith(getInstructionsStatus: FormzSubmissionStatus.failure));
      }
    });
  }
}
