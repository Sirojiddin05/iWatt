class VersionEntity {
  final int id;
  final String number;
  final String platformType;
  final bool isForceUpdate;

  const VersionEntity({
    this.id = -1,
    this.number = '',
    this.platformType = '',
    this.isForceUpdate = false,
  });
}
