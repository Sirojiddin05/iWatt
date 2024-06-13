import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:i_watt_app/core/error/failure_handler.dart';
import 'package:i_watt_app/features/authorization/domain/entities/verify_code_params_entity.dart';
import 'package:i_watt_app/features/authorization/domain/usecases/login_usecase.dart';
import 'package:i_watt_app/features/authorization/domain/usecases/login_with_qr_usecase.dart';
import 'package:i_watt_app/features/authorization/domain/usecases/verify_code_usecase.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final LoginUseCase loginUseCase;
  final VerifyCodeUseCase verifyCodeUseCase;
  final LoginWithQrUseCase loginWithQrUseCase;
  Timer _otpTimer = Timer(Duration.zero, () {});
  SignInBloc({
    required this.loginUseCase,
    required this.verifyCodeUseCase,
    required this.loginWithQrUseCase,
  }) : super(const SignInState()) {
    on<ChangePhone>(_changePhone);
    on<SignIn>(_signIn);
    on<ChangeOTP>(_changeOTP);
    on<VerifyCode>(_verifyCode);
    on<CodeAvailableTimeDecreased>(_onCodeAvailableTimeDecreased);
    on<ResendCode>(_onResendCode);
    on<SignInWithQrEvent>(_signInWithQrEvent);
  }

  void _changePhone(ChangePhone event, Emitter<SignInState> emit) {
    emit(state.copyWith(tempPhone: event.phone));
  }

  void _signIn(SignIn event, Emitter<SignInState> emit) async {
    emit(state.copyWith(signInStatus: FormzSubmissionStatus.inProgress));
    if (state.tempPhone != state.verifiedPhone && state.codeAvailableTime != 0) {
      final result = await loginUseCase(state.tempPhone);
      if (result.isRight) {
        emit(
          state.copyWith(
            signInStatus: FormzSubmissionStatus.success,
            verifiedPhone: state.tempPhone,
            session: result.right,
            codeAvailableTime: 60,
          ),
        );
        _setTimer();
      } else {
        print(' result${result.left.errorMessage}');
        emit(state.copyWith(
          signInStatus: FormzSubmissionStatus.failure,
          signInErrorMessage: result.left.errorMessage,
        ));
      }
    } else {
      emit(state.copyWith(
        signInStatus: FormzSubmissionStatus.success,
      ));
    }
  }

  void _changeOTP(ChangeOTP event, Emitter<SignInState> emit) {
    emit(state.copyWith(otp: event.otp));
  }

  void _verifyCode(VerifyCode event, Emitter<SignInState> emit) async {
    emit(state.copyWith(verifyCodeStatus: FormzSubmissionStatus.inProgress));
    final result = await verifyCodeUseCase(VerifyCodeParamsEntity(
      code: state.otp,
      phone: state.verifiedPhone,
      session: state.session,
      type: 'login_sms_verification',
    ));
    if (result.isRight) {
      emit(state.copyWith(
        verifyCodeStatus: FormzSubmissionStatus.success,
        isNewUser: result.right,
      ));
    } else {
      final error = result.left;
      final isUserBlocked = error is ServerFailure && error.error.contains('user_is_blocked');
      emit(state.copyWith(
        verifyCodeStatus: FormzSubmissionStatus.failure,
        verifyCodeErrorMessage: result.left.errorMessage,
        isUserBlocked: isUserBlocked,
      ));
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

  void _signInWithQrEvent(SignInWithQrEvent event, Emitter<SignInState> emit) async {
    emit(state.copyWith(signInWithQrStatus: FormzSubmissionStatus.inProgress));
    final result = await loginWithQrUseCase(event.token);
    if (result.isRight) {
      emit(state.copyWith(signInWithQrStatus: FormzSubmissionStatus.success));
    } else {
      emit(state.copyWith(
        signInWithQrStatus: FormzSubmissionStatus.failure,
        signInWithQrErrorMessage: result.left.errorMessage,
      ));
    }
  }

  void _onResendCode(ResendCode event, Emitter<SignInState> emit) async {
    await verifyCodeUseCase(VerifyCodeParamsEntity(
      code: state.otp,
      phone: state.verifiedPhone,
      session: state.session,
      type: 'login_sms_verification',
    ));
    emit(state.copyWith(codeAvailableTime: 60));
    _setTimer();
  }
}
