class ClusterEntity {
  final int id;
  final int count;
  final String quadkey;
  final double avgLongitude;
  final double avgLatitude;

  const ClusterEntity({
    this.id = -1,
    this.count = -1,
    this.quadkey = '',
    this.avgLongitude = -1,
    this.avgLatitude = -1,
  });
}
