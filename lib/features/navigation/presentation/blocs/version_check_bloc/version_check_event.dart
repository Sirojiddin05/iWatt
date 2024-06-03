part of 'version_check_bloc.dart';

@immutable
abstract class VersionCheckEvent {}

class GetVersionEvent implements VersionCheckEvent {}

class GetVersionFeaturesEvent implements VersionCheckEvent {
  final int versionId;

  GetVersionFeaturesEvent(this.versionId);
}
