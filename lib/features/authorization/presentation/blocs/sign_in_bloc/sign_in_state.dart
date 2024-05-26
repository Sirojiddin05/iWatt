part of 'sign_in_bloc.dart';

class SignInState extends Equatable {
  const SignInState({
    this.signInStatus = FormzSubmissionStatus.initial,
    this.verifyCodeStatus = FormzSubmissionStatus.initial,
    this.signInErrorMessage = '',
    this.verifyCodeErrorMessage = '',
    this.verifiedPhone = '',
    this.tempPhone = '',
    this.otp = '',
    this.codeAvailableTime = 60,
    this.isUserBlocked = false,
    this.isNewUser = false,
  });

  final FormzSubmissionStatus signInStatus;
  final FormzSubmissionStatus verifyCodeStatus;
  final String signInErrorMessage;
  final String verifyCodeErrorMessage;
  final String verifiedPhone;
  final String tempPhone;
  final String otp;
  final int codeAvailableTime;
  final bool isUserBlocked;
  final bool isNewUser;

  SignInState copyWith({
    FormzSubmissionStatus? signInStatus,
    FormzSubmissionStatus? verifyCodeStatus,
    String? signInErrorMessage,
    String? verifyCodeErrorMessage,
    String? verifiedPhone,
    String? tempPhone,
    String? otp,
    int? codeAvailableTime,
    bool? isUserBlocked,
    bool? isNewUser,
  }) {
    return SignInState(
      signInStatus: signInStatus ?? this.signInStatus,
      verifyCodeStatus: verifyCodeStatus ?? this.verifyCodeStatus,
      signInErrorMessage: signInErrorMessage ?? this.signInErrorMessage,
      verifyCodeErrorMessage: verifyCodeErrorMessage ?? this.verifyCodeErrorMessage,
      verifiedPhone: verifiedPhone ?? this.verifiedPhone,
      tempPhone: tempPhone ?? this.tempPhone,
      otp: otp ?? this.otp,
      codeAvailableTime: codeAvailableTime ?? this.codeAvailableTime,
      isUserBlocked: isUserBlocked ?? this.isUserBlocked,
      isNewUser: isNewUser ?? this.isNewUser,
    );
  }

  @override
  List<Object> get props => [
        signInStatus,
        verifyCodeStatus,
        signInErrorMessage,
        verifyCodeErrorMessage,
        verifiedPhone,
        tempPhone,
        codeAvailableTime,
        isUserBlocked,
        isNewUser,
        otp,
      ];
}
