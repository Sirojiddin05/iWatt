part of 'profile_bloc.dart';

class ProfileState extends Equatable {
  const ProfileState({
    this.getUserDataStatus = FormzSubmissionStatus.initial,
    this.user = const UserEntity(),
    this.deleteAccountStatus = FormzSubmissionStatus.initial,
    this.getUserDataErrorMessage = '',
    this.deleteAccountErrorMessage = '',
    this.updateProfileStatus = FormzSubmissionStatus.initial,
    this.updateErrorMessage = '',
  });

  final FormzSubmissionStatus getUserDataStatus;
  final UserEntity user;
  final String getUserDataErrorMessage;
  final FormzSubmissionStatus deleteAccountStatus;
  final String deleteAccountErrorMessage;
  final FormzSubmissionStatus updateProfileStatus;
  final String updateErrorMessage;

  ProfileState copyWith({
    FormzSubmissionStatus? getUserDataStatus,
    UserEntity? user,
    FormzSubmissionStatus? deleteAccountStatus,
    String? getUserDataErrorMessage,
    String? deleteAccountErrorMessage,
    FormzSubmissionStatus? updateProfileStatus,
    String? updateErrorMessage,
  }) {
    return ProfileState(
      getUserDataStatus: getUserDataStatus ?? this.getUserDataStatus,
      user: user ?? this.user,
      deleteAccountStatus: deleteAccountStatus ?? this.deleteAccountStatus,
      getUserDataErrorMessage: getUserDataErrorMessage ?? this.getUserDataErrorMessage,
      deleteAccountErrorMessage: deleteAccountErrorMessage ?? this.deleteAccountErrorMessage,
      updateProfileStatus: updateProfileStatus ?? this.updateProfileStatus,
      updateErrorMessage: updateErrorMessage ?? this.updateErrorMessage,
    );
  }

  @override
  List<Object> get props => [
        getUserDataStatus,
        user,
        getUserDataErrorMessage,
        deleteAccountStatus,
        deleteAccountErrorMessage,
        updateProfileStatus,
        updateErrorMessage,
      ];
}
