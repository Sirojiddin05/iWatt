part of 'profile_bloc.dart';

class ProfileState extends Equatable {
  const ProfileState({
    this.getUserDataStatus = FormzSubmissionStatus.initial,
    this.user = const UserEntity(),
    this.deleteAccountStatus = FormzSubmissionStatus.initial,
    this.getUserDataErrorMessage = '',
  });

  final FormzSubmissionStatus getUserDataStatus;
  final UserEntity user;
  final String getUserDataErrorMessage;
  final FormzSubmissionStatus deleteAccountStatus;

  ProfileState copyWith({
    FormzSubmissionStatus? getUserDataStatus,
    UserEntity? user,
    FormzSubmissionStatus? deleteAccountStatus,
    String? getUserDataErrorMessage,
  }) {
    return ProfileState(
      getUserDataStatus: getUserDataStatus ?? this.getUserDataStatus,
      user: user ?? this.user,
      deleteAccountStatus: deleteAccountStatus ?? this.deleteAccountStatus,
      getUserDataErrorMessage: getUserDataErrorMessage ?? this.getUserDataErrorMessage,
    );
  }

  @override
  List<Object> get props => [
        getUserDataStatus,
        user,
        deleteAccountStatus,
      ];
}
