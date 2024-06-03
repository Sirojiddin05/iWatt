part of 'version_check_bloc.dart';

class VersionCheckState extends Equatable {
  final FormzSubmissionStatus getVersionStatus;
  final bool isRequired;
  final bool needToUpdate;
  final String version;

  const VersionCheckState({
    this.getVersionStatus = FormzSubmissionStatus.initial,
    this.isRequired = false,
    this.needToUpdate = false,
    this.version = '',
  });

  VersionCheckState copyWith({
    FormzSubmissionStatus? getVersionStatus,
    bool? isRequired,
    bool? needToUpdate,
    String? version,
  }) {
    return VersionCheckState(
      getVersionStatus: getVersionStatus ?? this.getVersionStatus,
      isRequired: isRequired ?? this.isRequired,
      needToUpdate: needToUpdate ?? this.needToUpdate,
      version: version ?? this.version,
    );
  }

  @override
  List<Object> get props => [getVersionStatus, isRequired, needToUpdate, version];
}
