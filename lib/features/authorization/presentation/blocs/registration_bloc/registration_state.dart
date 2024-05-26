part of 'registration_bloc.dart';

class RegistrationState extends Equatable {
  final String fullName;
  final DateTime? birthDate;
  final Gender gender;
  final FormzSubmissionStatus registerStatus;
  final String errorMessage;

  const RegistrationState({
    this.fullName = '',
    this.birthDate,
    this.gender = Gender.male,
    this.registerStatus = FormzSubmissionStatus.initial,
    this.errorMessage = '',
  });

  RegistrationState copyWith({
    String? fullName,
    DateTime? birthDate,
    Gender? gender,
    FormzSubmissionStatus? registerStatus,
    String? errorMessage,
  }) {
    return RegistrationState(
      fullName: fullName ?? this.fullName,
      birthDate: birthDate ?? this.birthDate,
      gender: gender ?? this.gender,
      registerStatus: registerStatus ?? this.registerStatus,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  bool isButtonDisabled() {
    return fullName.isEmpty || birthDate == null;
  }

  @override
  List<Object?> get props => [
        fullName,
        birthDate,
        gender,
        registerStatus,
        errorMessage,
      ];
}
