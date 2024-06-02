import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:i_watt_app/core/usecases/base_usecase.dart';
import 'package:i_watt_app/features/common/domain/entities/about_us_entity.dart';
import 'package:i_watt_app/features/common/domain/entities/help_entity.dart';
import 'package:i_watt_app/features/common/domain/usecases/get_about_us_usecase.dart';
import 'package:i_watt_app/features/common/domain/usecases/get_help_usecase.dart';

part 'about_us_event.dart';
part 'about_us_state.dart';

class AboutUsBloc extends Bloc<AboutUsEvent, AboutUsState> {
  final GetAboutUsUseCase _getAboutUsUseCase;
  final GetHelpUseCase _getHelpData;

  AboutUsBloc(this._getHelpData, this._getAboutUsUseCase) : super(const AboutUsState()) {
    on<GetHelpEvent>((event, emit) async {
      emit(state.copyWith(getHelpStatus: FormzSubmissionStatus.inProgress));

      final result = await _getHelpData.call(NoParams());
      if (result.isRight) {
        emit(state.copyWith(getHelpStatus: FormzSubmissionStatus.success, help: result.right));
      } else {
        emit(state.copyWith(getHelpStatus: FormzSubmissionStatus.failure));
      }
    });
    on<GetAboutUsEvent>((event, emit) async {
      emit(state.copyWith(getAboutUsStatus: FormzSubmissionStatus.inProgress));

      final result = await _getAboutUsUseCase.call(NoParams());

      if (result.isRight) {
        emit(state.copyWith(getAboutUsStatus: FormzSubmissionStatus.success, aboutUs: result.right));
      } else {
        emit(state.copyWith(getAboutUsStatus: FormzSubmissionStatus.failure));
      }
    });
  }
}
