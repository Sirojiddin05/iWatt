part of 'registration_bloc.dart';

@immutable
abstract class RegistrationEvent {
  const RegistrationEvent();
}

class ChangeFullName extends RegistrationEvent {
  final String fullName;

  const ChangeFullName(this.fullName);
}

class ChangeGender extends RegistrationEvent {
  final Gender gender;
  const ChangeGender(this.gender);
}

class ChangeBirthDate extends RegistrationEvent {
  final DateTime birthDate;
  const ChangeBirthDate(this.birthDate);
}

class Register extends RegistrationEvent {
  const Register();
}
