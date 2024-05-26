part of 'about_us_bloc.dart';

class AboutUsState extends Equatable {
  final FormzSubmissionStatus getAboutUsStatus;
  final AboutUsEntity aboutUs;

  const AboutUsState({
    this.getAboutUsStatus = FormzSubmissionStatus.initial,
    this.aboutUs = const AboutUsEntity(),
  });

  AboutUsState copyWith({
    FormzSubmissionStatus? getAboutUsStatus,
    AboutUsEntity? aboutUs,
  }) {
    return AboutUsState(
      getAboutUsStatus: getAboutUsStatus ?? this.getAboutUsStatus,
      aboutUs: aboutUs ?? this.aboutUs,
    );
  }

  @override
  List<Object> get props => [getAboutUsStatus, aboutUs];
}
