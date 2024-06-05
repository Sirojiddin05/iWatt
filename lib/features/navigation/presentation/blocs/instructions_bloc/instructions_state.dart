part of 'instructions_bloc.dart';

class InstructionsState extends Equatable {
  final FormzSubmissionStatus getInstructionsStatus;
  final FormzSubmissionStatus getOnBoardingStatus;
  final List<VersionFeaturesEntity> instructions;
  final List<VersionFeaturesEntity> onBoarding;

  const InstructionsState({
    this.instructions = const [],
    this.onBoarding = const [],
    this.getOnBoardingStatus = FormzSubmissionStatus.initial,
    this.getInstructionsStatus = FormzSubmissionStatus.initial,
  });

  InstructionsState copyWith({
    List<VersionFeaturesEntity>? onBoarding,
    List<VersionFeaturesEntity>? instructions,
    FormzSubmissionStatus? getOnBoardingStatus,
    FormzSubmissionStatus? getInstructionsStatus,
  }) {
    return InstructionsState(
      onBoarding: onBoarding ?? this.onBoarding,
      getOnBoardingStatus: getOnBoardingStatus ?? this.getOnBoardingStatus,
      instructions: instructions ?? this.instructions,
      getInstructionsStatus: getInstructionsStatus ?? this.getInstructionsStatus,
    );
  }

  @override
  List<Object> get props => [getInstructionsStatus, instructions, getOnBoardingStatus, onBoarding];
}
