class VersionEntity {
  final String androidVersion;
  final bool androidRequired;
  final String iosVersion;
  final bool iosRequired;

  const VersionEntity(
      {this.androidVersion = '', this.androidRequired = false, this.iosVersion = '', this.iosRequired = false});
}
