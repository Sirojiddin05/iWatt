class GetChargeLocationParamEntity {
  final bool isFavourite;
  final List<int> powerType;
  final List<int> connectorType;
  final String searchPattern;
  final String next;
  final int zoom;
  final double longitude;
  final double latitude;

  const GetChargeLocationParamEntity({
    this.isFavourite = false,
    this.powerType = const [],
    this.connectorType = const [],
    this.next = '',
    this.searchPattern = '',
    this.zoom = -1,
    this.longitude = -1,
    this.latitude = -1,
  });
  Map<String, dynamic> toJson() {
    Map<String, dynamic> params = {};
    if (isFavourite) {
      params.putIfAbsent('favorite_address', () => isFavourite);
    }
    if (searchPattern.isNotEmpty) {
      params.putIfAbsent('search', () => searchPattern);
    }
    if (zoom != -1) {
      params.putIfAbsent('zoom', () => zoom);
    }
    if (longitude != -1 && latitude != -1) {
      params.putIfAbsent('user_latitude', () => latitude);
      params.putIfAbsent('user_longitude', () => longitude);
    }
    if (powerType.isNotEmpty) {
      String power = '';
      for (final powerGroup in powerType) {
        power = power + powerGroup.toString();
        if (powerGroup != powerType.last) power = '$power,';
      }
      params.putIfAbsent('max_electric_powers', () => power);
    }
    if (connectorType.isNotEmpty) {
      String connector = '';
      for (final type in connectorType) {
        connector = connector + type.toString();
        if (type != connectorType.last) connector = '$connector,';
      }
      params.putIfAbsent('type_connection', () => connector);
    }
    return params;
  }
}
