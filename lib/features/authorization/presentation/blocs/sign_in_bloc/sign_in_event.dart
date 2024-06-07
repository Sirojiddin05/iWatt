part of 'sign_in_bloc.dart';

@immutable
abstract class SignInEvent {
  const SignInEvent();
}

class ChangePhone extends SignInEvent {
  final String phone;
  const ChangePhone({required this.phone});
}

class SignIn extends SignInEvent {}

class ChangeOTP extends SignInEvent {
  final String otp;
  const ChangeOTP({required this.otp});
}

class VerifyCode extends SignInEvent {
  final String code;
  const VerifyCode({required this.code});
}

class CodeAvailableTimeDecreased extends SignInEvent {}

class ResendCode extends SignInEvent {}

class ClearOtp extends SignInEvent {}

// class Lo
