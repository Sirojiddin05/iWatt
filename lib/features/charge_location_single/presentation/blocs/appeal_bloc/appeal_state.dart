part of 'appeal_bloc.dart';

class AppealState extends Equatable {
  final FormzSubmissionStatus getAppealsStatus;
  final FormzSubmissionStatus sendAppealStatus;
  final List<IdNameEntity> appeals;
  final String? next;
  final bool fetchMore;
  final String sendErrorMessage;
  final String getErrorMessage;

  const AppealState({
    this.getAppealsStatus = FormzSubmissionStatus.initial,
    this.sendAppealStatus = FormzSubmissionStatus.initial,
    this.appeals = const [],
    this.next,
    this.fetchMore = false,
    this.sendErrorMessage = '',
    this.getErrorMessage = '',
  });

  AppealState copyWith({
    FormzSubmissionStatus? getAppealsStatus,
    FormzSubmissionStatus? appealDetailStatus,
    FormzSubmissionStatus? sendAppealStatus,
    List<IdNameEntity>? appeals,
    String? next,
    bool? fetchMore,
    String? sendErrorMessage,
    String? getErrorMessage,
  }) {
    return AppealState(
      getAppealsStatus: getAppealsStatus ?? this.getAppealsStatus,
      sendAppealStatus: sendAppealStatus ?? this.sendAppealStatus,
      appeals: appeals ?? this.appeals,
      next: next ?? this.next,
      fetchMore: fetchMore ?? this.fetchMore,
      sendErrorMessage: sendErrorMessage ?? this.sendErrorMessage,
      getErrorMessage: getErrorMessage ?? this.getErrorMessage,
    );
  }

  @override
  List<Object?> get props => [
        fetchMore,
        next,
        appeals,
        getAppealsStatus,
        sendAppealStatus,
        getErrorMessage,
      ];
}
