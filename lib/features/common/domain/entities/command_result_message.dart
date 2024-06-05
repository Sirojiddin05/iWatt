class CommandResultMessageEntity {
  final int commandId;
  final bool status;
  final String commandType;

  const CommandResultMessageEntity({
    this.commandId = -1,
    this.status = false,
    this.commandType = '',
  });
}
