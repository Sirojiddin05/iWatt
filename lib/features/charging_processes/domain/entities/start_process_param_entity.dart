class StartProcessParamEntity {
  final int connectionId;
  final bool isLimited;

  const StartProcessParamEntity({
    required this.connectionId,
    this.isLimited = false,
  });
}
