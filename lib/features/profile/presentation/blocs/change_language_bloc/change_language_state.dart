part of 'change_language_bloc.dart';

class ChangeLanguageState extends Equatable {
  const ChangeLanguageState({this.changeLanguageStatus = FormzSubmissionStatus.initial});

  final FormzSubmissionStatus changeLanguageStatus;

  ChangeLanguageState copyWith({
    FormzSubmissionStatus? changeLanguageStatus,
  }) {
    return ChangeLanguageState(
      changeLanguageStatus: changeLanguageStatus ?? this.changeLanguageStatus,
    );
  }

  @override
  List<Object> get props => [changeLanguageStatus];
}
