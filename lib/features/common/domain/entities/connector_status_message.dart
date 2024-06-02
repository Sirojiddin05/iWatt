class ConnectorStatusMessageEntity {
  final int connectorId;
  final String status;

  const ConnectorStatusMessageEntity({
    this.connectorId = -1,
    this.status = '',
  });
}
