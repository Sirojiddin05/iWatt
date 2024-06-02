part of 'about_us_bloc.dart';

class AboutUsState extends Equatable {
  final FormzSubmissionStatus getAboutUsStatus;
  final FormzSubmissionStatus getHelpStatus;
  final AboutUsEntity aboutUs;
  final HelpEntity help;

  const AboutUsState({
    this.getHelpStatus = FormzSubmissionStatus.initial,
    this.getAboutUsStatus = FormzSubmissionStatus.initial,
    this.aboutUs = const AboutUsEntity(),
    this.help = const HelpEntity(),
  });

  AboutUsState copyWith({
    FormzSubmissionStatus? getHelpStatus,
    FormzSubmissionStatus? getAboutUsStatus,
    AboutUsEntity? aboutUs,
    HelpEntity? help,
  }) {
    return AboutUsState(
      getAboutUsStatus: getAboutUsStatus ?? this.getAboutUsStatus,
      getHelpStatus: getHelpStatus ?? this.getHelpStatus,
      aboutUs: aboutUs ?? this.aboutUs,
      help: help ?? this.help,
    );
  }

  @override
  List<Object> get props => [getHelpStatus, help, getAboutUsStatus, aboutUs];
}
