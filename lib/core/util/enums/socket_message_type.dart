enum SocketType {
  connector,
  meter_values_data,
  command_result,
  transaction_cheque;

  bool get isConnector => this == SocketType.connector;
  bool get isMeterValuesData => this == SocketType.meter_values_data;
  bool get isCommandResult => this == SocketType.command_result;
  bool get isTransactionCheque => this == SocketType.transaction_cheque;
}
