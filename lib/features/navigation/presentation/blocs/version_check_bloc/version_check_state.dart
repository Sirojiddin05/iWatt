part of 'version_check_bloc.dart';

class VersionCheckState extends Equatable {
  final FormzSubmissionStatus getVersionFeaturesStatus;
  final FormzSubmissionStatus getVersionStatus;
  final bool isRequired;
  final bool needToUpdate;
  final String version;
  final List<VersionFeaturesEntity> versionFeatures;

  const VersionCheckState({
    this.getVersionFeaturesStatus = FormzSubmissionStatus.initial,
    this.getVersionStatus = FormzSubmissionStatus.initial,
    this.isRequired = false,
    this.needToUpdate = false,
    this.version = '',
    this.versionFeatures = const [],
  });

  VersionCheckState copyWith({
    FormzSubmissionStatus? getVersionFeaturesStatus,
    FormzSubmissionStatus? getVersionStatus,
    bool? isRequired,
    bool? needToUpdate,
    String? version,
    List<VersionFeaturesEntity>? versionFeatures,
  }) {
    return VersionCheckState(
      getVersionFeaturesStatus: getVersionFeaturesStatus ?? this.getVersionFeaturesStatus,
      getVersionStatus: getVersionStatus ?? this.getVersionStatus,
      versionFeatures: versionFeatures ?? this.versionFeatures,
      isRequired: isRequired ?? this.isRequired,
      needToUpdate: needToUpdate ?? this.needToUpdate,
      version: version ?? this.version,
    );
  }

  @override
  List<Object> get props => [
        getVersionFeaturesStatus,
        getVersionStatus,
        versionFeatures,
        isRequired,
        needToUpdate,
        version,
      ];
}
