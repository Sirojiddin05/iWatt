import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:i_watt_app/core/util/enums/gender.dart';
import 'package:meta/meta.dart';

part 'registration_event.dart';
part 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  RegistrationBloc() : super(const RegistrationState()) {
    on<ChangeFullName>(_onChangeFullName);
    on<ChangeGender>(_onChangeGender);
    on<ChangeBirthDate>(_onChangeBirthDate);
    on<Register>(_onRegister);
  }
  void _onChangeFullName(ChangeFullName event, Emitter<RegistrationState> emit) {
    emit(state.copyWith(fullName: event.fullName));
  }

  void _onChangeGender(ChangeGender event, Emitter<RegistrationState> emit) {
    emit(state.copyWith(gender: event.gender));
  }

  void _onChangeBirthDate(ChangeBirthDate event, Emitter<RegistrationState> emit) {
    emit(state.copyWith(birthDate: event.birthDate));
  }

  void _onRegister(Register event, Emitter<RegistrationState> emit) async {
    emit(state.copyWith(registerStatus: FormzSubmissionStatus.inProgress));
    await Future.delayed(const Duration(seconds: 1));
    if (false) {
      emit(state.copyWith(registerStatus: FormzSubmissionStatus.success));
    } else {
      emit(state.copyWith(registerStatus: FormzSubmissionStatus.failure, errorMessage: 'Error'));
    }
  }
}
