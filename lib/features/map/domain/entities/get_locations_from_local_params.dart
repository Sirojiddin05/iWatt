class GetLocationsFromLocalParams {
  const GetLocationsFromLocalParams({
    this.locationIds = const [],
    this.northEastLatitude = -1,
    this.northEastLongitude = -1,
    this.southWestLatitude = -1,
    this.southWestLongitude = -1,
  });

  final List<int> locationIds;
  final double northEastLatitude;
  final double northEastLongitude;
  final double southWestLatitude;
  final double southWestLongitude;

  ({String conditions, List<dynamic> args}) generateQuery() {
    final List<String> conditions = [];
    final List<dynamic> args = [];

    if (locationIds.isNotEmpty) {
      conditions.add('id IN (${locationIds.map((_) => '?').join(', ')})');
      args.addAll(locationIds);
    }
    if (northEastLatitude != -1 && northEastLongitude != -1 && southWestLatitude != -1 && southWestLongitude != -1) {
      conditions.add('latitude BETWEEN ? AND ? AND longitude BETWEEN ? AND ?');
      args.addAll([
        southWestLatitude,
        northEastLatitude,
        southWestLongitude,
        northEastLongitude,
      ]);
    }
    final whereClause = conditions.isNotEmpty ? 'WHERE ${conditions.join(' AND ')}' : '';
    return (conditions: whereClause, args: args);
  }
}
