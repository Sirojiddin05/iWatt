class GetChargeLocationParamEntity {
  const GetChargeLocationParamEntity({
    this.isFavourite = false,
    this.powerType = const [],
    this.connectorType = const [],
    this.vendors = const [],
    this.next = '',
    this.searchPattern = '',
    this.longitude = -1,
    this.latitude = -1,
    this.isForMap = false,
  });

  final bool isFavourite;
  final List<int> powerType;
  final List<int> connectorType;
  final List<int> vendors;
  final String searchPattern;
  final String next;
  final double longitude;
  final double latitude;
  final bool isForMap;

  Map<String, dynamic> toJson() {
    Map<String, dynamic> params = {};
    // if (isFavourite) {
    //   params.putIfAbsent('favorite_address', () => isFavourite);
    // }
    if (searchPattern.isNotEmpty) {
      params.putIfAbsent('search', () => searchPattern);
    }
    if (longitude != -1 && latitude != -1 && !isForMap) {
      params.putIfAbsent('user_latitude', () => latitude);
      params.putIfAbsent('user_longitude', () => longitude);
    }
    if (powerType.isNotEmpty) {
      String power = powerType.join(', ');
      params.putIfAbsent('max_electric_powers', () => power);
    }
    if (connectorType.isNotEmpty) {
      String connector = connectorType.join(', ');
      params.putIfAbsent('type_connection', () => connector);
    }
    if (vendors.isNotEmpty) {
      String vendor = vendors.join(', ');
      params.putIfAbsent('vendors', () => vendor);
    }
    return params;
  }
}
