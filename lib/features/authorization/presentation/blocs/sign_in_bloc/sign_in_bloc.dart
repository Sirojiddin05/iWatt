import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  Timer _otpTimer = Timer(Duration.zero, () {});
  SignInBloc() : super(const SignInState()) {
    on<ChangePhone>(_changePhone);
    on<SignIn>(_signIn);
    on<ChangeOTP>(_changeOTP);
    on<VerifyCode>(_verifyCode);
    on<CodeAvailableTimeDecreased>(_onCodeAvailableTimeDecreased);
    on<ResendCode>(_onResendCode);
  }

  void _changePhone(ChangePhone event, Emitter<SignInState> emit) {
    emit(state.copyWith(tempPhone: event.phone));
  }

  void _signIn(SignIn event, Emitter<SignInState> emit) async {
    emit(state.copyWith(signInStatus: FormzSubmissionStatus.inProgress));
    if (state.tempPhone != state.verifiedPhone && state.codeAvailableTime != 0) {
      await Future.delayed(const Duration(seconds: 1));
      if (true) {
        emit(state.copyWith(signInStatus: FormzSubmissionStatus.success, verifiedPhone: state.tempPhone, codeAvailableTime: 60));
        _setTimer();
      } else {
        emit(state.copyWith(signInStatus: FormzSubmissionStatus.failure, signInErrorMessage: 'Error'));
      }
    } else {
      emit(state.copyWith(signInStatus: FormzSubmissionStatus.success));
    }
  }

  void _changeOTP(ChangeOTP event, Emitter<SignInState> emit) {
    emit(state.copyWith(otp: event.otp));
  }

  void _verifyCode(VerifyCode event, Emitter<SignInState> emit) async {
    emit(state.copyWith(verifyCodeStatus: FormzSubmissionStatus.inProgress));
    await Future.delayed(const Duration(seconds: 1));
    if (true) {
      emit(state.copyWith(verifyCodeStatus: FormzSubmissionStatus.success, isNewUser: true));
    } else {
      emit(state.copyWith(verifyCodeStatus: FormzSubmissionStatus.failure, verifyCodeErrorMessage: 'Error', isUserBlocked: true));
    }
  }

  void _setTimer() {
    if (_otpTimer.isActive) {
      _otpTimer.cancel();
    }
    _otpTimer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (state.codeAvailableTime == 0) {
        timer.cancel();
      }
      add(CodeAvailableTimeDecreased());
    });
  }

  void _onCodeAvailableTimeDecreased(CodeAvailableTimeDecreased event, Emitter<SignInState> emit) {
    if (state.codeAvailableTime > 0) {
      emit(state.copyWith(codeAvailableTime: state.codeAvailableTime - 1));
    }
  }

  void _onResendCode(ResendCode event, Emitter<SignInState> emit) {
    emit(state.copyWith(codeAvailableTime: 60));
    _setTimer();
  }
}
