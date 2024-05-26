import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:i_watt_app/core/usecases/base_usecase.dart';
import 'package:i_watt_app/features/common/domain/entities/about_us_entity.dart';
import 'package:i_watt_app/features/common/domain/usecases/get_about_usecase.dart';

part 'about_us_event.dart';
part 'about_us_state.dart';

class AboutUsBloc extends Bloc<AboutUsEvent, AboutUsState> {
  final GetAboutUsUseCase _getAboutData;
  AboutUsBloc(this._getAboutData) : super(const AboutUsState()) {
    on<GetAboutUsEvent>((event, emit) async {
      emit(state.copyWith(getAboutUsStatus: FormzSubmissionStatus.inProgress));
      final result = await _getAboutData.call(NoParams());
      if (result.isRight) {
        emit(state.copyWith(getAboutUsStatus: FormzSubmissionStatus.success, aboutUs: result.right));
      } else {
        emit(state.copyWith(getAboutUsStatus: FormzSubmissionStatus.failure));
      }
    });
  }
}
